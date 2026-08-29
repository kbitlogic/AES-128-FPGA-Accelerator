`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2026 20:59:33
// Design Name: 
// Module Name: inv_array_bit
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

module inv_array_bit(
    input  [7:0] s0, s1, s2, s3,
    input  [3:0] b0, b1, b2, b3,
    output [7:0] out
);
wire [7:0] m0, m1, m2, m3;

inv_bit_computation u0 (.A(s0),.B(b0),.C(m0));
inv_bit_computation u1 (.A(s1),.B(b1),.C(m1));
inv_bit_computation u2 (.A(s2),.B(b2),.C(m2));
inv_bit_computation u3 (.A(s3),.B(b3),.C(m3));

assign out = m0 ^ m1 ^ m2 ^ m3;

endmodule
