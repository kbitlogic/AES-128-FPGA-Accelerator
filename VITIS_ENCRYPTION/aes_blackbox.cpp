#include "aes_blackbox.hpp"

// Bit-accurate AES-128 golden reference model, used for C simulation and as
// the comparison reference during C/RTL co-simulation. This must implement
// the exact same AES-128 algorithm as the RTL (AES.v and its submodules) so
// that co-simulation actually validates the RTL, instead of comparing against
// an empty/undefined reference.

static const unsigned char AES_SBOX[256] = {
    0x63, 0x7c, 0x77, 0x7b, 0xf2, 0x6b, 0x6f, 0xc5, 0x30, 0x01, 0x67, 0x2b, 0xfe, 0xd7, 0xab, 0x76,
    0xca, 0x82, 0xc9, 0x7d, 0xfa, 0x59, 0x47, 0xf0, 0xad, 0xd4, 0xa2, 0xaf, 0x9c, 0xa4, 0x72, 0xc0,
    0xb7, 0xfd, 0x93, 0x26, 0x36, 0x3f, 0xf7, 0xcc, 0x34, 0xa5, 0xe5, 0xf1, 0x71, 0xd8, 0x31, 0x15,
    0x04, 0xc7, 0x23, 0xc3, 0x18, 0x96, 0x05, 0x9a, 0x07, 0x12, 0x80, 0xe2, 0xeb, 0x27, 0xb2, 0x75,
    0x09, 0x83, 0x2c, 0x1a, 0x1b, 0x6e, 0x5a, 0xa0, 0x52, 0x3b, 0xd6, 0xb3, 0x29, 0xe3, 0x2f, 0x84,
    0x53, 0xd1, 0x00, 0xed, 0x20, 0xfc, 0xb1, 0x5b, 0x6a, 0xcb, 0xbe, 0x39, 0x4a, 0x4c, 0x58, 0xcf,
    0xd0, 0xef, 0xaa, 0xfb, 0x43, 0x4d, 0x33, 0x85, 0x45, 0xf9, 0x02, 0x7f, 0x50, 0x3c, 0x9f, 0xa8,
    0x51, 0xa3, 0x40, 0x8f, 0x92, 0x9d, 0x38, 0xf5, 0xbc, 0xb6, 0xda, 0x21, 0x10, 0xff, 0xf3, 0xd2,
    0xcd, 0x0c, 0x13, 0xec, 0x5f, 0x97, 0x44, 0x17, 0xc4, 0xa7, 0x7e, 0x3d, 0x64, 0x5d, 0x19, 0x73,
    0x60, 0x81, 0x4f, 0xdc, 0x22, 0x2a, 0x90, 0x88, 0x46, 0xee, 0xb8, 0x14, 0xde, 0x5e, 0x0b, 0xdb,
    0xe0, 0x32, 0x3a, 0x0a, 0x49, 0x06, 0x24, 0x5c, 0xc2, 0xd3, 0xac, 0x62, 0x91, 0x95, 0xe4, 0x79,
    0xe7, 0xc8, 0x37, 0x6d, 0x8d, 0xd5, 0x4e, 0xa9, 0x6c, 0x56, 0xf4, 0xea, 0x65, 0x7a, 0xae, 0x08,
    0xba, 0x78, 0x25, 0x2e, 0x1c, 0xa6, 0xb4, 0xc6, 0xe8, 0xdd, 0x74, 0x1f, 0x4b, 0xbd, 0x8b, 0x8a,
    0x70, 0x3e, 0xb5, 0x66, 0x48, 0x03, 0xf6, 0x0e, 0x61, 0x35, 0x57, 0xb9, 0x86, 0xc1, 0x1d, 0x9e,
    0xe1, 0xf8, 0x98, 0x11, 0x69, 0xd9, 0x8e, 0x94, 0x9b, 0x1e, 0x87, 0xe9, 0xce, 0x55, 0x28, 0xdf,
    0x8c, 0xa1, 0x89, 0x0d, 0xbf, 0xe6, 0x42, 0x68, 0x41, 0x99, 0x2d, 0x0f, 0xb0, 0x54, 0xbb, 0x16,
};

static const unsigned char AES_RCON[11] = {
    0x00, 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x1B, 0x36
};

static unsigned char xtime(unsigned char a)
{
    unsigned char hi = a & 0x80;
    a = (unsigned char)(a << 1);
    if (hi) a ^= 0x1B;
    return a;
}

static unsigned char gmul(unsigned char a, unsigned char c)
{
    // only ever called with c = 1, 2, or 3 (matches bit_computation.v)
    if (c == 1) return a;
    if (c == 2) return xtime(a);
    if (c == 3) return (unsigned char)(xtime(a) ^ a);
    return 0;
}

