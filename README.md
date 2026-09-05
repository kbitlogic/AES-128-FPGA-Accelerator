AES-128 Hardware Encryption Engine

<p align="center">
  <img src="images/architecture/aes_block_diagram.jpeg" width="900">
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Language-Verilog-blue.svg">
  <img src="https://img.shields.io/badge/Tool-Xilinx%20Vivado-red.svg">
  <img src="https://img.shields.io/badge/Algorithm-AES--128-green.svg">
  <img src="https://img.shields.io/badge/Status-Ongoing-orange.svg">
  <img src="https://img.shields.io/badge/License-MIT-yellow.svg">
</p>

> *A modular RTL implementation of the AES-128 encryption algorithm in Verilog HDL, verified using Xilinx Vivado and validated against the FIPS-197 Known Answer Test (KAT).*

---

# Overview

This project implements the *AES-128 (Advanced Encryption Standard)* encryption algorithm in *Verilog HDL* using a modular Register Transfer Level (RTL) design methodology. The implementation follows the *FIPS-197* AES specification, with each cryptographic transformation developed as an independent hardware module and integrated into a complete encryption datapath.

The design emphasizes modularity, hierarchical hardware organization, and functional verification using *Xilinx Vivado*. Individual RTL modules have been verified through simulation before integration into the complete encryption engine. The project serves as a practical implementation of digital design, computer architecture, and hardware security concepts while providing a scalable foundation for future FPGA deployment and hardware acceleration.

---

# Key Features

- Modular AES-128 encryption engine implemented in Verilog HDL
- Hierarchical RTL architecture
- Independent implementation of all AES transformation modules
- AES-128 compliant encryption flow
- Hardware implementation of:
  - SubBytes
  - ShiftRows
  - MixColumns
  - AddRoundKey
  - Key Expansion
- Functional verification using Xilinx Vivado
- Verification using the standard AES-128 Known Answer Test (KAT)
- Clean modular RTL hierarchy suitable for FPGA implementation

---

# Tools & Technologies

| Category | Technology |
|----------|------------|
| HDL | Verilog |
| Design Tool | Xilinx Vivado |
| Verification | Vivado Functional Simulation |
| Encryption Standard | AES-128 (FIPS-197) |
| Future Target | FPGA Implementation |

---

# AES-128 Encryption Flow

The implemented encryption engine performs the following sequence:


Plaintext
     │
     ▼
Initial AddRoundKey
     │
     ▼
9 Encryption Rounds
 ├── SubBytes
 ├── ShiftRows
 ├── MixColumns
 └── AddRoundKey
     │
     ▼
Final Round
 ├── SubBytes
 ├── ShiftRows
 └── AddRoundKey
     │
     ▼
Ciphertext


---

# RTL Hardware Architecture

The AES encryption engine follows a hierarchical RTL implementation in Verilog HDL. The top-level module integrates the Key Expansion unit with the encryption datapath consisting of SubBytes, ShiftRows, MixColumns, and AddRoundKey transformations.

<p align="center">
  <img src="images/architecture/aes_schematic.png" width="950">
</p>

---

# Key Expansion Architecture

The Key Expansion module generates the eleven round keys required throughout the AES-128 encryption process by applying byte substitution, word rotation, round constants, and XOR operations.

<p align="center">
  <img src="images/architecture/key_expansion_block_diagram.jpeg" width="850">
</p>

---

# Core RTL Modules

## Key Expansion

Generates the complete AES-128 key schedule used by every encryption round.

<p align="center">
  <img src="images/modules/aes_key_expansion.png" width="700">
</p>

---

## SubBytes

Implements the nonlinear byte substitution stage using the AES S-Box.

<p align="center">
  <img src="images/modules/aes_sub_bytes.png" width="700">
</p>

---

## MixColumns

Performs Galois Field (GF(2⁸)) matrix multiplication to provide diffusion across each column of the AES state matrix.

<p align="center">
  <img src="images/modules/aes_mix_columns.png" width="700">
</p>

---

# Functional Verification

The AES-128 encryption engine was functionally verified in *Xilinx Vivado* using the standard *AES-128 Known Answer Test (KAT)* specified in *FIPS-197*.

| Parameter | Value |
|-----------|-------|
| Plaintext | 00112233445566778899aabbccddeeff |
| Encryption Key | 000102030405060708090a0b0c0d0e0f |
| Expected Ciphertext | 69c4e0d86a7b0430d8cdb78070b4c55a |

The generated ciphertext matches the expected reference output exactly, confirming the correct implementation of all AES-128 encryption stages, including Key Expansion, SubBytes, ShiftRows, MixColumns, and AddRoundKey.

### Vivado Functional Simulation

<p align="center">
  <img src="images/simulation/aes_vivado_simulation.png" width="950">
</p>

---

# Project Structure


aes128-hardware-encryption-engine
│
├── docs
│   ├── architecture.md
│   ├── verification.md
│   └── roadmap.md
│
├── hardware
│   └── verilog
│
├── images
│   ├── architecture
│   ├── modules
│   ├── references
│   └── simulation
│
├── testbench
├── test_vectors
│
├── README.md
├── LICENSE
└── .gitignore


---

## Results

| Operation | Latency (µs) | Throughput (Mbps) |
|------------|-------------|------------------|
| Encryption | 156.01 | 0.820 |
| Decryption | 150.67 | 0.849 |


# Future Work

- FPGA implementation and hardware validation
- Timing analysis and synthesis optimization
- SystemVerilog/UVM-based verification environment
- Throughput and resource utilization analysis
- Support for AES decryption
- Parameterizable AES architecture for multiple key lengths

---

# License

This project is licensed under the *MIT License* 

## Author
Kamalesh Parasurama
