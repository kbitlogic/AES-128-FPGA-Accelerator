`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2026 21:10:33
// Design Name: 
// Module Name: aes_decryption_top
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

module aes_decryption_top (
    input  [127:0] ciphertext,
    input  [127:0] key,
    output [127:0] plaintext
);

    wire [1407:0] all_keys;
    wire [127:0] rk [0:10];
    wire [127:0] state [0:10];

    inv_key_expansion KE (
        .key(key),
        .all_keys(all_keys)
    );

    genvar i;
    
    generate
        for(i = 0; i < 11; i = i + 1) begin : rk_extract
            assign rk[i] = all_keys[1407 - i*128 -: 128];
        end
    endgenerate
    
    inv_add_round_key ARK0 (
        .state_in(ciphertext),
        .round_key(rk[10]),
        .out(state[0])
    );
    
    genvar r;
    generate
        for(r = 1; r < 10; r = r + 1) begin : rounds

            wire [127:0] sr, sb, ark, mc;

            inv_shift_rows ISR (
                .state_in(state[r-1]),
                .state_out(sr)
            );

            inv_sub_bytes ISB (
                .state_in(sr),
                .state_out(sb)
            );

            inv_add_round_key ARK (
                .state_in(sb),
                .round_key(rk[10-r]),
                .out(ark)
            );

            inv_mix_columns IMC (
                .state_in(ark),
                .state_out(state[r])
            );

        end
    endgenerate

    wire [127:0] sr10, sb10;

    inv_shift_rows ISR10 (
        .state_in(state[9]),
        .state_out(sr10)
    );

    inv_sub_bytes ISB10 (
        .state_in(sr10),
        .state_out(sb10)
    );

    inv_add_round_key ARK10 (
        .state_in(sb10),
        .round_key(rk[0]),
        .out(state[10])
    );

    assign plaintext = state[10];

endmodule
