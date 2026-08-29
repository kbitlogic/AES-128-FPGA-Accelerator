# AES-128 Decryption RTL Design

## Overview

This folder contains the Verilog RTL implementation of the AES-128 Decryption Engine.

The decryption module performs the reverse operations of AES encryption to recover the original plaintext from the ciphertext using the same 128-bit secret key.

## AES-128 Decryption Flow

Ciphertext
↓
AddRoundKey
↓
Inverse ShiftRows
↓
Inverse SubBytes
↓
Inverse MixColumns
↓
Round Key Addition
↓
Recovered Plaintext

## Modules Included

- AES Decryption Core
- Key Expansion Module
- Inverse S-Box (InvSubBytes)
- Inverse ShiftRows
- Inverse MixColumns
- AddRoundKey
- Control Logic

## Working Principle

AES-128 decryption consists of 10 rounds.

### Initial Round
- AddRoundKey using the last round key

### Rounds 9 to 1
- Inverse ShiftRows
- Inverse SubBytes
- AddRoundKey
- Inverse MixColumns

### Final Round
- Inverse ShiftRows
- Inverse SubBytes
- AddRoundKey

The output of the final round is the original 128-bit plaintext.

## Verification

The RTL design was verified using Vivado simulation with standard AES-128 test vectors.

### Example Test Vector

Ciphertext:
0x6A84D4B3
0xDBCDB780
0x7DABC55A
...

Recovered Plaintext:
0x00112233
0x44556677
0x8899AABB
0xCCDDEEFF

Verification Status:
PASS ✓

## Tools Used

- Verilog HDL
- Xilinx Vivado Simulator

## Target Platform

- PYNQ-Z2 FPGA
- Xilinx Zynq-7000 (XC7Z020)

## Author

Kamalesh Parasurama
Major Project B – AES-128 FPGA Accelerator
