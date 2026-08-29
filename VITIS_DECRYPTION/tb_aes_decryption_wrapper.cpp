#include <iostream>
#include <iomanip>

#include "aes_decryption_wrapper.hpp"

int main()
{
    // NIST AES-128 Test Vector
    // Ciphertext:
    // 69C4E0D86A7B0430D8CDB78070B4C55A
    // Key:
    // 000102030405060708090A0B0C0D0E0F
    // Expected Plaintext:
    // 00112233445566778899AABBCCDDEEFF

    uint32_hls ciphertext_0 = 0x69C4E0D8;
    uint32_hls ciphertext_1 = 0x6A7B0430;
    uint32_hls ciphertext_2 = 0xD8CDB780;
    uint32_hls ciphertext_3 = 0x70B4C55A;

    uint32_hls key_0 = 0x00010203;
    uint32_hls key_1 = 0x04050607;
    uint32_hls key_2 = 0x08090A0B;
    uint32_hls key_3 = 0x0C0D0E0F;

    uint32_hls plaintext_0 = 0;
    uint32_hls plaintext_1 = 0;
    uint32_hls plaintext_2 = 0;
    uint32_hls plaintext_3 = 0;

    aes_decryption_wrapper(
        ciphertext_0,
        ciphertext_1,
        ciphertext_2,
        ciphertext_3,
        key_0,
        key_1,
        key_2,
        key_3,
        plaintext_0,
        plaintext_1,
        plaintext_2,
        plaintext_3
    );

    std::cout << std::hex
              << std::uppercase
              << std::setfill('0');

    std::cout << "Plaintext = "
              << std::setw(8) << plaintext_0.to_uint()
              << std::setw(8) << plaintext_1.to_uint()
              << std::setw(8) << plaintext_2.to_uint()
              << std::setw(8) << plaintext_3.to_uint()
              << std::endl;

    return 0;
}