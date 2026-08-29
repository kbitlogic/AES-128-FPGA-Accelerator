`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.07.2026 22:33:41
// Design Name: 
// Module Name: g_function
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

function [31:0] g_function;
        input [31:0] word;
        input [3:0] round;
        reg [31:0] temp;
        begin
            temp = rotword(word);
            temp = subword(temp);
            temp[31:24] = temp[31:24] ^ rcon(round);
            g_function = temp;
        end
    endfunction
