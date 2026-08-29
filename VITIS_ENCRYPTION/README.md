# Vitis HLS Integration

This folder contains the files used to integrate the AES RTL design with the FPGA system through Vitis HLS.

## Purpose

Vitis HLS was used to create an AXI4-Lite interface for the AES hardware accelerator and package the design as a reusable IP core for Vivado.

## Files Included

- aes_wrapper.cpp
- aes_wrapper.hpp
- aes_blackbox.cpp
- aes_blackbox.hpp
- aes_hls_wrapper.json
- hls_config.cfg

## Implementation Procedure

### Step 1: Create AES Wrapper
A C++ wrapper function was developed to expose the AES encryption/decryption module inputs, outputs, and control signals.

### Step 2: Define Hardware Interfaces
AXI4-Lite interfaces were added for:
- Plaintext/Ciphertext registers
- Key registers
- Control register (AP_START)
- Status register (AP_DONE)

### Step 3: Black Box Integration
The Verilog RTL AES implementation was connected to Vitis HLS using:
- `aes_blackbox.cpp`
- `aes_blackbox.hpp`
- `aes_hls_wrapper.json`

This allowed the RTL design to be treated as a hardware black box while generating the required system interfaces.

### Step 4: Configure HLS Project
The HLS configuration file specifies:
- Top function: `aes_wrapper`
- Target FPGA device: `xc7z020clg400-1`
- Output format: IP Catalog

### Step 5: Synthesis and IP Generation
Vitis HLS synthesizes the wrapper and generates:
- AXI4-Lite interfaces
- IP packaging files
- Hardware metadata

### Step 6: Export IP
The generated IP is exported and added to the Vivado IP Catalog for system integration.

## Design Flow

RTL AES Core
↓
Wrapper Function
↓
Black Box Integration
↓
AXI4-Lite Interface Generation
↓
Vitis HLS Synthesis
↓
IP Packaging
↓
Vivado Integration

## Tools Used

- Xilinx Vitis HLS 2026.1
- Vivado Design Suite

## Target Platform

- PYNQ-Z2 FPGA
- Zynq-7000 SoC (XC7Z020)
