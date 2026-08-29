# AES-128 FPGA Accelerator

## Overview
This project implements AES-128 Encryption and Decryption as a hardware accelerator on the PYNQ-Z2 FPGA platform.

## Features
- AES-128 Encryption
- AES-128 Decryption
- Key Expansion
- AXI4-Lite Interface
- FPGA Hardware Acceleration
- Python/Jupyter Control Interface

## Tools Used
- Verilog HDL
- Vivado
- Vitis HLS
- Python
- Jupyter Notebook
- PYNQ-Z2 FPGA

## Design Flow
RTL → Simulation → Wrapper → Vitis HLS → AXI Interface → Vivado → Bitstream → PYNQ-Z2 → Jupyter

## Results

| Operation | Latency (µs) | Throughput (Mbps) |
|------------|-------------|------------------|
| Encryption | 156.01 | 0.820 |
| Decryption | 150.67 | 0.849 |

## Author
Kamalesh Parasurama
