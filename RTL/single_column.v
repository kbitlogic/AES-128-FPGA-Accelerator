`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.07.2026 18:28:53
// Design Name: 
// Module Name: single_column
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

module single_column(
    input  [31:0] state_in,  
    output [31:0] state_out
);

wire [7:0] s0, s1, s2, s3;
assign {s0, s1, s2, s3} = state_in;

wire [7:0] o0, o1, o2, o3;

array_bit r0 (
    .s0(s0), .s1(s1), .s2(s2), .s3(s3),
    .b0(2'd2), .b1(2'd3), .b2(2'd1), .b3(2'd1),
    .out(o0)
);

array_bit r1 (
    .s0(s0), .s1(s1), .s2(s2), .s3(s3),
    .b0(2'd1), .b1(2'd2), .b2(2'd3), .b3(2'd1),
    .out(o1)
);

array_bit r2 (
    .s0(s0), .s1(s1), .s2(s2), .s3(s3),
    .b0(2'd1), .b1(2'd1), .b2(2'd2), .b3(2'd3),
    .out(o2)
);

array_bit r3 (
    .s0(s0), .s1(s1), .s2(s2), .s3(s3),
    .b0(2'd3), .b1(2'd1), .b2(2'd1), .b3(2'd2),
    .out(o3)
);

assign state_out = {o0, o1, o2, o3};

endmodule
