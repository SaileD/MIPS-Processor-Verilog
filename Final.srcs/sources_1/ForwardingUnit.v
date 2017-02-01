`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2016 01:23:19 PM
// Design Name: 
// Module Name: ForwardingUnit
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

module ForwardingUnit(IDEX_Rs, IDEX_Rt, EXMEM_RegWrite, EXMEM_RegDstOutput, 
MEMWB_RegWrite, MEMWB_RegDstOutput, ForwardA, ForwardB);
    input EXMEM_RegWrite, MEMWB_RegWrite;
    input [4:0] IDEX_Rs, IDEX_Rt, EXMEM_RegDstOutput, MEMWB_RegDstOutput;
    output reg [1:0] ForwardA, ForwardB; // Mux controls for forwarded inputs
    
    initial begin
        ForwardA = 2'b00;
        ForwardB = 2'b00;
    end
    
    always @(*) begin
        if ((EXMEM_RegWrite == 1'b1) && (EXMEM_RegDstOutput != 0) 
        && (EXMEM_RegDstOutput == IDEX_Rs)) begin
            ForwardA = 2'b01;
        end
        else if ((MEMWB_RegWrite == 1'b1) && (MEMWB_RegDstOutput != 0) 
        //&& !((EXMEM_RegWrite == 1) && (EXMEM_RegDstOutput != 0) && (EXMEM_RegDstOutput != IDEX_Rs))
        && (MEMWB_RegDstOutput == IDEX_Rs)) begin
            ForwardA = 2'b10;
        end
        else begin
            ForwardA = 2'b00;
        end
    end
    
    always@(*) begin
        if ((EXMEM_RegWrite == 1'b1) && (EXMEM_RegDstOutput != 0) 
        && (EXMEM_RegDstOutput == IDEX_Rt)) begin
            ForwardB = 2'b01;
        end
        else if ((MEMWB_RegWrite == 1'b1) && (MEMWB_RegDstOutput != 0) 
        //&& !((EXMEM_RegWrite == 1) && (EXMEM_RegDstOutput != 0) && (EXMEM_RegDstOutput != IDEX_Rs)) 
        && (MEMWB_RegDstOutput == IDEX_Rt)) begin
            ForwardB = 2'b10;
        end
        else begin
            ForwardB = 2'b00;
        end
    end
    
    

endmodule
