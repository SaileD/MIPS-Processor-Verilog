`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2016 12:48:07 PM
// Design Name: 
// Module Name: Mux1Bit2To1
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


module Mux1Bit2To1(out, inA, inB, sel);

    output reg out;
    
    input inA;
    input inB;
    input sel;

    initial begin
        out = 0;
    end
    
    always @(inA, inB, sel, out) begin
        if(sel == 1'b0) begin
            out <= inA;
        end
        else if(sel == 1'b1) begin
            out <= inB;
        end
    end 

endmodule
