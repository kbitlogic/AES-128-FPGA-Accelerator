#include <iostream>
#include <iomanip>

#include "aes_wrapper.hpp"

int main()
{
    // FIPS-197 Appendix B known-answer test vector
    // Plaintext : 00112233 44556677 8899aabb ccddeeff
    // Key       : 000102030405060708090a0b0c0d0e0f
    // Expected ciphertext: 69c4e0d8 6a7b0430 d8cdb780 70b4c55a

    uint32_hls plaintext_0 = 0x00112233;
    uint32_hls plaintext_1 = 0x44556677;
    uint32_hls plaintext_2 = 0x8899aabb;
    uint32_hls plaintext_3 = 0xccddeeff;

    uint32_hls key_0 = 0x00010203;
    uint32_hls key_1 = 0x04050607;
    uint32_hls key_2 = 0x08090a0b;
    uint32_hls key_3 = 0x0c0d0e0f;

    uint32_hls ciphertext_0, ciphertext_1, ciphertext_2, ciphertext_3;

    aes_wrapper(
        plaintext_0, plaintext_1, plaintext_2, plaintext_3,
        key_0, key_1, key_2, key_3,
        ciphertext_0, ciphertext_1, ciphertext_2, ciphertext_3
    );

    std::cout << std::hex << std::setfill('0');
    std::cout << "Ciphertext = "
               << std::setw(8) << ciphertext_0.to_uint()
               << std::setw(8) << ciphertext_1.to_uint()
               << std::setw(8) << ciphertext_2.to_uint()
               << std::setw(8) << ciphertext_3.to_uint()
               << std::endl;

    std::cout << "Expected   = 69c4e0d86a7b0430d8cdb78070b4c55a" << std::endl;

    return 0;
}