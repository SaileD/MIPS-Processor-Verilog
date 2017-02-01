`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS:-
// ALUControl: 4-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.
//
// OUTPUTS:-
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU behaviorally, so that it supports addition,  subtraction,
// AND, OR, and set on less than (SLT). The 'ALUResult' will output the 
// corresponding result of the operation based on the 32-Bit inputs, 'A', and 
// 'B'. The 'Zero' flag is high when 'ALUResult' is '0'. The 'ALUControl' signal 
// should determine the function of the ALU based on the table below:-
// Op   | 'ALUControl' value
// ==========================
// ADD  | 100000
// ADDU | 100001
// ADDIU| 001001
// ADDI | 001000
// SUB  | 100010
// MUL  | 011100
// MULT | 011000
// MULTU| 011001
// AND  | 100100
// OR   | 100101
// ANDI | 001100
// NOR  | 100111
// XOR  | 100110
// ORI  | 001101
// XORI | 001110
// SLL  | 000000
// SRL  | 000010
// SLT  | 101010
// SLTI | 001010
// SRA  | 000011
// SRAV | 000111
// SLTIU| 001011
// SLTU | 101011
// SLLV | 000100
// SRLV | 000110
// MOVN | 111111 [001011 (last 6)]
// MOVZ | 111110 [001010 (last 6)]
// ROTR | 111101 [same as SRL except 5 bits after first 6 (00001)]
// ROTRV | 111100 [same as SRLV except 5 bits before last 6 (00001)]
// SEB | 101101 [011111 (first 6), 10000 (5 before), 100000 (last 6)]
// SEH | 101110 [011111 (first 6), 11000 (5 before), 100000 (last 6)]
// MADD | 101111 [011100 (first 6), 000000 (last 6)]
// MSUB | 110000 [011100 (first 6), 000100 (last 6)]
//
//
//
// NOTE:-
// SLT (i.e., set on less than): ALUResult is '32'h000000001' if A < B.
// 
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(ALUControl, A, ReadHi, ReadLo, B, ALUResult, Zero);

	input [5:0] ALUControl; // control bits for ALU operation
	input [31:0] A, B;	    // inputs
	input [31:0] ReadHi, ReadLo; // current high and low register values
    reg [63:0] tempVal1, tempVal2;     // temp reg for storing concatenated result
    
	output reg [63:0] ALUResult;	// answer
	reg[5:0] shamt;
	output reg Zero;	    // Zero=1 if ALUResult == 0
	
	initial begin 
	   ALUResult = 0;
	   Zero = 1;
	end

    always @(ALUControl, A, B, ReadHi, ReadLo) begin
        ALUResult = 0;
        if(ALUControl == 6'b100000) begin // ADD
            ALUResult = $signed(A) + $signed(B);
        end
        
        else if(ALUControl == 6'b100001) begin // ADDU
            ALUResult = $signed(A) + $signed(B);
        end
        
        else if(ALUControl == 6'b100010) begin // SUB
            ALUResult = $signed(A) - $signed(B);
        end
        
        else if(ALUControl == 6'b011100) begin // MUL = A*B stored in $d
            //ALUResult = $signed(A) * $signed(B);
            if($signed(A) * $signed(B) < 0) begin
                ALUResult[63:32] = 32'b11111111111111111111111111111111;
                ALUResult[31:0] = $signed(A) * $signed(B);
            end
            else begin
                ALUResult[63:32] = 32'b00000000000000000000000000000000;
                ALUResult[31:0] = $signed(A) * $signed(B);
            end
        end
        
        else if(ALUControl == 6'b011000) begin // MULT -> must be stored in HI LO
            ALUResult = $signed(A) * $signed(B);
        end
        
        else if(ALUControl == 6'b011001) begin // MULTU -> must be stored in HI Lo
            ALUResult = $unsigned(A) * $unsigned(B);
        end
        
        else if(ALUControl == 6'b100100) begin // AND
            ALUResult = $signed(A) & $signed(B);
        end
        
        else if(ALUControl == 6'b100101) begin // OR
            ALUResult = $signed(A) | $signed(B);
        end
        
        else if(ALUControl == 6'b100111) begin // NOR
            ALUResult = ~($signed(A) | $signed(B)); 
        end
        
        else if(ALUControl == 6'b100110) begin // XOR
            ALUResult = $signed(A) ^ $signed(B);
        end
        
        else if(ALUControl == 6'b101010) begin // SLT
            if($signed(A) < $signed(B)) begin
                ALUResult = 1;
            end
            else begin
                ALUResult = 0;
            end
        end
        
        else if(ALUControl == 6'b000111) begin // SRAV
            ALUResult[31:0] = $signed(B) >>> A[4:0];
        end
        
        else if(ALUControl == 6'b101011) begin // SLTU
            if($unsigned(A) < $unsigned(B)) begin
                ALUResult = 1;
            end
            else begin
                ALUResult = 0;
            end
        end
        
        else if(ALUControl == 6'b000100) begin // SLLV
            ALUResult[31:0] = $signed(B) << $unsigned(A[4:0]);
        end
        
        else if(ALUControl == 6'b000110) begin // SRLV
            ALUResult = $signed(B) >> $unsigned(A[4:0]);
        end
        
        else if(ALUControl == 6'b001001) begin // ADDIU
            ALUResult = $signed(A) + $signed(B);
        end
        
        else if(ALUControl == 6'b001000) begin // ADDI
            ALUResult = $signed(A) + $signed(B);
        end
        
        else if(ALUControl == 6'b001011) begin // SLTIU
            if($unsigned(A) < $unsigned(B)) begin
                ALUResult = 1;
            end
            else begin
                ALUResult = 0;
            end
        end
        
        else if(ALUControl == 6'b001010) begin // SLTI
            if($signed(A) < $signed(B)) begin
                ALUResult = 1;
            end
            else begin
                ALUResult = 0;
            end
        end
        
        else if(ALUControl == 6'b001101) begin // ORI
            ALUResult = $signed(A) | $signed(B);
        end
        
        else if(ALUControl == 6'b001110) begin // XORI
            ALUResult = $signed(A) ^ $signed(B);
        end
        
        else if(ALUControl == 6'b010100) begin // SLL
            ALUResult = $signed(A) << $unsigned(B[4:0]);
        end
        
        else if(ALUControl == 6'b000010) begin // SRL
            ALUResult = $signed(A) >> $unsigned(B[4:0]);
        end
        
        else if(ALUControl == 6'b001100) begin // ANDI
            ALUResult = $signed(A) & $signed(B);
        end
        
        else if(ALUControl == 6'b000011) begin // SRA
            ALUResult = $signed(A) >>> $unsigned(B[4:0]);
        end
        
        else if (ALUControl == 6'b111111) begin // MOVN
            if (B != 0) begin
                ALUResult = $signed(A);
            end
        end
        
        else if (ALUControl == 6'b111110) begin // MOVZ
            if (B == 0) begin
                ALUResult = $signed(A);
            end
        end
        
        else if (ALUControl == 6'b111101) begin // ROTR
            shamt = B[4:0];
            tempVal1 = {A, A};
            tempVal1 = tempVal1 >> shamt;
            ALUResult = tempVal1[31:0];
        end
        
        else if (ALUControl == 6'b111100) begin // ROTRV
            tempVal1 = {B, B};
            tempVal1 = tempVal1 >> A;
            ALUResult = tempVal1[31:0];
        end
        
        else if (ALUControl == 6'b101101) begin // SEB
            ALUResult = {{56{A[7]}},{A[7:0]}};
        end
        
        else if (ALUControl == 6'b101110) begin // SEH
            ALUResult = {{48{A[15]}},{A[15:0]}};
        end
        
        else if (ALUControl == 6'b101111) begin // MADD
            tempVal1 = {ReadHi,ReadLo};
            tempVal2 = $signed(A) * $signed(B);
            ALUResult = tempVal1 + tempVal2;
        end
        
        else if (ALUControl == 6'b110000) begin // MSUB
            tempVal1 = {{ReadHi[31:0]},{ReadLo[31:0]}};
            tempVal2 = $signed(A) * $signed(B);
            ALUResult = tempVal1 - tempVal2;
        end
        
        else if(ALUControl == 6'b010000) begin // mfhi
            if($signed(ReadHi) < 0) begin
                ALUResult[31:0] = ReadHi;
                ALUResult[63:32] = 32'b11111111111111111111111111111111;
            end
            else begin
                ALUResult = ReadHi;
            end
        end
        
        else if(ALUControl == 6'b010010) begin // mflo
            if($signed(ReadLo) < 0) begin
                ALUResult[31:0] = ReadLo;
                ALUResult[63:32] = 32'b11111111111111111111111111111111;
            end
            else begin
                ALUResult = ReadLo;
            end
        end
        
        else if(ALUControl == 6'b010001) begin // mthi
            ALUResult = {A, ReadLo};
        end
        
        else if(ALUControl == 6'b010011) begin // mtlo
            ALUResult = {ReadHi, A};
        end
        
        else if(ALUControl == 6'b100011) begin // lw
            ALUResult = A + B; //B is offset, A is base
        end
        
        else if(ALUControl == 6'b110111) begin //lh
            ALUResult = A + B; //B is offset, A is base
        end
        
        else if(ALUControl == 6'b110011) begin //lb
            ALUResult = A + B; //B is offset, A is base
        end
        
        else if(ALUControl == 6'b111001) begin //sw
            ALUResult = A + B; //B is offset, A is base
        end
        
        else if(ALUControl == 6'b101000) begin //sb
            ALUResult = A + B; //B is offset, A is base
        end
        
        else if(ALUControl == 6'b101001) begin //sh
            ALUResult = A + B; //B is offset, A is base
        end
        
        else if(ALUControl == 6'b001111) begin //lui
            ALUResult = B << 16;
        end
        
        else if(ALUControl == 6'b110101) begin //bgez
            if($signed(A) >= 0) begin
                ALUResult = 1;
            end
            else begin
                ALUResult = 0;
            end
        end
        
        else if(ALUControl == 6'b110001) begin //beq
            if($signed(A) == $signed(B)) begin
                ALUResult = 1;
            end
            else begin
                ALUResult = 0;
            end
        end
        
        else if(ALUControl == 6'b000101) begin //bne
            if($signed(A) != $signed(B)) begin
                ALUResult = 1;
            end
            else begin
                ALUResult = 0;
            end
        end
        
        else if(ALUControl == 6'b010111) begin //bgtz
            if($signed(A) > 0) begin
                ALUResult = 1;
            end
            else begin
                ALUResult = 0;
            end
        end
        
        else if(ALUControl == 6'b101100) begin //blez
            if($signed(A) <= 0) begin
                ALUResult = 1;
            end
            else begin
                ALUResult = 0;
            end
        end
        
        else if(ALUControl == 6'b011110) begin //bltz
            if($signed(A) < 0) begin
                ALUResult = 1;
            end
            else begin
                ALUResult = 0;
            end
        end
        
        else if(ALUControl == 6'b011010) begin //j
            ALUResult = B;
        end
        
        else if(ALUControl == 6'b010110) begin //jal
            ALUResult = B;
        end
        else if(ALUControl == 6'b110010) begin //jr
            ALUResult = A;
        end
        
     
    end
    always@(ALUResult) begin
        Zero = 0;
        if(ALUResult == 0)begin
            Zero = 1;
        end
        else begin
            Zero = 0;
        end
    end
endmodule

