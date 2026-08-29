`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2026 21:05:17
// Design Name: 
// Module Name: inv_add_round_key
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

module inv_add_round_key(
    input  [127:0] state_in,
    input  [127:0] round_key,
    output [127:0] out
);

assign out = state_in ^ round_key;
endmodule
