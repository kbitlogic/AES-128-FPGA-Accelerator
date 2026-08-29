# RTL Design Files

This folder contains the Register Transfer Level (RTL) implementation of the AES-128 Encryption and Decryption Engine.

## Modules Included
- AES Encryption Core
- Key Expansion Module
- S-Box and Inverse S-Box
- ShiftRows and Inverse ShiftRows
- MixColumns and Inverse MixColumns
- AddRoundKey Module
- Supporting Control Logic

## Description
The AES-128 algorithm is implemented in Verilog HDL. The design performs encryption and decryption of 128-bit data blocks using a 128-bit secret key.

The RTL design was verified through simulation in Vivado before being integrated into the FPGA implementation flow.

## Tools Used
- Verilog HDL
- Xilinx Vivado Simulator

## Target Platform
- PYNQ-Z2 FPGA (Zynq-7000 SoC)
