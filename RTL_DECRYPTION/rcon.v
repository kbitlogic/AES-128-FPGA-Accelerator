`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.07.2026 22:34:29
// Design Name: 
// Module Name: rcon
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

function [7:0] rcon;
        input [3:0] round;
        begin
            case(round)
                1: rcon = 8'h01;
                2: rcon = 8'h02;
                3: rcon = 8'h04;
                4: rcon = 8'h08;
                5: rcon = 8'h10;
                6: rcon = 8'h20;
                7: rcon = 8'h40;
                8: rcon = 8'h80;
                9: rcon = 8'h1B;
                10: rcon = 8'h36;
                default: rcon = 8'h00;
            endcase
        end
    endfunction
