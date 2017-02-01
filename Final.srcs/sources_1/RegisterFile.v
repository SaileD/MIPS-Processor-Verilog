`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
//
//
// Student(s) Name and Last Name: Saile Daimwood & Andrew Miller
//
//
// Module - register_file.v
// Description - Implements a register file with 32 32-Bit wide registers.
//
// 
// INPUTS:-
// ReadRegister1: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister1'.
// ReadRegister2: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister2'.
// WriteRegister: 5-Bit address to select a register to be written through 32-Bit
//                input port 'WriteRegister'.
// WriteData: 32-Bit write input port.
// RegWrite: 1-Bit control input signal.
//
// OUTPUTS:-
// ReadData1: 32-Bit registered output. 
// ReadData2: 32-Bit registered output. 
//
// FUNCTIONALITY:-
// 'ReadRegister1' and 'ReadRegister2' are two 5-bit addresses to read two 
// registers simultaneously. The two 32-bit data sets are available on ports 
// 'ReadData1' and 'ReadData2', respectively. 'ReadData1' and 'ReadData2' are 
// registered outputs (output of register file is written into these registers 
// at the falling edge of the clock). You can view it as if outputs of registers
// specified by ReadRegister1 and ReadRegister2 are written into output 
// registers ReadData1 and ReadData2 at the falling edge of the clock. 
//
// 'RegWrite' signal is high during the rising edge of the clock if the input 
// data is to be written into the register file. The contents of the register 
// specified by address 'WriteRegister' in the register file are modified at the 
// rising edge of the clock if 'RegWrite' signal is high. The D-flip flops in 
// the register file are positive-edge (rising-edge) triggered. (You have to use 
// this information to generate the write-clock properly.) 
//
// NOTE:-
// We will design the register file such that the contents of registers do not 
// change for a pre-specified time before the falling edge of the clock arrives 
// to allow for data multiplexing and setup time.
////////////////////////////////////////////////////////////////////////////////

module RegisterFile(Rst, ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, Clk, ReadData1, ReadData2,
 s0, s1, s2, s3, s4, Zero, IDEX_Branch);
    input [4:0] ReadRegister1;
    input [4:0] ReadRegister2;
    input [4:0] WriteRegister;
    input[31:0] WriteData;
    input Clk, Rst, Zero, IDEX_Branch;
    input RegWrite;
    
    output reg[31:0] ReadData1;
    output reg[31:0] ReadData2;
    
    output [31:0] s0;
    output [31:0] s1;
    output [31:0] s2;
    output [31:0] s3;
    output [31:0] s4;
    
    reg[31:0] Registers[0:31];
    
    initial begin
        Registers[0] <= 0;
        Registers[1] <= 0;
        Registers[2] <= 0;
        Registers[3] <= 0;
        Registers[4] <= 0;
        Registers[5] <= 0;
        Registers[6] <= 0;
        Registers[7] <= 0;
        Registers[8] <= 0;
        Registers[9] <= 0;
        Registers[10] <= 0;
        Registers[11] <= 0;
        Registers[12] <= 0;
        Registers[13] <= 0;
        Registers[14] <= 0;
        Registers[15] <= 0;
        Registers[16] <= 0;
        Registers[17] <= 0;
        Registers[18] <= 0;
        Registers[19] <= 0;
        Registers[20] <= 0;
        Registers[21] <= 0;
        Registers[22] <= 0;
        Registers[23] <= 0;
        Registers[24] <= 0;
        Registers[25] <= 0;
        Registers[26] <= 0;
        Registers[27] <= 0;
        Registers[28] <= 0;
        Registers[29] <= 0;
        Registers[30] <= 0;
        Registers[31] <= 0;
    end
    
    always@(posedge Clk) begin
        if(RegWrite == 1'b1) begin
            Registers[WriteRegister] <= WriteData;
        end
    end

    always @(negedge Clk) begin
        if(WriteRegister == ReadRegister1 && RegWrite == 1) begin
            ReadData1 = WriteData;
        end
        else begin 
            ReadData1 = Registers[ReadRegister1];  
        end
        
        if(WriteRegister == ReadRegister2 && RegWrite == 1) begin
            ReadData2 = WriteData;
        end
        else begin
            ReadData2 = Registers[ReadRegister2];
        end
    end      
    
    assign s0 = Registers[16];
    assign s1 = Registers[17];
    assign s2 = Registers[18];
    assign s3 = Registers[19];
    assign s4 = Registers[20];
endmodule


	/* Please fill in the implementation here... */
//    always @(Clk, Rst, RegWrite, WriteRegister, WriteData) begin
//        if(Rst == 1'b1) begin
//            Registers[0] <= 0;
//            Registers[1] <= 0;
//            Registers[2] <= 0;
//            Registers[3] <= 0;
//            Registers[4] <= 0;
//            Registers[5] <= 0;
//            Registers[6] <= 0;
//            Registers[7] <= 0;
//            Registers[8] <= 0;
//            Registers[9] <= 0;
//            Registers[10] <= 0;
//            Registers[11] <= 0;
//            Registers[12] <= 0;
//            Registers[13] <= 0;
//            Registers[14] <= 0;
//            Registers[15] <= 0;
//            Registers[16] <= 0;
//            Registers[17] <= 0;
//            Registers[18] <= 0;
//            Registers[19] <= 0;
//            Registers[20] <= 0;
//            Registers[21] <= 0;
//            Registers[22] <= 0;
//            Registers[23] <= 0;
//            Registers[24] <= 0;
//            Registers[25] <= 0;
//            Registers[26] <= 0;
//            Registers[27] <= 0;
//            Registers[28] <= 0;
//            Registers[29] <= 0;
//            Registers[30] <= 0;
//            Registers[31] <= 0;
//        end
//        else if(RegWrite == 1'b1 && Clk == 1'b1) begin
//            Registers[WriteRegister] <= WriteData;
//        end
//        else begin
//            Registers[0] <= 0;
//            Registers[1] <= Registers[1];
//            Registers[2] <= Registers[2];
//            Registers[3] <= Registers[3];
//            Registers[4] <= Registers[4];
//            Registers[5] <= Registers[5];
//            Registers[6] <= Registers[6];
//            Registers[7] <= Registers[7];
//            Registers[8] <= Registers[8];
//            Registers[9] <= Registers[9];
//            Registers[10] <= Registers[10];
//            Registers[11] <= Registers[11];
//            Registers[12] <= Registers[12];
//            Registers[13] <= Registers[13];
//            Registers[14] <= Registers[14];
//            Registers[15] <= Registers[15];
//            Registers[16] <= Registers[16];
//            Registers[17] <= Registers[17];
//            Registers[18] <= Registers[18];
//            Registers[19] <= Registers[19];
//            Registers[20] <= Registers[20];
//            Registers[21] <= Registers[21];
//            Registers[22] <= Registers[22];
//            Registers[23] <= Registers[23];
//            Registers[24] <= Registers[24];
//            Registers[25] <= Registers[25];
//            Registers[26] <= Registers[26];
//            Registers[27] <= Registers[27];
//            Registers[28] <= Registers[28];
//            Registers[29] <= Registers[29];
//            Registers[30] <= Registers[30];
//            Registers[31] <= Registers[31];
//        end
//    end
