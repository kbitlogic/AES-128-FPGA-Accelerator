#ifndef AES_BLACKBOX_HPP
#define AES_BLACKBOX_HPP

#include <ap_int.h>

typedef ap_uint<32> uint32_t_hls;

#ifdef __cplusplus
extern "C" {
#endif

void aes_blackbox(
    uint32_t_hls plaintext_0,
    uint32_t_hls plaintext_1,
    uint32_t_hls plaintext_2,
    uint32_t_hls plaintext_3,
    uint32_t_hls key_0,
    uint32_t_hls key_1,
    uint32_t_hls key_2,
    uint32_t_hls key_3,
    uint32_t_hls &ciphertext_0,
    uint32_t_hls &ciphertext_1,
    uint32_t_hls &ciphertext_2,
    uint32_t_hls &ciphertext_3
);

#ifdef __cplusplus
}
#endif

#endif