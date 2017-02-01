`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2016 02:10:09 PM
// Design Name: 
// Module Name: IFID_FlushHandler
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


module IFID_FlushHandler(Instruction, Branch, Zero, flush_out, IDEX_flush);
    input[5:0] Instruction;
    input Branch, Zero;
    output reg flush_out, IDEX_flush;
    
    initial begin 
        flush_out = 0;
        IDEX_flush = 0;        
    end
    
    always@(Instruction, Branch, Zero) begin
        if(Instruction == 6'b000010) begin
            flush_out = 1;
            IDEX_flush = 0;
        end
        else if((Branch == 1'b1 && Zero == 1'b0)) begin
            flush_out = 1;
            IDEX_flush = 1;
        end
        else begin
            flush_out = 0;
            IDEX_flush = 0;
        end
    end
endmodule
