`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Laboratory  1
// Module - InstructionMemory.v
// Description - 32-Bit wide instruction memory.
//
// INPUT:-
// Address: 32-Bit address input port.
//
// OUTPUT:-
// Instruction: 32-Bit output port.
//
// FUNCTIONALITY:-
// Similar to the DataMemory, this module should also be byte-addressed
// (i.e., ignore bits 0 and 1 of 'Address'). All of the instructions will be 
// hard-coded into the instruction memory, so there is no need to write to the 
// InstructionMemory.  The contents of the InstructionMemory is the machine 
// language program to be run on your MIPS processor.
//
//
//we will store the machine code for a code written in C later. for now initialize 
//each entry to be its index * 4 (memory[i] = i * 4;)
//all you need to do is give an address as input and read the contents of the 
//address on your output port. 
// 
//Using a 32bit address you will index into the memory, output the contents of that specific 
//address. for data memory we are using 1K word of storage space. for the instruction memory 
//you may assume smaller size for practical purpose. you can use 128 words as the size and 
//hardcode the values.  in this case you need 7 bits to index into the memory. 
//
//be careful with the least two significant bits of the 32bit address. those help us index 
//into one of the 4 bytes in a word. therefore you will need to use bit [8-2] of the input address. 


////////////////////////////////////////////////////////////////////////////////

module InstructionMemory(Address, Instruction); 

    input [31:0] Address;        // Input Address 

    output reg [31:0] Instruction;    // Instruction at memory location Address
    
    reg [31:0] memory[0:511]; // Array of memory location
    
    /* Please fill in the implementation here */
    initial begin
        // Labs 16-24 testcase
        memory[0] = 32'h23bdfffc;	//	main:		addi	$sp, $sp, -4
        memory[1] = 32'hafbf0000;    //            sw    $ra, 0($sp)
        memory[2] = 32'h34040000;    //            ori    $a0, $zero, 0
        memory[3] = 32'h34050010;    //            ori    $a1, $zero, 16
        memory[4] = 32'h34060050;    //            ori    $a2, $zero, 80
        memory[5] = 32'h08000014;    //            j    vbsme
        memory[6] = 32'h8fbf0000;    //            lw    $ra, 0($sp)
        memory[7] = 32'h23bd0004;    //            addi    $sp, $sp, 4
        memory[8] = 32'h03e00008;    //            jr    $ra
        memory[9] = 32'h00402020;    //    print_result:    add    $a0, $v0, $zero
        memory[10] = 32'h34020001;    //            ori    $v0, $zero, 1
        memory[11] = 32'h34040060;    //            ori    $a0, $zero, 96
        memory[12] = 32'h34020004;    //            ori    $v0, $zero, 4
        memory[13] = 32'h00602020;    //            add    $a0, $v1, $zero
        memory[14] = 32'h34020001;    //            ori    $v0, $zero, 1
        memory[15] = 32'h34040060;    //            ori    $a0, $zero, 96
        memory[16] = 32'h34020004;    //            ori    $v0, $zero, 4
        memory[17] = 32'h34040060;    //            ori    $a0, $zero, 96
        memory[18] = 32'h34020004;    //            ori    $v0, $zero, 4
        memory[19] = 32'h03e00008;    //            jr    $ra
        memory[20] = 32'h34020000;    //    vbsme:        ori    $v0, $zero, 0
        memory[21] = 32'h34030000;    //            ori    $v1, $zero, 0
        memory[22] = 32'h23bdfffc;    //            addi    $sp, $sp, -4
        memory[23] = 32'hafbf0000;    //            sw    $ra, 0($sp)
        memory[24] = 32'h8c880000;    //    Zig_Check:    lw    $t0, 0($a0)
        memory[25] = 32'h8c890004;    //            lw    $t1, 4($a0)
        memory[26] = 32'h8c8a0008;    //            lw    $t2, 8($a0)
        memory[27] = 32'h8c8b000c;    //            lw    $t3, 12($a0)
        memory[28] = 32'h71099802;    //            mul    $s3, $t0, $t1
        memory[29] = 32'h00139880;    //            sll    $s3, $s3, 2
        memory[30] = 32'h2273fffc;    //            addi    $s3, $s3, -4
        memory[31] = 32'h214dffff;    //            addi    $t5, $t2, -1
        memory[32] = 32'h71a96802;    //            mul    $t5, $t5, $t1
        memory[33] = 32'h000d6880;    //            sll    $t5, $t5, 2
        memory[34] = 32'h216effff;    //            addi    $t6, $t3, -1
        memory[35] = 32'h000e7080;    //            sll    $t6, $t6, 2
        memory[36] = 32'h01ae6820;    //            add    $t5, $t5, $t6
        memory[37] = 32'h026d9822;    //            sub    $s3, $s3, $t5
        memory[38] = 32'h0000a020;    //            add    $s4, $zero, $zero
        memory[39] = 32'h0009b080;    //            sll    $s6, $t1, 2
        memory[40] = 32'h000960c0;    //            sll    $t4, $t1, 3
        memory[41] = 32'h000b6880;    //            sll    $t5, $t3, 2
        memory[42] = 32'h018db822;    //            sub    $s7, $t4, $t5
        memory[43] = 32'h00004020;    //            add    $t0, $zero, $zero
        memory[44] = 32'h0000c820;    //            add    $t9, $zero, $zero
        memory[45] = 32'h00008020;    //            add    $s0, $zero, $zero
        memory[46] = 32'h00008820;    //            add    $s1, $zero, $zero
        memory[47] = 32'h201203e8;    //            addi    $s2, $zero, 1000
        memory[48] = 32'h080000da;    //    loop2:        j    SAD
        memory[49] = 32'h0293482a;    //    next:        slt    $t1, $s4, $s3
        memory[50] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[51] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[52] = 32'h112000a0;    //            beq    $t1, $zero, return
        memory[53] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[54] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[55] = 32'h12800080;    //            beq    $s4, $zero, move_right
        memory[56] = 32'h8c890000;    //            lw    $t1, 0($a0)
        memory[57] = 32'h8c8a0004;    //            lw    $t2, 4($a0)
        memory[58] = 32'h8c8b0008;    //            lw    $t3, 8($a0)
        memory[59] = 32'h012b6022;    //            sub    $t4, $t1, $t3
        memory[60] = 32'h718a6802;    //            mul    $t5, $t4, $t2
        memory[61] = 32'h000d6880;    //            sll    $t5, $t5, 2
        memory[62] = 32'h026d6822;    //            sub    $t5, $s3, $t5
        memory[63] = 32'h01b46022;    //            sub    $t4, $t5, $s4
        memory[64] = 32'h200e0004;    //            addi    $t6, $zero, 4
        memory[65] = 32'h02ae7822;    //            sub    $t7, $s5, $t6
        memory[66] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[67] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[68] = 32'h11ec0077;    //            beq    $t7, $t4, move_down
        memory[69] = 32'h8c8c000c;    //            lw    $t4, 12($a0)
        memory[70] = 32'h014c6822;    //            sub    $t5, $t2, $t4
        memory[71] = 32'h000d6880;    //            sll    $t5, $t5, 2
        memory[72] = 32'h01b47022;    //            sub    $t6, $t5, $s4
        memory[73] = 32'h20180003;    //            addi    $t8, $zero, 3
        memory[74] = 32'h03157822;    //            sub    $t7, $t8, $s5
        memory[75] = 32'h01cf6820;    //            add    $t5, $t6, $t7
        memory[76] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[77] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[78] = 32'h11a00069;    //            beq    $t5, $zero, move_right
        memory[79] = 32'h000a6880;    //            sll    $t5, $t2, 2
        memory[80] = 32'h028d702a;    //            slt    $t6, $s4, $t5
        memory[81] = 32'h200f0001;    //            addi    $t7, $zero, 1
        memory[82] = 32'h01f56022;    //            sub    $t4, $t7, $s5
        memory[83] = 32'h018ec020;    //            add    $t8, $t4, $t6
        memory[84] = 32'h200d0001;    //            addi    $t5, $zero, 1
        memory[85] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[86] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[87] = 32'h130d006b;    //            beq    $t8, $t5, move_diag_down
        memory[88] = 32'h012b6822;    //            sub    $t5, $t1, $t3
        memory[89] = 32'h71aa6802;    //            mul    $t5, $t5, $t2
        memory[90] = 32'h000d6880;    //            sll    $t5, $t5, 2
        memory[91] = 32'h200f0001;    //            addi    $t7, $zero, 1
        memory[92] = 32'h01b4702a;    //            slt    $t6, $t5, $s4
        memory[93] = 32'h01f5c022;    //            sub    $t8, $t7, $s5
        memory[94] = 32'h01d86020;    //            add    $t4, $t6, $t8
        memory[95] = 32'h200f0001;    //            addi    $t7, $zero, 1
        memory[96] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[97] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[98] = 32'h118f0069;    //            beq    $t4, $t7, move_diag_up
        memory[99] = 32'h02966822;    //            sub    $t5, $s4, $s6
        memory[100] = 32'h200e0002;    //            addi    $t6, $zero, 2
        memory[101] = 32'h01d57822;    //            sub    $t7, $t6, $s5
        memory[102] = 32'h01afc020;    //            add    $t8, $t5, $t7
        memory[103] = 32'h200c0001;    //            addi    $t4, $zero, 1
        memory[104] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[105] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[106] = 32'h1300003d;    //            beq    $t8, $zero, adjust_left
        memory[107] = 32'h02976822;    //            sub    $t5, $s4, $s7
        memory[108] = 32'h200e0002;    //            addi    $t6, $zero, 2
        memory[109] = 32'h01d57822;    //            sub    $t7, $t6, $s5
        memory[110] = 32'h01afc020;    //            add    $t8, $t5, $t7
        memory[111] = 32'h200c0001;    //            addi    $t4, $zero, 1
        memory[112] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[113] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[114] = 32'h1300003d;    //            beq    $t8, $zero, adjust_right
        memory[115] = 32'h000a6880;    //            sll    $t5, $t2, 2
        memory[116] = 32'h028d702a;    //            slt    $t6, $s4, $t5
        memory[117] = 32'h200f0004;    //            addi    $t7, $zero, 4
        memory[118] = 32'h02af6022;    //            sub    $t4, $s5, $t7
        memory[119] = 32'h01ccc020;    //            add    $t8, $t6, $t4
        memory[120] = 32'h200d0001;    //            addi    $t5, $zero, 1
        memory[121] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[122] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[123] = 32'h130d003c;    //            beq    $t8, $t5, move_right
        memory[124] = 32'h02966822;    //            sub    $t5, $s4, $s6
        memory[125] = 32'h200e0003;    //            addi    $t6, $zero, 3
        memory[126] = 32'h01d57822;    //            sub    $t7, $t6, $s5
        memory[127] = 32'h01af6020;    //            add    $t4, $t5, $t7
        memory[128] = 32'h20180001;    //            addi    $t8, $zero, 1
        memory[129] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[130] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[131] = 32'h11800024;    //            beq    $t4, $zero, adjust_left
        memory[132] = 32'h012b6822;    //            sub    $t5, $t1, $t3
        memory[133] = 32'h71aa6802;    //            mul    $t5, $t5, $t2
        memory[134] = 32'h000d6880;    //            sll    $t5, $t5, 2
        memory[135] = 32'h01b4702a;    //            slt    $t6, $t5, $s4
        memory[136] = 32'h200f0003;    //            addi    $t7, $zero, 3
        memory[137] = 32'h01f5c022;    //            sub    $t8, $t7, $s5
        memory[138] = 32'h001868c0;    //            sll    $t5, $t8, 3
        memory[139] = 32'h01ae6020;    //            add    $t4, $t5, $t6
        memory[140] = 32'h200f0001;    //            addi    $t7, $zero, 1
        memory[141] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[142] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[143] = 32'h118f0028;    //            beq    $t4, $t7, move_right
        memory[144] = 32'h02977822;    //            sub    $t7, $s4, $s7
        memory[145] = 32'h200e0004;    //            addi    $t6, $zero, 4
        memory[146] = 32'h01d5c022;    //            sub    $t8, $t6, $s5
        memory[147] = 32'h01f86020;    //            add    $t4, $t7, $t8
        memory[148] = 32'h20180001;    //            addi    $t8, $zero, 1
        memory[149] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[150] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[151] = 32'h11800018;    //            beq    $t4, $zero, adjust_right
        memory[152] = 32'h200c0001;    //            addi    $t4, $zero, 1
        memory[153] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[154] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[155] = 32'h12ac001c;    //            beq    $s5, $t4, move_right
        memory[156] = 32'h200c0002;    //            addi    $t4, $zero, 2
        memory[157] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[158] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[159] = 32'h12ac001c;    //            beq    $s5, $t4, move_down
        memory[160] = 32'h200c0003;    //            addi    $t4, $zero, 3
        memory[161] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[162] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[163] = 32'h12ac001f;    //            beq    $s5, $t4, move_diag_down
        memory[164] = 32'h200c0004;    //            addi    $t4, $zero, 4
        memory[165] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[166] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[167] = 32'h12ac0024;    //            beq    $s5, $t4, move_diag_up
        memory[168] = 32'h000a6880;    //    adjust_left:    sll    $t5, $t2, 2
        memory[169] = 32'h02cdb020;    //            add    $s6, $s6, $t5
        memory[170] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[171] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[172] = 32'h1700000f;    //            bne    $t8, $zero, move_down
        memory[173] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[174] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[175] = 32'h1580001c;    //            bne    $t4, $zero, move_diag_up
        memory[176] = 32'h000a6880;    //    adjust_right:    sll    $t5, $t2, 2
        memory[177] = 32'h02edb820;    //            add    $s7, $s7, $t5
        memory[178] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[179] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[180] = 32'h17000007;    //            bne    $t8, $zero, move_down
        memory[181] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[182] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[183] = 32'h1580000b;    //            bne    $t4, $zero, move_diag_down
        memory[184] = 32'h22940004;    //    move_right:    addi    $s4, $s4, 4
        memory[185] = 32'h20150001;    //            addi    $s5, $zero, 1
        memory[186] = 32'h21080001;    //            addi    $t0, $t0, 1
        memory[187] = 32'h08000030;    //            j    loop2
        memory[188] = 32'h00046020;    //    move_down:    add    $t4, $zero, $a0
        memory[189] = 32'h8d8c0004;    //            lw    $t4, 4($t4)
        memory[190] = 32'h000c6080;    //            sll    $t4, $t4, 2
        memory[191] = 32'h028ca020;    //            add    $s4, $s4, $t4
        memory[192] = 32'h20150002;    //            addi    $s5, $zero, 2
        memory[193] = 32'h23390001;    //            addi    $t9, $t9, 1
        memory[194] = 32'h08000030;    //            j    loop2
        memory[195] = 32'h00046020;    //    move_diag_down:    add    $t4, $zero, $a0
        memory[196] = 32'h8d8c0004;    //            lw    $t4, 4($t4)
        memory[197] = 32'h000c6080;    //            sll    $t4, $t4, 2
        memory[198] = 32'h028ca020;    //            add    $s4, $s4, $t4
        memory[199] = 32'h2294fffc;    //            addi    $s4, $s4, -4
        memory[200] = 32'h20150003;    //            addi    $s5, $zero, 3
        memory[201] = 32'h2108ffff;    //            addi    $t0, $t0, -1
        memory[202] = 32'h23390001;    //            addi    $t9, $t9, 1
        memory[203] = 32'h08000030;    //            j    loop2
        memory[204] = 32'h00046020;    //    move_diag_up:    add    $t4, $zero, $a0
        memory[205] = 32'h8d8c0004;    //            lw    $t4, 4($t4)
        memory[206] = 32'h000c6080;    //            sll    $t4, $t4, 2
        memory[207] = 32'h028ca022;    //            sub    $s4, $s4, $t4
        memory[208] = 32'h22940004;    //            addi    $s4, $s4, 4
        memory[209] = 32'h20150004;    //            addi    $s5, $zero, 4
        memory[210] = 32'h21080001;    //            addi    $t0, $t0, 1
        memory[211] = 32'h2339ffff;    //            addi    $t9, $t9, -1
        memory[212] = 32'h08000030;    //            j    loop2
        memory[213] = 32'h02201020;    //    return:        add    $v0, $s1, $zero
        memory[214] = 32'h02001820;    //            add    $v1, $s0, $zero
        memory[215] = 32'h8fbf0000;    //            lw    $ra, 0($sp)
        memory[216] = 32'h23bd0004;    //            addi    $sp, $sp, 4
        memory[217] = 32'h080000d9;    //    jump:        j    jump
        memory[218] = 32'h00004820;    //    SAD:        add    $t1, $zero, $zero
        memory[219] = 32'h02807020;    //            add    $t6, $s4, $zero
        memory[220] = 32'h0000c020;    //            add    $t8, $zero, $zero
        memory[221] = 32'h8c8d000c;    //            lw    $t5, 12($a0)
        memory[222] = 32'h8c8c0008;    //            lw    $t4, 8($a0)
        memory[223] = 32'h718d6802;    //            mul    $t5, $t4, $t5
        memory[224] = 32'h000d6880;    //            sll    $t5, $t5, 2
        memory[225] = 32'h8c8f000c;    //            lw    $t7, 12($a0)
        memory[226] = 32'h00006020;    //            add    $t4, $zero, $zero
        memory[227] = 32'h23180001;    //    loop1:        addi    $t8, $t8, 1
        memory[228] = 32'h00005020;    //            add    $t2, $zero, $zero
        memory[229] = 32'h00005820;    //            add    $t3, $zero, $zero
        memory[230] = 32'h012d502a;    //            slt    $t2, $t1, $t5
        memory[231] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[232] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[233] = 32'h11400027;    //            beq    $t2, $zero, exit
        memory[234] = 32'h01c55020;    //            add    $t2, $t6, $a1
        memory[235] = 32'h8d4b0000;    //            lw    $t3, 0($t2)
        memory[236] = 32'h00c95020;    //            add    $t2, $a2, $t1
        memory[237] = 32'h8d4a0000;    //            lw    $t2, 0($t2)
        memory[238] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[239] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[240] = 32'h016a082a;    //            slt    $at, $t3, $t2
        memory[241] = 32'h10200004;    //            beq    $at, $zero, sub_window
        memory[242] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[243] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[244] = 32'h016a082a;    //            slt    $at, $t3, $t2
        memory[245] = 32'h14200009;    //            bne    $at, $zero, sub_frame
        memory[246] = 32'h016a5022;    //    sub_window:    sub    $t2, $t3, $t2
        memory[247] = 32'h018a6020;    //            add    $t4, $t4, $t2
        memory[248] = 32'h21290004;    //            addi    $t1, $t1, 4
        memory[249] = 32'h030f582a;    //            slt    $t3, $t8, $t7
        memory[250] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[251] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[252] = 32'h1160000b;    //            beq    $t3, $zero, jump_row
        memory[253] = 32'h21ce0004;    //            addi    $t6, $t6, 4
        memory[254] = 32'h080000e3;    //            j    loop1
        memory[255] = 32'h014b5022;    //    sub_frame:    sub    $t2, $t2, $t3
        memory[256] = 32'h018a6020;    //            add    $t4, $t4, $t2
        memory[257] = 32'h21290004;    //            addi    $t1, $t1, 4
        memory[258] = 32'h030f582a;    //            slt    $t3, $t8, $t7
        memory[259] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[260] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[261] = 32'h11600002;    //            beq    $t3, $zero, jump_row
        memory[262] = 32'h21ce0004;    //            addi    $t6, $t6, 4
        memory[263] = 32'h080000e3;    //            j    loop1
        memory[264] = 32'h0000c020;    //    jump_row:    add    $t8, $zero, $zero
        memory[265] = 32'h8c8a0004;    //            lw    $t2, 4($a0)
        memory[266] = 32'h8c8b000c;    //            lw    $t3, 12($a0)
        memory[267] = 32'h000a5080;    //            sll    $t2, $t2, 2
        memory[268] = 32'h216bffff;    //            addi    $t3, $t3, -1
        memory[269] = 32'h000b5880;    //            sll    $t3, $t3, 2
        memory[270] = 32'h014b5022;    //            sub    $t2, $t2, $t3
        memory[271] = 32'h01ca7020;    //            add    $t6, $t6, $t2
        memory[272] = 32'h080000e3;    //            j    loop1
        memory[273] = 32'h0192682a;    //    exit:        slt    $t5, $t4, $s2
        memory[274] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[275] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[276] = 32'h15a00005;    //            bne    $t5, $zero, change
        memory[277] = 32'h024c6822;    //            sub    $t5, $s2, $t4
        memory[278] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[279] = 32'h00000000;    //            sll    $zero, $zero, 0
        memory[280] = 32'h11a00001;    //            beq    $t5, $zero, change
        memory[281] = 32'h08000031;    //            j    next
        memory[282] = 32'h01809020;    //    change:        add    $s2, $t4, $zero
        memory[283] = 32'h01008020;    //            add    $s0, $t0, $zero
        memory[284] = 32'h03208820;    //            add    $s1, $t9, $zero
        memory[285] = 32'h08000031;    //            j    next

    end
    
    always@(Address) begin
        Instruction <= memory[Address[31:2]];
    end
        
endmodule
