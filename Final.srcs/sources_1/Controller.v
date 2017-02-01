`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2016 03:02:34 PM
// Design Name: 
// Module Name: Controller
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


module Controller(Instruction, RegDst, Branch, MemRead, WriteRegJALDataSel,
    MemToReg, ALUOp, MemWrite, ALUSrc, RegWrite, ALUSrcShift, HiLo_En, ReadReg, Jump, RASel,
    DataMuxSel, JRMuxSel);
    
    input[31:0] Instruction;
    output reg[5:0]  ALUOp;
    output reg[1:0] DataMuxSel;
    output reg RegDst, Branch, MemRead, MemToReg, RASel, WriteRegJALDataSel,
                MemWrite, ALUSrc, RegWrite, ALUSrcShift,HiLo_En, ReadReg, Jump, JRMuxSel; 
                
    initial begin
        ALUOp <= 6'b000000;
        RegDst <= 1'b0;
        Branch <= 1'b0;
        MemRead <= 1'b0;
        MemToReg <= 1'b0;
        MemWrite <= 1'b0;
        ALUSrc <= 1'b0;
        RegWrite <= 1'b0;
        ALUSrcShift <= 1'b0;
        HiLo_En <= 1'b0;
        ReadReg <= 1'b0;
        Jump <= 1'b0;
        RASel <= 1'b0;
        WriteRegJALDataSel <= 1'b0;
        DataMuxSel <= 2'b00;
        JRMuxSel <= 1'b0;
    end
                
    always@(Instruction) begin
//        ALUOp <= Instruction[5:0];
//        RegDst <= 1'b0;
//        Branch <= 1'b0;
//        MemRead <= 1'b0;
//        MemToReg <= 1'b0;
//        MemWrite <= 1'b0;
//        ALUSrc <= 1'b0;
//        RegWrite <= 1'b0;
//        ALUSrcShift <= 1'b0;
//        HiLo_En <= 1'b0;
//        ReadReg <= 1'b0;
//        Jump <= 1'b0;
//        RASel <= 1'b0;
//        WriteRegJALDataSel <= 1'b0;
//        DataMuxSel <= 2'b00;
//        JRMuxSel <= 1'b0;
    if(Instruction[31:26] == 0) begin //R-type
        if(Instruction == 32'b00000000000000000000000000000000) begin
            ALUOp <= 6'b000000;
            RegDst <= 1'b0;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b0;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        if(Instruction[5:0] == 6'b100000) begin           //add
            ALUOp <= Instruction[5:0];
            RegDst <= 1'b1;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b1;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end    
        
        else if(Instruction[5:0] == 6'b100001) begin      //addu
            ALUOp <= Instruction[5:0];
            RegDst <= 1'b1;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b1;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[5:0] == 6'b100010) begin      //sub
            ALUOp <= Instruction[5:0];
            RegDst <= 1'b1;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b1;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[5:0] == 6'b011000) begin      //mult
            ALUOp <= Instruction[5:0];
            RegDst <= 1'b1;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b0;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b1;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[5:0] == 6'b011001) begin      //multu
            ALUOp <= Instruction[5:0];
            RegDst <= 1'b1;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b0;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b1;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[5:0] == 6'b010000) begin //mfhi
            ALUOp <= Instruction[5:0];
            RegDst <= 1'b1;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b1;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[5:0] == 6'b010010) begin //mflo
            ALUOp <= Instruction[5:0];
            RegDst <= 1'b1;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b1;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[5:0] == 6'b010001) begin //mthi
            ALUOp <= Instruction[5:0];
            RegDst <= 1'b1;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b0;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b1;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[5:0] == 6'b010011) begin //mtlo
            ALUOp <= Instruction[5:0];
            RegDst <= 1'b1;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b0;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b1;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[5:0] == 6'b100100) begin      //AND
            ALUOp <= Instruction[5:0];
            RegDst <= 1'b1;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b1;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[5:0] == 6'b100101) begin      //OR
            ALUOp <= Instruction[5:0];
            RegDst <= 1'b1;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b1;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[5:0] == 6'b100111) begin      //NOR
            ALUOp <= Instruction[5:0];
            RegDst <= 1'b1;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b1;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[5:0] == 6'b100110) begin      //XOR
            ALUOp <= Instruction[5:0];
            RegDst <= 1'b1;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b1;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end

        else if(Instruction[5:0] == 6'b101010) begin      //slt
            ALUOp <= Instruction[5:0];
            RegDst <= 1'b1;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b1;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[5:0] == 6'b000011) begin      //sra
            ALUOp <= Instruction[5:0];
            RegDst <= 1'b1;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b1;
            ALUSrcShift <= 1'b1;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b1;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[5:0] == 6'b000111) begin      //srav
            ALUOp <= Instruction[5:0];
            RegDst <= 1'b1;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b1;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[5:0] == 6'b101011) begin      //sltu
            ALUOp <= Instruction[5:0];
            RegDst <= 1'b1;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b1;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[5:0] == 6'b000100) begin      //sllv
            ALUOp <= Instruction[5:0];
            RegDst <= 1'b1;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b1;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[5:0] == 6'b000110 && Instruction[10:6] == 5'b00001) begin      //rotrv
            ALUOp <= 6'b111100;
            RegDst <= 1'b1;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b1;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;    
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        else if(Instruction[5:0] == 6'b000110) begin      //srlv
            ALUOp <= Instruction[5:0];
            RegDst <= 1'b1;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b1;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        
        else if((Instruction[31:26] == 6'b000000) && (Instruction[5:0] == 6'b000000)) begin      //sll
            ALUOp <= 6'b010100;
            RegDst <= 1'b1;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b1;
            RegWrite <= 1'b1;
            ALUSrcShift <= 1'b1;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b1;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end

        else if(Instruction[5:0] == 6'b000010 && Instruction[25:21] == 5'b00001) begin      //rotr
            ALUOp <= 6'b111101;
            RegDst <= 1'b1;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b1;
            RegWrite <= 1'b1;
            ALUSrcShift <= 1'b1;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b1;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end       
        else if(Instruction[5:0] == 6'b000010) begin      //srl
            ALUOp <= Instruction[5:0];
            RegDst <= 1'b1;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b1;
            RegWrite <= 1'b1;
            ALUSrcShift <= 1'b1;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b1;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end      
        
        else if(Instruction[5:0] == 6'b001010) begin      //movz
            ALUOp <= 6'b111110;
            RegDst <= 1'b1;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b1;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b1;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end 
        
        else if(Instruction[5:0] == 6'b001011) begin      //movn
            ALUOp <= 6'b111111;
            RegDst <= 1'b1;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b1;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end 
        
        else if(Instruction[5:0] == 6'b001000) begin     //jr -- verify control bits
            ALUOp <= 6'b110010;
            RegDst <= 1'b1;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b1;
            RegWrite <= 1'b0;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b1;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b1;
        end
        else begin
            ALUOp <= 6'b000000;
            RegDst <= 1'b0;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b0;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
    end
    
    else begin      //I-type
        if(Instruction[31:26] == 6'b001001) begin      //addiu
            ALUOp <= Instruction[31:26];
            RegDst <= 1'b0;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b1;
            RegWrite <= 1'b1;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[31:26] == 6'b001000) begin      //addi
            ALUOp <= Instruction[31:26];
            RegDst <= 1'b0;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b1;
            RegWrite <= 1'b1;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;  
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[31:26] == 6'b001011) begin      //sltiu
            ALUOp <= Instruction[31:26];
            RegDst <= 1'b0;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b1;
            RegWrite <= 1'b1;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;                
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[31:26] == 6'b001010) begin      //slti
            ALUOp <= Instruction[31:26];
            RegDst <= 1'b0;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b1;
            RegWrite <= 1'b1;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
           
        else if(Instruction[31:26] == 6'b001101) begin      //ORi
            ALUOp <= Instruction[31:26];
            RegDst <= 1'b0;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b1;
            RegWrite <= 1'b1;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[31:26] == 6'b001110) begin      //XORi
            ALUOp <= Instruction[31:26];
            RegDst <= 1'b0;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b1;
            RegWrite <= 1'b1;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end

        else if(Instruction[31:26] == 6'b001100) begin      //ANDi
            ALUOp <= Instruction[31:26];
            RegDst <= 1'b0;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b1;
            RegWrite <= 1'b0;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end

        else if(Instruction[31:26] == 6'b011100 && Instruction[5:0] == 6'b000010) begin      //mul
            ALUOp <= Instruction[31:26];
            RegDst <= 1'b1;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b1;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[31:26] == 6'b011111 && Instruction[10:6] == 5'b10000) begin     // seb
            ALUOp <= 6'b101101;
            RegDst <= 1'b1;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b1;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b1;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end

        else if(Instruction[31:26] == 6'b011111 && Instruction[10:6] == 5'b11000) begin     // seh
            ALUOp <= 6'b101110;
            RegDst <= 1'b1;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b1;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b1;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[31:26] == 6'b011100 && Instruction[5:0] == 6'b000000) begin     //madd
            ALUOp <= 6'b101111;
            RegDst <= 1'b0;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b0;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b1;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[31:26] == 6'b011100 && Instruction[5:0] == 6'b000100) begin     //msub
            ALUOp <= 6'b110000;
            RegDst <= 1'b0;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b0;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b1;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[31:26] == 6'b100011) begin     //lw -- verify control signals on datapath
            ALUOp <= Instruction[31:26];
            RegDst <= 1'b0;
            Branch <= 1'b0;
            MemRead <= 1'b1;
            MemToReg <= 1'b1;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b1;
            RegWrite <= 1'b1;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[31:26] == 6'b100001) begin     //lh -- verify control signals on datapath
            ALUOp <= 6'b110111;
            RegDst <= 1'b0;
            Branch <= 1'b0;
            MemRead <= 1'b1;
            MemToReg <= 1'b1;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b1;
            RegWrite <= 1'b1;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b01;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[31:26] == 6'b100000) begin     //lb -- verify control signals on datapath
            ALUOp <= 6'b110011;
            RegDst <= 1'b0;
            Branch <= 1'b0;
            MemRead <= 1'b1;
            MemToReg <= 1'b1;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b1;
            RegWrite <= 1'b1;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b10;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[31:26] == 6'b101011) begin     //sw -- verify control signals on datapath
            ALUOp <= 6'b111001;
            RegDst <= 1'b0;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b1;
            ALUSrc <= 1'b1;
            RegWrite <= 1'b0;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[31:26] == 6'b101000) begin     //sb -- verify control signals on datapath
            ALUOp <= 6'b101000;
            RegDst <= 1'b0;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b1;
            ALUSrc <= 1'b1;
            RegWrite <= 1'b0;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b10;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[31:26] == 6'b101001) begin     //sh -- verify control signals on datapath
            ALUOp <= 6'b101001;
            RegDst <= 1'b0;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b1;
            ALUSrc <= 1'b1;
            RegWrite <= 1'b0;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b01;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[31:26] == 6'b001111) begin     //lui -- verify control bits
            ALUOp <= 6'b001111;
            RegDst <= 1'b0;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b1;
            RegWrite <= 1'b1;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[31:26] == 6'b000001 && Instruction[20:16] == 5'b00001) begin     //bgez -- verify control bits
            ALUOp <= 6'b110101;
            RegDst <= 1'b1;
            Branch <= 1'b1;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b0;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[31:26] == 6'b000100) begin     //beq -- verify control bits
            ALUOp <= 6'b110001;
            RegDst <= 1'b1;
            Branch <= 1'b1;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b0;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[31:26] == 6'b000101) begin     //bne -- verify control bits
            ALUOp <= 6'b000101;
            RegDst <= 1'b1;
            Branch <= 1'b1;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b0;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[31:26] == 6'b000111) begin     //bgtz -- verify control bits
            ALUOp <= 6'b010111;
            RegDst <= 1'b1;
            Branch <= 1'b1;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b0;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[31:26] == 6'b000110) begin     //blez -- verify control bits
            ALUOp <= 6'b101100;
            RegDst <= 1'b1;
            Branch <= 1'b1;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b0;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[31:26] == 6'b000001 && Instruction[20:16] == 5'b00000) begin     //bltz -- verify control bits
            ALUOp <= 6'b011110;
            RegDst <= 1'b1;
            Branch <= 1'b1;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b0;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[31:26] == 6'b000010) begin     //j 
            ALUOp <= 6'b011010;
            RegDst <= 1'b1;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b1;
            RegWrite <= 1'b0;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b1;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        
        else if(Instruction[31:26] == 6'b000011) begin     //jal -- verify control bits
            ALUOp <= 6'b010110;
            RegDst <= 1'b1;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b1;
            RegWrite <= 1'b1;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b1;
            RASel <= 1'b1;
            WriteRegJALDataSel <= 1'b1;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
        
        else begin
            ALUOp <= 6'b000000;
            RegDst <= 1'b0;
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemToReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b0;
            ALUSrcShift <= 1'b0;
            HiLo_En <= 1'b0;
            ReadReg <= 1'b0;
            Jump <= 1'b0;
            RASel <= 1'b0;
            WriteRegJALDataSel <= 1'b0;
            DataMuxSel <= 2'b00;
            JRMuxSel <= 1'b0;
        end
       
       end
    end
endmodule
