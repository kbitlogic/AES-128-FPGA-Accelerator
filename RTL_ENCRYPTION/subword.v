`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.07.2026 22:33:02
// Design Name: 
// Module Name: subword
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

function [31:0] subword;
        input [31:0] word;
        begin
            subword[31:24] = sbox(word[31:24]);
            subword[23:16] = sbox(word[23:16]);
            subword[15:8]  = sbox(word[15:8]);
            subword[7:0]   = sbox(word[7:0]);
        end
    endfunction
