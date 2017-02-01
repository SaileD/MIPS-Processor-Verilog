`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Saile Daimwood & Andrew Miller - Table 23
// % Effort for labs 16-24: 50/50
// 
//////////////////////////////////////////////////////////////////////////////////

module TopModule(Rst, Clk, out7, en_out);
    input Rst, Clk;
    output wire [6:0] out7;
    output wire [7:0] en_out;
    wire [31:0] WriteRegJALDataOut;
    wire[31:0] PCResult;
    (* mark_debug = "TRUE" *) wire [31:0] Address;
    (* mark_debug = "TRUE" *) wire [31:0] s0;
    (* mark_debug = "TRUE" *) wire [31:0] s1;
    (* mark_debug = "TRUE" *) wire [31:0] s2;
    (* mark_debug = "TRUE" *) wire [31:0] s3;
    (* mark_debug = "TRUE" *) wire [31:0] s4;
    wire[31:0] Instruction, ReadData1, ReadData2, ALUSrcOutput, ALUSrcOnShiftOutput, DataMuxOut, JRMuxOut,
    signOutput, ReadHi, ReadLo, MemoryOut, MemALUOut, A, B;
    wire[5:0] ALUOp;

    wire[1:0] DataMuxSel;
    wire Zero, RegWrite, Branch, MemRead, MemToReg, MemWrite, JRMuxSel, RASel,
    ALUSrc, ALUSrcShift, RegDst, HiLo_En, ClkOut, Jump, WriteRegJALDataSel, ReadReg;
    wire[63:0] ALUResult;
    wire [4:0] RegInput1, RegInput2, RegReadOutput, RegDstOutput, RegDstOutput1; // Finalized inputs for Register module
    
    // Forwarding unit vars
    wire [1:0] ForwardA, ForwardB;
    
    // Hazard detection unit vars
    wire IFID_Write, PCWrite, Hazard;
    wire flush, IDEX_Flush;
    
    // Pipeline register vars
    wire [63:0] EXMEM_ALUResult;
    wire [31:0] MEMWB_ALUResult, IFID_Instruction, IDEX_Instruction, EXMEM_Instruction, ReadData1Out, ReadData2Out, SignExtendOut,
    EXMEM_ALUSrcOnShiftOutput, EXMEM_DataOut, MEMWB_DataOut, EXMEM_ReadData2, ForwardAOut, ForwardDataMuxOut, EXMEM_ForwardDataMuxOut;
    wire [4:0] RegMuxResult, RegOutput, RegLocation, IFID_Rs, IFID_Rt, IFID_Rd,
    IDEX_Rs, IDEX_Rt, IDEX_Rd, EXMEM_RegDstOutput, MEMWB_RegDstOutput;
    wire [1:0] IFID_DataMuxSel, IDEX_DataMuxSel, EXMEM_DataMuxSel;
    wire [5:0] IFID_ALUOp, IDEX_ALUOp;
    wire IFID_ALUSrc, IFID_ALUSrcShift, IFID_MemRead, IFID_MemWrite, IFID_RegDst,
    IFID_WriteRegJALDataSel, IFID_MemToReg, IFID_HiLo_En, IFID_RegWrite, IFID_RASel;
    wire IDEX_Branch, IDEX_ALUSrc, IDEX_ALUSrcShift, IDEX_MemRead, IDEX_MemWrite, IDEX_Hazard, IDEX_ReadReg,
    IDEX_WriteRegJALDataSel, IDEX_MemToReg, IDEX_HiLo_En, IDEX_RegWrite, IDEX_RegDst, IDEX_RASel;
    wire EXMEM_MemRead, EXMEM_WriteRegJALDataSel, EXMEM_MemToReg, EXMEM_MemWrite, EXMEM_Hazard,
    EXMEM_RegWrite, EXMEM_HiLo_En;
    wire MEMWB_WriteRegJALDataSel, MEMWB_MemToReg, MEMWB_RegWrite;
    
    /////////////////////////////////////////////////////////////////////////////////
    
    // FIXME: figure out how PCWrite plays into this --- where is Program Counter?
    
    Two4DigitDisplay Display(
        .Clk(Clk),
        .NumberA(s0[7:0]),
        .NumberB(s1[7:0]),
        .out7(out7),
        .en_out(en_out)
    );

    ClkDiv NewClk(
        .Clk(Clk),
        .Rst(Rst),
        .in(4'b1010),
        .ClkOut(ClkOut)
    );
    // Controll signals sent out in D stage
    Controller Control(
        .Instruction(IFID_Instruction), 
        .RegDst(RegDst), 
        .Branch(Branch), 
        .MemRead(MemRead), 
        .WriteRegJALDataSel(WriteRegJALDataSel),
        .MemToReg(MemToReg), 
        .ALUOp(ALUOp), 
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc), 
        .RegWrite(RegWrite),
        .ALUSrcShift(ALUSrcShift),
        .HiLo_En(HiLo_En),
        .ReadReg(ReadReg),
        .Jump(Jump),
        .RASel(RASel),
        .DataMuxSel(DataMuxSel),
        .JRMuxSel(JRMuxSel)
    );
    
    Mux5Bit2To1 regRead(
        .out(RegReadOutput),
        .inA(IFID_Instruction[25:21]),
        .inB(IFID_Instruction[20:16]),
        .sel(ReadReg)
    );
    
    Mux32Bit3To1 forwardA( //FIXME: Forward to ALU, not Register File
        .out(ForwardAOut),  // input to ALUForwardedIn
        .inA(ReadData1Out), //00
        .inB(EXMEM_ALUResult[31:0]), //output of ALU in EXMEM stage - 01
        .inC(WriteRegJALDataOut), //output of Memory in WB Stage - 10
        .sel(ForwardA)
    );
    
    Mux32Bit3To1 forwardB( //FIXME: Forward to ALU, not Register File
        .out(B),  //input B to ALU
        .inA(ReadData2Out), //00
        .inB(EXMEM_ALUResult[31:0]), //output of ALU in EXMEM - 01
        .inC(WriteRegJALDataOut), //output of memory in WB - 10
        .sel(ForwardB)
    );
    
    Mux32Bit2To1 ALUForwardedIn(
        .out(A),  // input A to ALU
        .inA(ForwardAOut), 
        .inB(B), 
        .sel(IDEX_ReadReg)
    );
    
    Mux5Bit2To1 RegDstMux(
        .out(RegDstOutput1),
        .inA(IDEX_Rt),
        .inB(IDEX_Rd),
        .sel(IDEX_RegDst)
    );
    
    Mux32Bit2To1 ALUSrcMux(
        .out(ALUSrcOutput),
        .inA(B),
        .inB(SignExtendOut),
        .sel(IDEX_ALUSrc)
    );
    
    Mux32Bit2To1 ALUSrcOnShiftMux(
        .out(ALUSrcOnShiftOutput),
        .inA(ALUSrcOutput), 
        .inB({{27'b000000000000000000000000000},{IDEX_Instruction[10:6]}}), // Check that IFID_Instruction can actually skip pipeline reg
        .sel(IDEX_ALUSrcShift)
    );
    
//    Mux32Bit2To1 JRMux(
//        .out(JRMuxOut),
//        .inA({{6'b000000}, {Instruction[25:0] << 2}}), // Check if needs to be IFID_Instruction
//        .inB(ALUResult[31:0]),
//        .sel(JRMuxSel)
//    );
    
    ////////////////////////////////////////////////////////////////////////////
    // Below are muxes to set control signals to 0 if Hazard detected (stalling)    
    
    Mux6Bit2To1 HazardControlMux1(
        .out(IFID_ALUOp),
        .inA(ALUOp),
        .inB(6'b000000),
        .sel(Hazard)
    );
    
    Mux1Bit2To1 HazardControlMux2(
        .out(IFID_ALUSrc),
        .inA(ALUSrc),
        .inB(1'b0),
        .sel(Hazard)
    );
    
    Mux1Bit2To1 HazardControlMux3(
        .out(IFID_ALUSrcShift),
        .inA(ALUSrcShift),
        .inB(1'b0),
        .sel(Hazard)
    );
    
    Mux2Bit2To1 HazardControlMux4(
        .out(IFID_DataMuxSel),
        .inA(DataMuxSel),
        .inB(2'b00),
        .sel(Hazard)
    );
    
    Mux1Bit2To1 HazardControlMux5(
        .out(IFID_MemRead),
        .inA(MemRead),
        .inB(1'b0),
        .sel(Hazard)
    );
    
    Mux1Bit2To1 HazardControlMux6(
        .out(IFID_MemWrite),
        .inA(MemWrite),
        .inB(1'b0),
        .sel(Hazard)
    );
    
    Mux1Bit2To1 HazardControlMux7(
        .out(IFID_WriteRegJALDataSel),
        .inA(WriteRegJALDataSel),
        .inB(1'b0),
        .sel(Hazard)
    );
    
    Mux1Bit2To1 HazardControlMux8(
        .out(IFID_MemToReg),
        .inA(MemToReg),
        .inB(1'b0),
        .sel(Hazard)
    );
    
    Mux1Bit2To1 HazardControlMux9(
        .out(IFID_HiLo_En),
        .inA(HiLo_En),
        .inB(1'b0),
        .sel(Hazard)
    );
    
    Mux1Bit2To1 HazardControlMux10(
        .out(IFID_RegWrite),
        .inA(RegWrite),
        .inB(1'b0),
        .sel(Hazard)
    );
    
    Mux1Bit2To1 HazardControlMux11(
        .out(IFID_RASel),
        .inA(RASel),
        .inB(1'b0),
        .sel(Hazard)
    );
    
    Mux1Bit2To1 HazardControlMux12(
        .out(IFID_RegDst),
        .inA(RegDst),
        .inB(1'b0),
        .sel(Hazard)
    );
    
    ///////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////
    
    InstructionFetchUnit IFU(
        .Instruction(Instruction),
        .Reset(Rst),
        .Clk(ClkOut),
        .PCResult(Address),
        .Jump(Jump),
        .AddForJump(SignExtendOut),
        .Branch(IDEX_Branch),
        .Zero(Zero),
        .ALUResult({{6'b000000}, {IFID_Instruction[25:0] << 2}}),
        .PCWrite(PCWrite),
        .flush(flush)
    );
    
    RegisterFile Reg(
        .Rst(Rst),
        .ReadRegister1(RegReadOutput),
        .ReadRegister2(IFID_Instruction[20:16]), 
        .WriteRegister(MEMWB_RegDstOutput[4:0]), 
        .WriteData(WriteRegJALDataOut), 
        .RegWrite(MEMWB_RegWrite), // "                  "
        .Clk(ClkOut), 
        .ReadData1(ReadData1), 
        .ReadData2(ReadData2),
        .s0(s0),
        .s1(s1),
        .s2(s2),
        .s3(s3),
        .s4(s4),
        .Zero(Zero),
        .IDEX_Branch(IDEX_Branch)
    );
    
    HiLoReg HiLo(
        .Clk(ClkOut),
        .Rst(Rst),
        .Input(EXMEM_ALUResult),
        .Write_en(EXMEM_HiLo_En),
        .ReadHi(ReadHi),
        .ReadLo(ReadLo)
    );
        
    ALU32Bit ALU(
        .ALUControl(IDEX_ALUOp),
        .A(A),
        .ReadHi(ReadHi),
        .ReadLo(ReadLo),
        .B(ALUSrcOnShiftOutput),
        .ALUResult(ALUResult),
        .Zero(Zero)
    );
    
    Mux32Bit3To1 DataMux(
        .out(DataMuxOut), 
        .inA(EXMEM_ReadData2), 
        .inB({{16{EXMEM_ReadData2[15]}},{EXMEM_ReadData2[15:0]}}), //$signed(ReadData2[15:0])
        .inC({{24{EXMEM_ReadData2[7]}},{EXMEM_ReadData2[7:0]}}),  //$signed(ReadData2[7:0])
        .sel(EXMEM_DataMuxSel)
    );
    
    Mux32Bit2To1 ForwardDataMux(//Should be in EX stage
        .out(ForwardDataMuxOut), 
        .inA(ReadData2Out), 
        .inB(WriteRegJALDataOut),
        .sel((MEMWB_RegWrite == 1) && (IDEX_MemWrite == 1)
        && (IDEX_Rt == MEMWB_RegDstOutput))
    );
    
    DataMemory Data(
        .Address(EXMEM_ALUResult[31:0]), 
        .WriteData(DataMuxOut),
        .Clk(ClkOut),
        .MemWrite(EXMEM_MemWrite),
        .MemRead(EXMEM_MemRead),
        .ReadData(MemoryOut)
    ); 
    
    Mux5Bit2To1 WriteRegJAL(
        .out(RegDstOutput), 
        .inA(RegDstOutput1), 
        .inB(5'b11111), 
        .sel(IDEX_RASel)
    );
    
    Mux32Bit2To1 WriteRegJALData(
        .out(WriteRegJALDataOut), 
        .inA(MemALUOut), 
        .inB(Address + 4), //May need to pass Address through pipelines for this.
        .sel(MEMWB_WriteRegJALDataSel)       
    );
    
    Mux32Bit2To1 OutputSelect(
        .out(MemALUOut), 
        .inA(MEMWB_ALUResult), 
        .inB(MEMWB_DataOut), 
        .sel(MEMWB_MemToReg)
    );

    SignExtension Extend(
        .in(IFID_Instruction[15:0]),
        .out(signOutput)
    );
    
    IFID_FlushHandler i0(
        .Instruction(IFID_Instruction[31:26]),
        .Branch(IDEX_Branch),
        .Zero(Zero),
        .flush_out(flush),
        .IDEX_flush(IDEX_Flush)
    );
    
    IFIDReg i1(
        .flush(flush),        
        .Clk(ClkOut),
        .Rst(Rst),
        .IFID_Write(IFID_Write), // Should come from hazard detection unit
        .Instruction(Instruction),
        .IFID_Instruction(IFID_Instruction)
    );
    
    // Determine if SignExtend and SignExtendOut have a purpose
    IDEXReg i2(
        .IDEX_Flush(IDEX_Flush),
        .Clk(ClkOut),
        .Rst(Rst),
        .IFID_Branch(Branch),
        .IFID_ALUOp(IFID_ALUOp), 
        .IFID_ALUSrc(IFID_ALUSrc),
        .IFID_ALUSrcShift(IFID_ALUSrcShift),
        .IFID_DataMuxSel(IFID_DataMuxSel),
        .IFID_MemRead(IFID_MemRead),
        .IFID_MemWrite(IFID_MemWrite),
        .IFID_RegDst(IFID_RegDst),
        .IFID_WriteRegJALDataSel(IFID_WriteRegJALDataSel),
        .IFID_MemToReg(IFID_MemToReg),
        .IFID_HiLo_En(IFID_HiLo_En),
        .IFID_RegWrite(IFID_RegWrite),
        .IFID_RASel(IFID_RASel),
        .IFID_ReadReg(ReadReg),
        .IDEX_Branch(IDEX_Branch),
        .IDEX_ALUOp(IDEX_ALUOp),
        .IDEX_ALUSrc(IDEX_ALUSrc),
        .IDEX_ALUSrcShift(IDEX_ALUSrcShift),
        .IDEX_DataMuxSel(IDEX_DataMuxSel),
        .IDEX_MemRead(IDEX_MemRead),
        .IDEX_MemWrite(IDEX_MemWrite),
        .IDEX_RegDst(IDEX_RegDst),
        .IDEX_WriteRegJALDataSel(IDEX_WriteRegJALDataSel),
        .IDEX_MemToReg(IDEX_MemToReg),
        .IDEX_HiLo_En(IDEX_HiLo_En),
        .IDEX_RegWrite(IDEX_RegWrite),
        .IDEX_RASel(IDEX_RASel),
        .IDEX_ReadReg(IDEX_ReadReg),
        .IFID_Rs(IFID_Instruction[25:21]),
        .IFID_Rt(IFID_Instruction[20:16]),
        .IFID_Rd(IFID_Instruction[15:11]),
        .IFID_Instruction(IFID_Instruction),
        .IDEX_Rs(IDEX_Rs),
        .IDEX_Rt(IDEX_Rt),
        .IDEX_Rd(IDEX_Rd),
        .IDEX_Instruction(IDEX_Instruction),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2),
        .SignExtend(signOutput),
        .ReadData1Out(ReadData1Out),
        .ReadData2Out(ReadData2Out),
        .SignExtendOut(SignExtendOut),
        .HazardIn(Hazard),
        .HazardOut(IDEX_Hazard)
    );
    
    EXMEMReg x1(
        .Clk(ClkOut),
        .Rst(Rst),
        .IDEX_RegDst(IDEX_RegDst),
        .IDEX_MemRead(IDEX_MemRead),
        .IDEX_WriteRegJALDataSel(IDEX_WriteRegJALDataSel),
        .IDEX_MemToReg(IDEX_MemToReg),
        .IDEX_MemWrite(IDEX_MemWrite),
        .IDEX_RegWrite(IDEX_RegWrite),
        .IDEX_DataMuxSel(IDEX_DataMuxSel),
        .IDEX_HiLo_En(IDEX_HiLo_En),
        .IDEX_Branch(IDEX_Branch),
        .EXMEM_RegDst(EXMEM_RegDst),
        .EXMEM_MemRead(EXMEM_MemRead),
        .EXMEM_WriteRegJALDataSel(EXMEM_WriteRegJALDataSel),
        .EXMEM_MemToReg(EXMEM_MemToReg),
        .EXMEM_MemWrite(EXMEM_MemWrite),
        .EXMEM_RegWrite(EXMEM_RegWrite),
        .EXMEM_DataMuxSel(EXMEM_DataMuxSel),
        .EXMEM_HiLo_En(EXMEM_HiLo_En),
        .EXMEM_Branch(EXMEM_Branch),
        .IDEX_RegDstOutput(RegDstOutput),
        .ALUSrcOnShiftOutput(ALUSrcOnShiftOutput),
        .ALUResult(ALUResult),
        .EXMEM_RegDstOutput(EXMEM_RegDstOutput),
        .EXMEM_ALUSrcOnShiftOutput(EXMEM_ALUSrcOnShiftOutput),        
        .EXMEM_ALUResult(EXMEM_ALUResult),
        .IDEX_ReadData2(ForwardDataMuxOut),
        .EXMEM_ReadData2(EXMEM_ReadData2),
        .HazardIn(IDEX_Hazard),
        .HazardOut(EXMEM_Hazard),
        .IDEX_Instruction(IDEX_Instruction), 
        .EXMEM_Instruction(EXMEM_Instruction)
        );
    
    MEMWBReg m1(
        .Clk(ClkOut),
        .Rst(Rst),
        .EXMEM_WriteRegJALDataSel(EXMEM_WriteRegJALDataSel),
        .EXMEM_MemToReg(EXMEM_MemToReg),
        .EXMEM_RegWrite(EXMEM_RegWrite),
        .MEMWB_WriteRegJALDataSel(MEMWB_WriteRegJALDataSel),
        .MEMWB_MemToReg(MEMWB_MemToReg),
        .MEMWB_RegWrite(MEMWB_RegWrite),
        .EXMEM_RegDstOutput(EXMEM_RegDstOutput),
        .EXMEM_DataOut(MemoryOut),
        .EXMEM_ALUResult(EXMEM_ALUResult[31:0]),
        .MEMWB_RegDstOutput(MEMWB_RegDstOutput),
        .MEMWB_DataOut(MEMWB_DataOut),
        .MEMWB_ALUResult(MEMWB_ALUResult)
    );
    
    ForwardingUnit forward(
        .IDEX_Rs(IDEX_Rs),
        .IDEX_Rt(IDEX_Rt),
        .EXMEM_RegWrite(EXMEM_RegWrite),
        .EXMEM_RegDstOutput(EXMEM_RegDstOutput),
        .MEMWB_RegWrite(MEMWB_RegWrite),
        .MEMWB_RegDstOutput(MEMWB_RegDstOutput),
        .ForwardA(ForwardA),
        .ForwardB(ForwardB)
    );
    
    HazardDetectionUnit hazard(
        .IFID_Rs(IFID_Instruction[25:21]),
        .IFID_Rt(IFID_Instruction[20:16]),
        .IDEX_MemRead(IDEX_MemRead),
        .IDEX_Rt(IDEX_Rt),
        .IFID_Write(IFID_Write),
        .PCWrite(PCWrite),
        .Hazard(Hazard)
    );

    ProgramCounter u0(
            .Address(Address), //.[name used in module]([name used as wire in top module]),
            .PCResult(PCResult), 
            .Reset(Rst), 
            .Clk(ClkOut),
            .PCWrite(1'b1)
    );

endmodule
