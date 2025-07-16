FIFO 16x8 Design & Testbench

## 🧠 Description
This module implements a simple **16x8 FIFO** memory system in Verilog. It supports:
- Synchronous write and read
- Reset capability
- Separate read and write addresses
- Fully verified using a testbench

## 📁 Files
- `fifo_16_to_8.v` – RTL module
- `fifo_16_to_8_tb.v` – Testbench to simulate write/read operations

## 📷 Waveform 
<img width="1918" height="917" alt="image" src="https://github.com/user-attachments/assets/f854bd4f-c050-408c-8386-0df6b8237ba0" />
<img width="992" height="382" alt="image" src="https://github.com/user-attachments/assets/907bdac7-922f-4ab0-a802-6d857539e8d0" />



## ✅ Features Tested
- Reset clears all memory and output
- Writes all 16 memory locations
- Reads and verifies all data back

## 🛠️ Simulation Instructions (ModelSim example)
```bash
vlog fifo_16_to_8.v fifo_16_to_8_tb.v
vsim fifo_16_to_8_tb
run -all
