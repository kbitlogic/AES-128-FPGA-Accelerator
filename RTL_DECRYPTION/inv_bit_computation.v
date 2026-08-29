`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2026 20:49:48
// Design Name: 
// Module Name: inv_bit_computation
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

module inv_bit_computation(
    input  [7:0] A,
    input  [3:0] B,
    output reg [7:0] C
);

function [7:0] xtime;
    input [7:0] x;
    begin
        if(x[7])
            xtime = (x << 1) ^ 8'h1B;
        else
            xtime = (x << 1);
    end
endfunction

reg [7:0] x2, x4, x8;

always @(*) begin

    x2 = xtime(A);
    x4 = xtime(x2);
    x8 = xtime(x4);

    case(B)

        4'h9: begin
            C = x8 ^ A;
        end

        4'hB: begin
            C = x8 ^ x2 ^ A;
        end

        4'hD: begin
            C = x8 ^ x4 ^ A;
        end

        4'hE: begin
            C = x8 ^ x4 ^ x2;
        end

        default: begin
            C = 8'h00;
        end

    endcase

end

endmodule
