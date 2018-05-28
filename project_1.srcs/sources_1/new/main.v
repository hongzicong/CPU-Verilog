`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/25 09:12:25
// Design Name: 
// Module Name: main
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


`include "PC.v"
`include "ALU.v"
`include "PC4.v"
`include "ControlUnit.v"
`include "DataSelect32.v"
`include "DataSelect32_plus.v"
`include "DataSelect5.v"
`include "SignOrZeroExtend.v"
`include "PCImmediate.v"
`include "Register.v"
`include "RAM.v"
`include "ROM.v"

module main(
    input CLK,
    input Reset,
    output [31:0] nowInstruction,
    output [31:0] nextAddress,
    output [31:0] aluResult,
    output [31:0] WriteData,
    output [31:0] a,
    output [31:0] b,
    output [31:0] extendData,
    output [31:0] dataOut,
    output [2:0] aluOp,
    output zero,
    output [1:0]pcSrc,
    output [5:0] Instruction);
    
    // in_pc is the input of PC, if PC says yes, then give output
    // out_pc_2 is instruction
    // out_pc_1 is address of next instruction
    wire [31:0] in_pc, out_pc, out_pc_1, out_pc_2, out_pc_3, out_pc_extend;
    wire [31:0] ALUResult, DataOut;
    wire [2:0] ALUOp;
    
    // Control Unit��ÿ���������
    wire Zero, ExtSel, PCWre, InsMemRW, RegDst, RegWre, ALUSrcA, ALUSrcB, DBDataSrc, mWR, mRD;
    wire [1:0] PCSrc;
    
    wire [31:0] ReadData1, ReadData2;
    wire [4:0] WriteReg;
    
    // sllָ������Ҫ�Ĳ���
    wire [31:0] sa_extend;
    assign sa_extend = {{17{0}}, out_pc_2[10:6]};
    
    // ALU����������ֵ
    wire [31:0] A, B;
    
    // ����Ľ��
    wire [31:0] DB;

    wire [4:0] RS, RT, RD;
    assign RS = out_pc_2[25:21];
    assign RT = out_pc_2[20:16];
    assign RD = out_pc_2[15:11];
    
    wire [15:0] IMM;
    assign IMM = out_pc_2[15:0];
    
    // TODO
    wire [31:0] JMP;
    assign JMP = {out_pc_1[31:28], out_pc_2[27:0], 1'b0, 1'b0};
    
    assign nowInstruction = out_pc_2;
    assign nextAddress = in_pc;
    assign aluResult = ALUResult;
    assign WriteData = DB;
    assign a = A;
    assign b = B;
    assign extendData = out_pc_extend;
    assign aluOp = ALUOp;
    assign dataOut = DataOut;
    assign zero = Zero;
    assign pcSrc = PCSrc;
    assign Instruction = out_pc_2[31:26];

    // PC
    PC PC(CLK, Reset, PCWre, in_pc, out_pc);
    
    // out_pc ��ǰָ���ַ����һЩ������Ҫ+4������j��beq����bne
    PC4 PC4(out_pc, out_pc_1);
    
    // ���ݵ�ǰָ���ַ out_pc �õ���ǰָ�� out_pc_2
    ROM ROM(InsMemRW, out_pc, out_pc_2);
    
    ControlUnit ControlUnit(out_pc_2[31:26], Zero, ExtSel, PCWre, InsMemRW, ALUSrcA, ALUSrcB, mRD, mWR, DBDataSrc, RegWre, RegDst, PCSrc, ALUOp);
    
    ALU ALU(A, B, ALUOp, ALUResult, Zero);
    
    // selector of A
    DataSelect32 DataSelect32_A(ReadData1, sa_extend, ALUSrcA, A);
    
    // selector of B
    DataSelect32 DataSelect32_B(ReadData2, out_pc_extend, ALUSrcB, B);
    
    // sign��zero extend��
    SignOrZeroExtend SignOrZeroExtend(IMM, ExtSel, out_pc_extend);
    
    // ���Ͻǵ��Ǹ�+�飬������һָ���ַ�͵õ���һָ���ַ
    PCImmediate PCImmediate(out_pc_1, out_pc_extend, out_pc_3);
    
    // ���Ͻ��Ǹ�ѡ��������ѡ��һ��ָ���ַ
    DataSelect32_plus DataSelect32_plus(out_pc_1, out_pc_3, JMP, PCSrc, in_pc);
    
    // ���½�RAM
    RAM RAM(CLK, mRD, mWR, ALUResult, ReadData2, DataOut);
    
    // ���½��Ǹ�ѡ����
    DataSelect32 DataSelect32_Result(ALUResult, DataOut, DBDataSrc, DB);
    
    // ����WriteReg��ѡ����    
    DataSelect5 DataSelect5(RT, RD, RegDst, WriteReg);
    
    // �м��Ǹ��Ĵ���
    Register Register(CLK, RS, RT, WriteReg, RegWre, DB, ReadData1, ReadData2);
    
endmodule
