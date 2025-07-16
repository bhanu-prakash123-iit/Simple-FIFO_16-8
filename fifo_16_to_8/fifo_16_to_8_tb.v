module fifo_16_to_8_tb();
  reg clk,rst,we,re;
  reg [3:0] w_addr,r_addr;
  reg [7:0] din;
  wire [7:0] dout;
  integer i;


  fifo_16_to_8 uut (
    .clk(clk),
    .rst(rst),
    .we(we),
    .re(re),
    .w_addr(w_addr),
    .r_addr(r_addr),
    .din(din),
    .dout(dout)
  );

  initial clk = 0;
  always #5 clk = ~clk; // Clock period of 10 time units

  //reset task
  task reset();
    begin
      @(negedge clk);
      rst = 1; // Assert reset
      we = 0;re = 0;
      @(negedge clk);
      rst =0; // Deassert reset
    end
  endtask

  //write task
  task data_write(input [7:0] val, input [3:0] addr);
    begin
      @(negedge clk);
      din = val;  // Data to write
      w_addr = addr; // Write address
      we = 1; // Assert write enable
      @(negedge clk);
      we = 0; // Deassert write enable
    end
  endtask
  
  //read task and check
  task data_read_and_check(input [3:0] addr, input [7:0] expected_val);
    begin
      @(negedge clk);
      r_addr = addr; // Read address
      re = 1; // Assert read enable
      @(negedge clk);
      re = 0; // Deassert read enable

      @(posedge clk);
      if(dout !== expected_val) begin
        $display("Error: Expected %h at address %h, got %h", expected_val, addr, dout);
      end else begin
        $display("Read successful: Address %h, Value %h", addr, dout);
      end
    end
  endtask

  //test sequence
  initial begin
    rst = 0;
    we =0;
    re = 0;
    w_addr = 0;
    r_addr = 0;
    din = 0;
    
    reset();

    // Write data to FIFO
    for(i=0;i<16;i=i+1) begin
      data_write(i[7:0], i[3:0]);
    end

    // Read data from FIFO and check
    for(i=0;i<16;i=i+1) begin
      data_read_and_check(i[3:0], i[7:0]);
    end

    #20
    $display("Test completed successfully.");
    $finish;
  end
endmodule
