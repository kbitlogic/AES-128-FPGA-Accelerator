`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2026 21:02:04
// Design Name: 
// Module Name: inv_single_column
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

module inv_single_column(
    input  [31:0] state_in,
    output [31:0] state_out
);

wire [7:0] s0, s1, s2, s3;
assign {s0, s1, s2, s3} = state_in;

wire [7:0] o0, o1, o2, o3;

inv_array_bit r0 (
    .s0(s0), .s1(s1), .s2(s2), .s3(s3),
    .b0(4'hE), .b1(4'hB), .b2(4'hD), .b3(4'h9),
    .out(o0)
);

inv_array_bit r1 (
    .s0(s0), .s1(s1), .s2(s2), .s3(s3),
    .b0(4'h9), .b1(4'hE), .b2(4'hB), .b3(4'hD),
    .out(o1)
);

inv_array_bit r2 (
    .s0(s0), .s1(s1), .s2(s2), .s3(s3),
    .b0(4'hD), .b1(4'h9), .b2(4'hE), .b3(4'hB),
    .out(o2)
);

inv_array_bit r3 (
    .s0(s0), .s1(s1), .s2(s2), .s3(s3),
    .b0(4'hB), .b1(4'hD), .b2(4'h9), .b3(4'hE),
    .out(o3)
);

assign state_out = {o0, o1, o2, o3};

endmodule
