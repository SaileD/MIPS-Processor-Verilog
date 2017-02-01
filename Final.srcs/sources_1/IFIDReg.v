`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2016 01:15:03 PM
// Design Name: 
// Module Name: IFIDReg
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


module IFIDReg(flush, Clk, Rst, IFID_Write, Instruction, IFID_Instruction);
    input Clk, Rst;
    input IFID_Write, flush;
    input [31:0] Instruction;
    
    output reg [31:0] IFID_Instruction;
    
    initial begin
        IFID_Instruction = 0;
    end
    
    always @(posedge Clk, posedge Rst) begin
    
        if(Rst == 1'b1)begin
            IFID_Instruction = 0;
        end
        else if (flush == 1'b1) begin
            IFID_Instruction = 0;
        end
        else if (IFID_Write == 1'b1) begin
            IFID_Instruction = Instruction;
        end
    end
    
//    always @(posedge Clk, posedge Rst) begin
    
//        if(Instruction[31:26] == 6'b000010)begin
//            flush_out = 1;
//        end
//        else begin
//            flush_out = 0;        
//        end
//    end
    
endmodule
