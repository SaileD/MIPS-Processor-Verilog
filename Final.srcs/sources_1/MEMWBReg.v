`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2016 01:15:30 PM
// Design Name: 
// Module Name: MEMWBReg
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

//WB --> all control inputs used in WB stage

module MEMWBReg(Clk, Rst, EXMEM_WriteRegJALDataSel, EXMEM_MemToReg, EXMEM_RegWrite,
    MEMWB_WriteRegJALDataSel, MEMWB_MemToReg, MEMWB_RegWrite, EXMEM_RegDstOutput,
    EXMEM_DataOut, EXMEM_ALUResult, MEMWB_RegDstOutput, MEMWB_DataOut, MEMWB_ALUResult);
    
    input EXMEM_WriteRegJALDataSel, EXMEM_MemToReg, EXMEM_RegWrite;
    
    output reg MEMWB_WriteRegJALDataSel, MEMWB_MemToReg, MEMWB_RegWrite;
    
    input Clk, Rst;
    input [4:0] EXMEM_RegDstOutput;
    input [31:0] EXMEM_DataOut;
    input [31:0] EXMEM_ALUResult;
    
    output reg [4:0] MEMWB_RegDstOutput;
    output reg [31:0] MEMWB_DataOut;
    output reg [31:0] MEMWB_ALUResult;
    
    initial begin
        MEMWB_WriteRegJALDataSel = 0;
        MEMWB_MemToReg = 0;
        MEMWB_RegWrite = 0;
        MEMWB_RegDstOutput = 0;
        MEMWB_DataOut = 0;
        MEMWB_ALUResult = 0;
    end
    
    always @(posedge Clk, posedge Rst) begin
        if(Rst == 1'b1) begin
            MEMWB_WriteRegJALDataSel = 0;
            MEMWB_MemToReg = 0;
            MEMWB_RegWrite = 0;
            MEMWB_RegDstOutput = 0;
            MEMWB_DataOut = 0;
            MEMWB_ALUResult = 0;
        end
        else begin
            MEMWB_WriteRegJALDataSel = EXMEM_WriteRegJALDataSel;
            MEMWB_MemToReg = EXMEM_MemToReg;
            MEMWB_RegWrite = EXMEM_RegWrite;
            MEMWB_RegDstOutput = EXMEM_RegDstOutput;
            MEMWB_DataOut = EXMEM_DataOut;
            MEMWB_ALUResult = EXMEM_ALUResult;
        end
    end
endmodule
