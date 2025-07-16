module fifo_16_to_8 (
  input clk,rst,we,re,
  input [3:0] w_addr,r_addr,
  input [7:0] din,
  output reg [7:0] dout);
 
  reg [7:0] mem[0:15]; // 16x8 FIFO memory
  integer i;

  always @(posedge clk) begin
    if(rst) begin
      for(i=0;i<16;i=i+1) begin
        mem[i] <= 8'b0; // Reset memory
      end
    end

    else if(we) begin
      mem[w_addr] <= din; // write data to memory
    end
  end

  always @(posedge clk) begin
    if(rst) begin
      dout <= 8'b0; //reset output 
    end
    else if(re) begin
      dout <= mem[r_addr]; //read memory
    end
  end

endmodule
