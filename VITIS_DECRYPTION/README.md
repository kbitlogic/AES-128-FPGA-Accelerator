# AES-128 Decryption – Vitis HLS Integration

## Overview

This folder contains the Vitis HLS files used to integrate the AES-128 Decryption RTL core with the Zynq Processing System through an AXI4-Lite interface.

The RTL decryption engine is imported as a black-box module and packaged as an IP core for use in Vivado.

## Objective

The objective of using Vitis HLS is to:

- Create AXI4-Lite control and data interfaces
- Connect the RTL decryption core to the Zynq processor
- Package the design as a reusable IP core
- Enable software control through Python and Jupyter Notebook

## Files Included

- aes_wrapper.cpp
- aes_wrapper.hpp
- aes_blackbox.cpp
- aes_blackbox.hpp
- aes_hls_wrapper.json
- hls_config.cfg

## Implementation Procedure

### Step 1: Create Decryption Wrapper

A C++ wrapper function was created to expose the decryption engine inputs and outputs.

Inputs:
- 128-bit Ciphertext
- 128-bit Secret Key

Outputs:
- 128-bit Plaintext

Control:
- AP_START
- AP_DONE

### Step 2: Configure AXI4-Lite Interface

AXI4-Lite registers were generated for:

- Ciphertext Input Registers
- Key Registers
- Plaintext Output Registers
- Control Register
- Status Register

This enables communication between the ARM processor and FPGA accelerator.

### Step 3: Black Box Integration

The RTL decryption core was integrated using:

- aes_blackbox.cpp
- aes_blackbox.hpp
- aes_hls_wrapper.json

The RTL is treated as a hardware black box while Vitis HLS generates the required interfaces.

### Step 4: Configure HLS Project

Configuration parameters:

- Top Function: aes_wrapper
- Target Device: xc7z020clg400-1
- Output Format: IP Catalog

### Step 5: HLS Synthesis

Vitis HLS synthesizes the wrapper and generates:

- AXI4-Lite interfaces
- IP packaging files
- Hardware metadata

### Step 6: Export IP

The generated IP is exported to the Vivado IP Catalog and integrated into the Zynq block design.

## Design Flow

AES Decryption RTL
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
Vivado Block Design
↓
PYNQ-Z2 FPGA

## Verification

The generated IP was tested on the PYNQ-Z2 FPGA using Jupyter Notebook.

Example Verification:

Ciphertext:
0x6A84D4B3
0xDBCDB780
0x7DABC55A

Recovered Plaintext:
0x00112233
0x44556677
0x8899AABB
0xCCDDEEFF

Verification Status: PASS ✓

## Tools Used

- Vitis HLS 2026.1
- Vivado Design Suite
- Python
- Jupyter Notebook

## Target Platform

- PYNQ-Z2 FPGA
- Zynq-7000 XC7Z020

## Author

Kamalesh Parasurama
Major Project B – High-Speed AES Encryption Engine
