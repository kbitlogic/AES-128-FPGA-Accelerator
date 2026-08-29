`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.07.2026 22:31:47
// Design Name: 
// Module Name: rotword
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

 function [31:0] rotword;
        input [31:0] word;
        begin
            rotword = {word[23:0], word[31:24]};
        end
    endfunction
