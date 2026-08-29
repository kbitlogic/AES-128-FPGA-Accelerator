`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.07.2026 15:27:14
// Design Name: 
// Module Name: AES_HLS_Wrapper
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

module aes_hls_wrapper(
    input  wire ap_clk,
    input  wire ap_rst,
    input  wire ap_ce,
    input  wire ap_start,
    input  wire ap_continue,
    output reg ap_done,
    output reg ap_idle,
    output reg ap_ready,

    input  wire [31:0] plaintext_0,
    input  wire [31:0] plaintext_1,
    input  wire [31:0] plaintext_2,
    input  wire [31:0] plaintext_3,

    input  wire [31:0] key_0,
    input  wire [31:0] key_1,
    input  wire [31:0] key_2,
    input  wire [31:0] key_3,

    output reg [31:0] ciphertext_0,
    output reg [31:0] ciphertext_1,
    output reg [31:0] ciphertext_2,
    output reg [31:0] ciphertext_3,
    output reg ciphertext_ap_vld
);
    wire [127:0] plaintext = {plaintext_0, plaintext_1, plaintext_2, plaintext_3};
    wire [127:0] key       = {key_0, key_1, key_2, key_3};
    wire [127:0] cipher_out;

    aes_encryption_top AES_CORE (
        .plaintext  (plaintext),
        .key        (key),
        .ciphertext (cipher_out)
    );

    always @(posedge ap_clk)
    begin
        if (ap_rst)
        begin
            {ciphertext_0, ciphertext_1, ciphertext_2, ciphertext_3} <= 128'd0;
            ciphertext_ap_vld <= 1'b0;
            ap_done  <= 1'b0;
            ap_idle  <= 1'b1;
            ap_ready <= 1'b1;
        end
        else if (ap_ce)
        begin
            ap_done <= 1'b0;
            ap_ready <= 1'b1;
            ciphertext_ap_vld <= 1'b0;
            if (ap_start)
            begin
                ap_idle <= 1'b0;
                {ciphertext_0, ciphertext_1, ciphertext_2, ciphertext_3} <= cipher_out;
                ciphertext_ap_vld <= 1'b1;
                ap_done <= 1'b1;
            end
            else
            begin
                ap_idle <= 1'b1;
            end
            if (ap_done && ap_continue)
            begin
                ap_done <= 1'b0;
                ap_idle <= 1'b1;
                ap_ready <= 1'b1;
                ciphertext_ap_vld <= 1'b0;
            end
        end
    end
endmodule