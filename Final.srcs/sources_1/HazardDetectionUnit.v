`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2016 12:57:33 PM
// Design Name: 
// Module Name: HazardDetectionUnit
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

module HazardDetectionUnit(IFID_Rs, IFID_Rt, IDEX_Rt, IDEX_MemRead, IFID_Write,
PCWrite, Hazard);
    input IDEX_MemRead;
    input [4:0] IFID_Rs, IFID_Rt, IDEX_Rt;
    output reg IFID_Write, PCWrite, Hazard;
    
    initial begin
        IFID_Write = 1;
        PCWrite = 1;
        Hazard = 0;
    end
    
    always @(*) begin
        if ((IDEX_MemRead && ((IDEX_Rt == IFID_Rs)||(IDEX_Rt == IFID_Rt)))) begin
            IFID_Write = 0;
            PCWrite = 0;
            Hazard = 1;
        end
        else begin
            IFID_Write = 1;
            PCWrite = 1;
            Hazard = 0;
        end
    end
endmodule
