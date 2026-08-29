`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.07.2026 22:59:30
// Design Name: 
// Module Name: inv_sub_bytes
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

module inv_sub_bytes (
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

genvar i;
generate
    for (i = 0; i < 16; i = i + 1)
    begin : INV_SBOX_INST
        inv_sbox u_inv_sbox (
            .in (s[i]),
            .out(o[i])
        );
    end
endgenerate

assign state_out = {
    o[0],  o[1],  o[2],  o[3],
    o[4],  o[5],  o[6],  o[7],
    o[8],  o[9],  o[10], o[11],
    o[12], o[13], o[14], o[15]
};

endmodule
