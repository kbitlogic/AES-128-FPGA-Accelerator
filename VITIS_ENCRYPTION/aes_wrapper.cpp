#include "aes_wrapper.hpp"
#include "aes_blackbox.hpp"

void aes_wrapper(
    uint32_hls plaintext_0, uint32_hls plaintext_1, uint32_hls plaintext_2, uint32_hls plaintext_3,
    uint32_hls key_0, uint32_hls key_1, uint32_hls key_2, uint32_hls key_3,
    uint32_hls &ciphertext_0, uint32_hls &ciphertext_1, uint32_hls &ciphertext_2, uint32_hls &ciphertext_3
)
{
#pragma HLS INTERFACE ap_none port=plaintext_0
#pragma HLS INTERFACE ap_none port=plaintext_1
#pragma HLS INTERFACE ap_none port=plaintext_2
#pragma HLS INTERFACE ap_none port=plaintext_3
#pragma HLS INTERFACE ap_none port=key_0
#pragma HLS INTERFACE ap_none port=key_1
#pragma HLS INTERFACE ap_none port=key_2
#pragma HLS INTERFACE ap_none port=key_3
#pragma HLS INTERFACE ap_vld  port=ciphertext_0
#pragma HLS INTERFACE ap_vld  port=ciphertext_1
#pragma HLS INTERFACE ap_vld  port=ciphertext_2
#pragma HLS INTERFACE ap_vld  port=ciphertext_3
#pragma HLS INTERFACE ap_ctrl_chain port=return

    uint32_hls local_ciphertext_0, local_ciphertext_1, local_ciphertext_2, local_ciphertext_3;

    aes_blackbox(
        plaintext_0, plaintext_1, plaintext_2, plaintext_3,
        key_0, key_1, key_2, key_3,
        local_ciphertext_0, local_ciphertext_1, local_ciphertext_2, local_ciphertext_3
    );

    ciphertext_0 = local_ciphertext_0;
    ciphertext_1 = local_ciphertext_1;
    ciphertext_2 = local_ciphertext_2;
    ciphertext_3 = local_ciphertext_3;
}