static void key_expansion(const unsigned char key[16], unsigned char round_keys[11][16])
{
    unsigned char w[44][4];
    for (int i = 0; i < 4; i++)
        for (int j = 0; j < 4; j++)
            w[i][j] = key[4*i + j];

    for (int i = 4; i < 44; i++)
    {
        unsigned char temp[4];
        for (int j = 0; j < 4; j++) temp[j] = w[i-1][j];

        if (i % 4 == 0)
        {
            unsigned char t0 = temp[0];
            temp[0] = AES_SBOX[temp[1]];
            temp[1] = AES_SBOX[temp[2]];
            temp[2] = AES_SBOX[temp[3]];
            temp[3] = AES_SBOX[t0];
            temp[0] = (unsigned char)(temp[0] ^ AES_RCON[i/4]);
        }
        for (int j = 0; j < 4; j++)
            w[i][j] = (unsigned char)(w[i-4][j] ^ temp[j]);
    }

    for (int r = 0; r < 11; r++)
        for (int j = 0; j < 4; j++)
            for (int k = 0; k < 4; k++)
                round_keys[r][4*j + k] = w[4*r + j][k];
}

static void add_round_key(unsigned char state[16], const unsigned char round_key[16])
{
    for (int i = 0; i < 16; i++)
        state[i] = (unsigned char)(state[i] ^ round_key[i]);
}

static void sub_bytes(unsigned char state[16])
{
    for (int i = 0; i < 16; i++)
        state[i] = AES_SBOX[state[i]];
}

static void shift_rows(unsigned char state[16])
{
    unsigned char s[16];
    for (int i = 0; i < 16; i++) s[i] = state[i];
    unsigned char o[16];
    o[0]=s[0];  o[4]=s[4];  o[8]=s[8];   o[12]=s[12];
    o[1]=s[5];  o[5]=s[9];  o[9]=s[13];  o[13]=s[1];
    o[2]=s[10]; o[6]=s[14]; o[10]=s[2];  o[14]=s[6];
    o[3]=s[15]; o[7]=s[3];  o[11]=s[7];  o[15]=s[11];
    for (int i = 0; i < 16; i++) state[i] = o[i];
}

static void mix_single_column(unsigned char s0, unsigned char s1, unsigned char s2, unsigned char s3,
                               unsigned char &o0, unsigned char &o1, unsigned char &o2, unsigned char &o3)
{
    o0 = (unsigned char)(gmul(s0,2) ^ gmul(s1,3) ^ gmul(s2,1) ^ gmul(s3,1));
    o1 = (unsigned char)(gmul(s0,1) ^ gmul(s1,2) ^ gmul(s2,3) ^ gmul(s3,1));
    o2 = (unsigned char)(gmul(s0,1) ^ gmul(s1,1) ^ gmul(s2,2) ^ gmul(s3,3));
    o3 = (unsigned char)(gmul(s0,3) ^ gmul(s1,1) ^ gmul(s2,1) ^ gmul(s3,2));
}

static void mix_columns(unsigned char state[16])
{
    for (int c = 0; c < 4; c++)
    {
        unsigned char o0, o1, o2, o3;
        mix_single_column(state[4*c], state[4*c+1], state[4*c+2], state[4*c+3], o0, o1, o2, o3);
        state[4*c] = o0; state[4*c+1] = o1; state[4*c+2] = o2; state[4*c+3] = o3;
    }
}

extern "C"
{
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
)
{
    unsigned char state[16];
    unsigned char key[16];

    uint32_t_hls pwords[4] = {plaintext_0, plaintext_1, plaintext_2, plaintext_3};
    uint32_t_hls kwords[4] = {key_0, key_1, key_2, key_3};

    for (int i = 0; i < 4; i++)
    {
        state[4*i]   = (unsigned char)((pwords[i] >> 24) & 0xFF);
        state[4*i+1] = (unsigned char)((pwords[i] >> 16) & 0xFF);
        state[4*i+2] = (unsigned char)((pwords[i] >> 8)  & 0xFF);
        state[4*i+3] = (unsigned char)( pwords[i]        & 0xFF);

        key[4*i]     = (unsigned char)((kwords[i] >> 24) & 0xFF);
        key[4*i+1]   = (unsigned char)((kwords[i] >> 16) & 0xFF);
        key[4*i+2]   = (unsigned char)((kwords[i] >> 8)  & 0xFF);
        key[4*i+3]   = (unsigned char)( kwords[i]        & 0xFF);
    }

    unsigned char round_keys[11][16];
    key_expansion(key, round_keys);

    add_round_key(state, round_keys[0]);

    for (int r = 1; r < 10; r++)
    {
        sub_bytes(state);
        shift_rows(state);
        mix_columns(state);
        add_round_key(state, round_keys[r]);
    }

    sub_bytes(state);
    shift_rows(state);
    add_round_key(state, round_keys[10]);

    ciphertext_0 = ((uint32_t_hls)state[0]  << 24) | ((uint32_t_hls)state[1]  << 16) | ((uint32_t_hls)state[2]  << 8) | (uint32_t_hls)state[3];
    ciphertext_1 = ((uint32_t_hls)state[4]  << 24) | ((uint32_t_hls)state[5]  << 16) | ((uint32_t_hls)state[6]  << 8) | (uint32_t_hls)state[7];
    ciphertext_2 = ((uint32_t_hls)state[8]  << 24) | ((uint32_t_hls)state[9]  << 16) | ((uint32_t_hls)state[10] << 8) | (uint32_t_hls)state[11];
    ciphertext_3 = ((uint32_t_hls)state[12] << 24) | ((uint32_t_hls)state[13] << 16) | ((uint32_t_hls)state[14] << 8) | (uint32_t_hls)state[15];
}
}