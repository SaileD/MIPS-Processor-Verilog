`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2016 03:07:55 PM
// Design Name: 
// Module Name: HiLoReg
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


module HiLoReg(Clk, Rst, Input, Write_en, ReadHi, ReadLo);
    input Clk, Rst, Write_en;
    input[63:0] Input;
    output wire[31:0] ReadHi, ReadLo;
    reg[31:0] registers[0:1]; //0 = lo, 1 = hi
    
    initial begin
        registers[0] = 0;
        registers[1] = 0;
    end
    
    always@(posedge Clk) begin
        if(Rst == 1) begin
            registers[0] <= 0;
            registers[1] <= 0;
        end

        if(Write_en == 1) begin
            registers[0] <= Input[31:0];
            registers[1] <= Input[63:32];
        end
            
    end

    assign ReadLo = registers[0];
    assign ReadHi = registers[1];

endmodule
