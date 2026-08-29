`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.07.2026 18:25:38
// Design Name: 
// Module Name: array_bit
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

module array_bit(
    input  [7:0] s0, s1, s2, s3,
    input  [1:0] b0, b1, b2, b3,     
    output [7:0] out               
);

wire [7:0] m0, m1, m2, m3;

bit_computation u0(.A(s0), .B(b0), .C(m0));
bit_computation u1(.A(s1), .B(b1), .C(m1));
bit_computation u2(.A(s2), .B(b2), .C(m2));
bit_computation u3(.A(s3), .B(b3), .C(m3));

assign out = m0 ^ m1 ^ m2 ^ m3;

endmodule
