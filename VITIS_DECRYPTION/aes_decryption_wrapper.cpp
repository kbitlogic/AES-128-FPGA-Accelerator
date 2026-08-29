#include "aes_decryption_wrapper.hpp"
#include "aes_decryption_blackbox.hpp"

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
)
{
#pragma HLS INTERFACE s_axilite port=ciphertext_0 bundle=CTRL
#pragma HLS INTERFACE s_axilite port=ciphertext_1 bundle=CTRL
#pragma HLS INTERFACE s_axilite port=ciphertext_2 bundle=CTRL
#pragma HLS INTERFACE s_axilite port=ciphertext_3 bundle=CTRL

#pragma HLS INTERFACE s_axilite port=key_0 bundle=CTRL
#pragma HLS INTERFACE s_axilite port=key_1 bundle=CTRL
#pragma HLS INTERFACE s_axilite port=key_2 bundle=CTRL
#pragma HLS INTERFACE s_axilite port=key_3 bundle=CTRL

#pragma HLS INTERFACE s_axilite port=plaintext_0 bundle=CTRL
#pragma HLS INTERFACE s_axilite port=plaintext_1 bundle=CTRL
#pragma HLS INTERFACE s_axilite port=plaintext_2 bundle=CTRL
#pragma HLS INTERFACE s_axilite port=plaintext_3 bundle=CTRL

#pragma HLS INTERFACE s_axilite port=return bundle=CTRL

    uint32_hls local_plaintext_0;
    uint32_hls local_plaintext_1;
    uint32_hls local_plaintext_2;
    uint32_hls local_plaintext_3;

    aes_decryption_blackbox(
        ciphertext_0,
        ciphertext_1,
        ciphertext_2,
        ciphertext_3,
        key_0,
        key_1,
        key_2,
        key_3,
        local_plaintext_0,
        local_plaintext_1,
        local_plaintext_2,
        local_plaintext_3
    );

    plaintext_0 = local_plaintext_0;
    plaintext_1 = local_plaintext_1;
    plaintext_2 = local_plaintext_2;
    plaintext_3 = local_plaintext_3;
}