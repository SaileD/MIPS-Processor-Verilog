`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - SignExtension.v
// Description - Sign extension module.
////////////////////////////////////////////////////////////////////////////////
module SignExtension(in, out);

    /* A 16-Bit input word */
    input [15:0] in;
    
    /* A 32-Bit output word */
    output reg[31:0] out;
    reg [15:0] add;
    integer i;
    
    initial begin
        out = 0;
    end
    /* Fill in the implementation here ... */
    always @(in, out, add) begin
        for(i = 0; i < 16; i = i + 1) begin
            add[i] <= in[15];
        end
        out[31:16] <= add[15:0];
        out[15:0] <= in[15:0];
    end
endmodule
