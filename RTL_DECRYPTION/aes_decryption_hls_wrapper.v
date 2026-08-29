`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.07.2026 19:23:23
// Design Name: 
// Module Name: aes_decryption_hls_wrapper
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


`timescale 1ns / 1ps

module aes_decryption_hls_wrapper(
    input  wire ap_clk,
    input  wire ap_rst,
    input  wire ap_ce,
    input  wire ap_start,
    input  wire ap_continue,
    output reg ap_done,
    output reg ap_idle,
    output reg ap_ready,

    input  wire [31:0] ciphertext_0,
    input  wire [31:0] ciphertext_1,
    input  wire [31:0] ciphertext_2,
    input  wire [31:0] ciphertext_3,

    input  wire [31:0] key_0,
    input  wire [31:0] key_1,
    input  wire [31:0] key_2,
    input  wire [31:0] key_3,

    output reg [31:0] plaintext_0,
    output reg [31:0] plaintext_1,
    output reg [31:0] plaintext_2,
    output reg [31:0] plaintext_3,
    output reg plaintext_ap_vld
);

wire [127:0] ciphertext = {
    ciphertext_0,
    ciphertext_1,
    ciphertext_2,
    ciphertext_3
};

wire [127:0] key = {
    key_0,
    key_1,
    key_2,
    key_3
};

wire [127:0] plain_out;

aes_decryption_top AES_CORE (
    .ciphertext(ciphertext),
    .key(key),
    .plaintext(plain_out)
);

always @(posedge ap_clk)
begin
    if(ap_rst)
    begin
        plaintext_0 <= 32'd0;
        plaintext_1 <= 32'd0;
        plaintext_2 <= 32'd0;
        plaintext_3 <= 32'd0;

        plaintext_ap_vld <= 1'b0;

        ap_done  <= 1'b0;
        ap_idle  <= 1'b1;
        ap_ready <= 1'b1;
    end
    else
    begin
        ap_idle  <= ~ap_start;
        ap_ready <= 1'b1;

        if(ap_start)
        begin
            {plaintext_0,
             plaintext_1,
             plaintext_2,
             plaintext_3} <= plain_out;

            plaintext_ap_vld <= 1'b1;
            ap_done <= 1'b1;
        end
        else
        begin
            plaintext_ap_vld <= 1'b0;
            ap_done <= 1'b0;
        end
    end
end

endmodule
