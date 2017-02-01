`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2016 12:31:53 PM
// Design Name: 
// Module Name: TopModule_tb
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


module TopModule_tb();

    reg Clk, Rst;
    wire[6:0] out7;
    wire[7:0] en_out;
//    wire[31:0] PCResult;
//    wire[31:0] s1, s2, s3, s4, Address;
//    wire[31:0] WriteRegJALDataOut, Address;
    
//    TopModule u0(
//        .Rst(Rst),
//        .Clk(Clk),
//        .s1(s1),
//        .s2(s2),
//        .s3(s3),
//        .s4(s4),
//        .Address(Address)
//    );
    
    
    TopModule u0(
        .Rst(Rst),
        .Clk(Clk),
        .out7(out7),
        .en_out(en_out)
//        .PCResult(PCResult)
    );
    
    initial begin
        Clk <= 1'b0;
        forever #1 Clk <= ~Clk;
    end
    
    initial begin
        Rst <= 1;
        #150
        Rst <= 0;
    end


endmodule
