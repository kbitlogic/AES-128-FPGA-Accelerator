`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2026 21:03:27
// Design Name: 
// Module Name: inv_mix_columns
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

module inv_mix_columns(
    input  [127:0] state_in,
    output [127:0] state_out
);

inv_single_column c0 (
    .state_in(state_in[127:96]),
    .state_out(state_out[127:96])
);

inv_single_column c1 (
    .state_in(state_in[95:64]),
    .state_out(state_out[95:64])
);

inv_single_column c2 (
    .state_in(state_in[63:32]),
    .state_out(state_out[63:32])
);

inv_single_column c3 (
    .state_in(state_in[31:0]),
    .state_out(state_out[31:0])
);

endmodule
