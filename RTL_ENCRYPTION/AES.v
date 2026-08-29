`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.07.2026 12:12:59
// Design Name: 
// Module Name: AES
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module aes_encryption_top (
    input clk,
    input rst,
    input  [127:0] plaintext,
    input  [127:0] key,
    output [127:0] ciphertext
);

    wire [1407:0] all_keys;
    wire [127:0] rk [0:10];
    wire [127:0] state [0:10];

    key_expansion KE (
        .key(key),
        .all_keys(all_keys)
    );

    genvar i;
    generate
        for(i = 0; i < 11; i = i + 1) begin : rk_extract
            assign rk[i] = all_keys[1407 - i*128 -: 128];
        end
    endgenerate

    add_round_key ARK0 (
        .state_in(plaintext),
        .round_key(key), 
        .out(state[0])
    );

    genvar r;
    generate
        for(r = 1; r < 10; r = r + 1) begin : rounds
            wire [127:0] sb, sr, mc;
            sub_bytes SB (
                .state_in(state[r-1]),
                .state_out(sb)
            );
            shift_rows SR (
                .state_in(sb),
                .state_out(sr)
            );
            mix_columns MC (
                .state_in(sr),   
                .state_out(mc)   
            );
            add_round_key ARK (
                .state_in(mc),
                .round_key(rk[r]),
                .out(state[r])
            );
        end
    endgenerate

    wire [127:0] sb10, sr10;
    sub_bytes SB10 (
        .state_in(state[9]),
        .state_out(sb10)
    );
    shift_rows SR10 (
        .state_in(sb10),
        .state_out(sr10)
    );
    add_round_key ARK10 (
        .state_in(sr10),
        .round_key(rk[10]),
        .out(state[10])
    );
    assign ciphertext = state[10];

endmodule


















