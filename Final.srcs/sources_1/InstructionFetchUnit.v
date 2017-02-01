`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Team Members: Saile Daimwood and Andrew Miller
// Overall percent effort of each team member: 50%/50%, balanced cooperation
//                                              
// ECE369 - Computer Architecture
// Laboratory 3 (PostLab)
// Module - InstructionFetchUnit.v
// Description - Fetches the instruction from the instruction memory based on 
//               the program counter (PC) value.
// INPUTS:-
// Reset: 1-Bit input signal. 
// Clk: Input clock signal.
//
// OUTPUTS:-
// Instruction: 32-Bit output instruction from the instruction memory. 
//              Decimal value diplayed on the LCD usng the wrapper given in Lab 2
//
// FUNCTIONALITY:-
// Please connect up the following implemented modules to create this
// 'InstructionFetchUnit':-
//   (a) ProgramCounter.v
//   (b) PCAdder.v
//   (c) InstructionMemory.v
// Connect the modules together in a testbench so that the instruction memory
// outputs the contents of the next instruction indicated by the memory location
// in the PC at every clock cycle. Please initialize the instruction memory with
// some preliminary values for debugging purposes.
//
// @@ The 'Reset' input control signal is connected to the program counter (PC) 
// register which initializes the unit to output the first instruction in 
// instruction memory.
// @@ The 'Instruction' output port holds the output value from the instruction
// memory module.
// @@ The 'Clk' input signal is connected to the program counter (PC) register 
// which generates a continuous clock pulse into the module.
////////////////////////////////////////////////////////////////////////////////

module InstructionFetchUnit(Instruction, Reset, Clk, PCResult, Jump, AddForJump, Branch,
Zero, ALUResult, PCWrite, flush);
    
    input Reset, Clk, Jump, Branch, Zero, PCWrite, flush;
    input[31:0] AddForJump, ALUResult;
    output [31:0] Instruction;
    output wire[31:0] PCResult;
    wire [31:0] Address, AddResult, BranchOut, AddOut;
    
    ProgramCounter u0(
        .Address(Address), //.[name used in module]([name used as wire in top module]),
        .PCResult(PCResult), 
        .Reset(Reset), 
        .Clk(Clk),
        .PCWrite(PCWrite)
    );
        
    InstructionMemory u1(
        .Address(PCResult),
        .Instruction(Instruction)
    );
            
    PCAdder u2(
        .PCResult(PCResult),
        .PCAddResult(AddResult),
        .PCWrite(PCWrite && ~(Reset) && ~(flush))
    );
    
    Mux32Bit2To1 JumpMux(
        .out(Address), 
        .inA(BranchOut), 
        .inB(ALUResult), 
        .sel(Jump)
    );
    
    Mux32Bit2To1 BranchMux(
        .out(BranchOut), 
        .inA(AddResult), 
        .inB(AddOut),
        .sel(Branch & ~Zero)
    );
    
    JumpAdder ActuallyBranchAdder(
        .A(AddResult - 4),
        .B((AddForJump << 2)),
        .Out(AddOut)
    );
    
endmodule

