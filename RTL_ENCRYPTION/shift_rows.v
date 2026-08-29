`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.07.2026 18:30:54
// Design Name: 
// Module Name: shift_rows
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

module shift_rows (
    input  [127:0] state_in,
    output [127:0] state_out
);

wire [7:0] s [15:0];
wire [7:0] o [15:0];

assign {
    s[0],  s[1],  s[2],  s[3],
    s[4],  s[5],  s[6],  s[7],
    s[8],  s[9],  s[10], s[11],
    s[12], s[13], s[14], s[15]
} = state_in;

assign o[0]  = s[0];
assign o[4]  = s[4];
assign o[8]  = s[8];
assign o[12] = s[12];

assign o[1]  = s[5];
assign o[5]  = s[9];
assign o[9]  = s[13];
assign o[13] = s[1];

assign o[2]  = s[10];
assign o[6]  = s[14];
assign o[10] = s[2];
assign o[14] = s[6];

assign o[3]  = s[15];
assign o[7]  = s[3];
assign o[11] = s[7];
assign o[15] = s[11];

assign state_out = {
    o[0],  o[1],  o[2],  o[3],
    o[4],  o[5],  o[6],  o[7],
    o[8],  o[9],  o[10], o[11],
    o[12], o[13], o[14], o[15]
};

endmodule

