`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2016 11:52:00 AM
// Design Name: 
// Module Name: JumpAdder
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


module JumpAdder(A, B, Out);
    input[31:0] A, B;
    output reg[31:0] Out;
    
    initial begin
        Out = 0;
    end
    
    always @(*) begin
        Out <= A+B;
    end
    
endmodule
