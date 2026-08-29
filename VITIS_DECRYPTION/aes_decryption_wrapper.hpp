// aes_decryption_wrapper.hpp

#ifndef AES_DECRYPTION_WRAPPER_HPP
#define AES_DECRYPTION_WRAPPER_HPP

#include "ap_int.h"

typedef ap_uint<32> uint32_hls;

void aes_decryption_wrapper(
    uint32_hls ciphertext_0,
    uint32_hls ciphertext_1,
    uint32_hls ciphertext_2,
    uint32_hls ciphertext_3,

    uint32_hls key_0,
    uint32_hls key_1,
    uint32_hls key_2,
    uint32_hls key_3,

    uint32_hls &plaintext_0,
    uint32_hls &plaintext_1,
    uint32_hls &plaintext_2,
    uint32_hls &plaintext_3
);

#endif