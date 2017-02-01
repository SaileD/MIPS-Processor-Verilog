`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2016 01:15:17 PM
// Design Name: 
// Module Name: EXMEMReg
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
//M --> all control inputs used in the M stage

module EXMEMReg(Clk, Rst, IDEX_RegDst, IDEX_MemRead, IDEX_WriteRegJALDataSel, IDEX_MemToReg, IDEX_MemWrite,
    IDEX_RegWrite, IDEX_DataMuxSel, IDEX_HiLo_En, IDEX_Branch, EXMEM_RegDst, EXMEM_MemRead, EXMEM_WriteRegJALDataSel,
    EXMEM_MemToReg, EXMEM_MemWrite, EXMEM_RegWrite, EXMEM_DataMuxSel, EXMEM_HiLo_En, EXMEM_Branch, IDEX_RegDstOutput, 
    ALUSrcOnShiftOutput, ALUResult, EXMEM_RegDstOutput, EXMEM_ALUSrcOnShiftOutput,
    EXMEM_ALUResult, IDEX_ReadData2, EXMEM_ReadData2, HazardIn, HazardOut, IDEX_Instruction, EXMEM_Instruction);
    
    input [1:0] IDEX_DataMuxSel;
    output reg [1:0] EXMEM_DataMuxSel;
    
    input IDEX_RegDst, IDEX_MemRead, IDEX_WriteRegJALDataSel, IDEX_MemToReg, IDEX_MemWrite,
        IDEX_RegWrite, IDEX_HiLo_En, HazardIn, IDEX_Branch;
    
    output reg EXMEM_RegDst, EXMEM_MemRead, EXMEM_WriteRegJALDataSel, EXMEM_MemToReg, 
        EXMEM_MemWrite, EXMEM_RegWrite, EXMEM_HiLo_En, HazardOut, EXMEM_Branch;
    
    input Clk, Rst;
    input [4:0] IDEX_RegDstOutput;
    input [31:0] ALUSrcOnShiftOutput, IDEX_ReadData2, IDEX_Instruction;
    input [63:0] ALUResult;
    
    output reg [4:0] EXMEM_RegDstOutput;
    output reg [31:0] EXMEM_ALUSrcOnShiftOutput, EXMEM_ReadData2, EXMEM_Instruction;
    output reg [63:0] EXMEM_ALUResult;
    
    initial begin
        EXMEM_RegDst = 0;
        EXMEM_MemRead = 0;
        EXMEM_WriteRegJALDataSel = 0;
        EXMEM_MemToReg = 0;
        EXMEM_MemWrite = 0;
        EXMEM_RegWrite = 0;
        EXMEM_DataMuxSel = 0;
        EXMEM_RegDstOutput = 0;
        EXMEM_ALUSrcOnShiftOutput = 0;
        EXMEM_ALUResult = 0;
        EXMEM_HiLo_En = 0;
        EXMEM_ReadData2 = 0;
        HazardOut = 0;
        EXMEM_Instruction = 0;
        EXMEM_Branch = 0;
    end
    
    always @(posedge Clk, posedge Rst) begin
        if(Rst == 1'b1) begin
            EXMEM_RegDst = 0;
            EXMEM_MemRead = 0;
            EXMEM_WriteRegJALDataSel = 0;
            EXMEM_MemToReg = 0;
            EXMEM_MemWrite = 0;
            EXMEM_RegWrite = 0;
            EXMEM_DataMuxSel = 0;
            EXMEM_RegDstOutput = 0;
            EXMEM_ALUSrcOnShiftOutput = 0;
            EXMEM_ALUResult = 0;
            EXMEM_HiLo_En = 0;
            EXMEM_ReadData2 = 0;
            HazardOut = 0;
            EXMEM_Instruction = 0;
            EXMEM_Branch = 0;
        end
        else begin
            EXMEM_RegDst = IDEX_RegDst;
            EXMEM_MemRead = IDEX_MemRead;
            EXMEM_WriteRegJALDataSel = IDEX_WriteRegJALDataSel;
            EXMEM_MemToReg = IDEX_MemToReg;
            EXMEM_MemWrite = IDEX_MemWrite;
            EXMEM_RegWrite = IDEX_RegWrite;
            EXMEM_DataMuxSel = IDEX_DataMuxSel;
            EXMEM_RegDstOutput = IDEX_RegDstOutput;
            EXMEM_ALUSrcOnShiftOutput = ALUSrcOnShiftOutput;
            EXMEM_ALUResult = ALUResult;
            EXMEM_HiLo_En = IDEX_HiLo_En;
            EXMEM_ReadData2 = IDEX_ReadData2;
            HazardOut = HazardIn;
            EXMEM_Instruction = IDEX_Instruction;
            EXMEM_Branch = IDEX_Branch;
        end
    end
endmodule
