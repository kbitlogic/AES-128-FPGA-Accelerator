`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.07.2026 18:22:40
// Design Name: 
// Module Name: bit_computation
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

module bit_computation(
    input  [7:0] A,
    input  [1:0] B,
    output reg [7:0] C
);

reg [7:0] num1, num2, sum;

always @(*) begin

    if (B == 2'd1) begin
        C = A;
    end

    else if (B == 2'd2) begin
        num1 = A << 1;

        if (A[7] == 1)
            num2 = 8'h1B;
        else
            num2 = 8'h00;

        sum = num1 ^ num2;
        C = sum;
    end

    else if (B == 2'd3) begin
 
        num1 = A << 1;

        if (A[7] == 1)
            num1 = num1 ^ 8'h1B;
        num2 = A;

        sum = num1 ^ num2;
        C = sum;
    end

    else begin
        C = 8'd0;
    end

end
endmodule

