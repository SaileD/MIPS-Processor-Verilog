`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2016 02:19:37 PM
// Design Name: 
// Module Name: IDEXReg
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
//EX --> all control inputs used in the EX stage

module IDEXReg(IDEX_Flush, Clk, Rst, IFID_Branch, IFID_ALUOp, IFID_ALUSrc, IFID_ALUSrcShift, IFID_DataMuxSel, IFID_MemRead, IFID_MemWrite, IFID_RegDst, IFID_WriteRegJALDataSel,
    IFID_MemToReg, IFID_HiLo_En, IFID_RegWrite, IFID_RASel, IFID_ReadReg, IDEX_Branch, IDEX_ALUOp, IDEX_ALUSrc, IDEX_ALUSrcShift, IDEX_DataMuxSel, 
    IDEX_MemRead, IDEX_MemWrite, IDEX_RegDst, IDEX_WriteRegJALDataSel, IDEX_MemToReg, IDEX_HiLo_En, IDEX_RegWrite, IDEX_RASel, IDEX_ReadReg,
    IFID_Rs, IFID_Rt, IFID_Rd, IFID_Instruction, IDEX_Rs, IDEX_Rt, IDEX_Rd, IDEX_Instruction, ReadData1, ReadData2, SignExtend, ReadData1Out, 
    ReadData2Out, SignExtendOut, HazardIn, HazardOut);
    
    input [5:0] IFID_ALUOp;
    output reg [5:0] IDEX_ALUOp;
    
    input [1:0] IFID_DataMuxSel;
    output reg [1:0] IDEX_DataMuxSel;
    
    input IDEX_Flush, IFID_Branch, IFID_ALUSrc, IFID_ALUSrcShift, IFID_MemRead, IFID_MemWrite, IFID_RegDst, HazardIn,
    IFID_WriteRegJALDataSel, IFID_MemToReg, IFID_HiLo_En, IFID_RegWrite, IFID_RASel, IFID_ReadReg;
    output reg IDEX_Branch, IDEX_ALUSrc, IDEX_ALUSrcShift, IDEX_MemRead, IDEX_MemWrite, IDEX_RegDst, HazardOut,
    IDEX_WriteRegJALDataSel, IDEX_MemToReg, IDEX_HiLo_En, IDEX_RegWrite, IDEX_RASel, IDEX_ReadReg;
    
    input Clk, Rst; 
    input [4:0] IFID_Rs, IFID_Rt, IFID_Rd;
    output reg [4:0] IDEX_Rs, IDEX_Rt, IDEX_Rd;
        
    input [31:0] ReadData1, ReadData2, SignExtend, IFID_Instruction;
    output reg [31:0] ReadData1Out, ReadData2Out, SignExtendOut, IDEX_Instruction;
    
    initial begin
        IDEX_Branch = 0;
        IDEX_ALUOp = 0;
        IDEX_ALUSrc = 0;
        IDEX_ALUSrcShift = 0;
        IDEX_DataMuxSel = 0;
        IDEX_MemRead = 0;
        IDEX_MemWrite = 0;
        IDEX_WriteRegJALDataSel = 0;
        IDEX_MemToReg = 0;
        IDEX_HiLo_En = 0;
        IDEX_RegWrite = 0;
        IDEX_RASel = 0;
        IDEX_Rs = 0;
        IDEX_Rt = 0;
        IDEX_Rd = 0;
        IDEX_Instruction = 0;
        IDEX_RegDst = 0;
        SignExtendOut = 0;
        ReadData1Out = 0;
        ReadData2Out = 0;
        HazardOut = 0;
        IDEX_ReadReg = 0;
    end
    
//    always @(posedge Clk, posedge Rst) begin
//        if(IFID_Instruction[31:26] == 6'b000010) begin
//            flush = 1;
//        end
//        else begin
//            flush = 0;
//        end
//    end
    
    always @(posedge Clk, posedge Rst) begin
    
        if(Rst == 1'b1 || IDEX_Flush == 1'b1) begin
            IDEX_ALUOp = 0;
            IDEX_ALUSrc = 0;
            IDEX_ALUSrcShift = 0;
            IDEX_DataMuxSel = 0;
            IDEX_MemRead = 0;
            IDEX_MemWrite = 0;
            IDEX_WriteRegJALDataSel = 0;
            IDEX_MemToReg = 0;
            IDEX_HiLo_En = 0;
            IDEX_RegWrite = 0;
            IDEX_RASel = 0;
            IDEX_Rs = 0;
            IDEX_Rt = 0;
            IDEX_Rd = 0;
            IDEX_Instruction = 0;
            IDEX_RegDst = 0;
            SignExtendOut = 0;
            ReadData1Out = 0;
            ReadData2Out = 0;
            HazardOut = 0;
            IDEX_ReadReg = 0;
            IDEX_Branch = 0;
        end
        else begin
            IDEX_Branch = IFID_Branch;
            IDEX_ALUOp = IFID_ALUOp;
            IDEX_ALUSrc = IFID_ALUSrc;
            IDEX_ALUSrcShift = IFID_ALUSrcShift;
            IDEX_DataMuxSel = IFID_DataMuxSel;
            IDEX_MemRead = IFID_MemRead;
            IDEX_MemWrite = IFID_MemWrite;
            IDEX_WriteRegJALDataSel = IFID_WriteRegJALDataSel;
            IDEX_MemToReg = IFID_MemToReg;
            IDEX_HiLo_En = IFID_HiLo_En;
            IDEX_RegWrite = IFID_RegWrite;
            IDEX_RASel = IFID_RASel;
            IDEX_Rs = IFID_Rs;
            IDEX_Rt = IFID_Rt;
            IDEX_Rd = IFID_Rd;
            IDEX_Instruction = IFID_Instruction;
            IDEX_RegDst = IFID_RegDst;
            SignExtendOut = SignExtend;
            ReadData1Out = ReadData1;
            ReadData2Out = ReadData2;
            HazardOut = HazardIn;
            IDEX_ReadReg = IFID_ReadReg;
        end
    end
endmodule
