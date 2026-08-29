`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.07.2026 18:21:32
// Design Name: 
// Module Name: tb_aes_encryption_top
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

module tb_aes_encryption_top;

reg  [127:0] plaintext;
reg  [127:0] key;
wire [127:0] ciphertext;

aes_encryption_top uut (
    .plaintext(plaintext),
    .key(key),
    .ciphertext(ciphertext)
);

initial begin

  plaintext = 128'h00112233445566778899AABBCCDDEEFF;
  key       = 128'h000102030405060708090A0B0C0D0E0F;

    #20;  

    $display("Plaintext  = %h", plaintext);
    $display("Key        = %h", key);
    $display("Ciphertext = %h", ciphertext);

    if (ciphertext == 128'h69C4E0D86A7B0430D8CDB78070B4C55A)
        $display("? AES OUTPUT CORRECT");
    else
        $display("? AES OUTPUT WRONG");

    $finish;
end

endmodule
