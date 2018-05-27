`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/25 10:18:56
// Design Name: 
// Module Name: ControlUnit
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


module ControlUnit(
    input [5:0] OpCode,
    input zero, 
    // ��չ��ʽ
    output reg ExtSel,
    // PC�Ƿ����
    output reg PCWre,
    // дָ��Ͷ�ָ��洢��
    output reg InsMemRW,
    // ALU��һ��������������
    output reg ALUSrcA,
    // ALU�ڶ���������������
    output reg ALUSrcB,
    // �����ݴ洢��
    output reg mRD,
    // д���ݴ洢��
    output reg mWR,
    // �����������
    output reg DBDataSrc,
    // ����д�Ĵ���
    output reg RegWre,
    // д�Ĵ�����Ĵ����ĵ�ַ
    output reg RegDst,
    // ָ���֧ѡ��
    output reg [1:0] PCSrc,
    // operator 3 bits
    output reg [2:0] ALUOp);

    initial begin
        ExtSel = 0;
        PCWre = 0;
        InsMemRW = 1;
        ALUSrcA = 0;
        ALUSrcB = 0;
        RegDst = 0;
        DBDataSrc = 0;
        RegWre = 0;
    end

    always@(OpCode or zero) 
    begin
        case(OpCode)
            6'b000000:
            // add
            begin
                PCWre = 1;
                InsMemRW = 1;
                mRD = 0;
                mWR = 0;
                ALUSrcA = 0;
                ALUSrcB = 0;
                ExtSel = 1;
                DBDataSrc = 0;
                RegWre = 1;
                RegDst = 1;
                PCSrc = 00;
                ALUOp = 000;
            end
            6'b000001:
            // addi
            begin
                PCWre = 1;
                InsMemRW = 1;
                mRD = 0;
                mWR = 0;
                ALUSrcA = 0;
                ALUSrcB = 1;
                ExtSel = 1;
                DBDataSrc = 0;
                RegWre = 1;
                RegDst = 0;
                PCSrc = 00;
                ALUOp = 000;
            end
            6'b000010:
            // sub
            begin
                PCWre = 1;
                InsMemRW = 1;
                mRD = 0;
                mWR = 0;
                ALUSrcA = 0;
                ALUSrcB = 0;
                ExtSel = 1;
                DBDataSrc = 0;
                RegWre = 1;
                RegDst = 1;
                PCSrc = 00;
                ALUOp = 001;
            end
            6'b010000:
            // ori
            begin
                PCWre = 1;
                InsMemRW = 1;
                mRD = 0;
                mWR = 0;
                ALUSrcA = 0;
                ALUSrcB = 1;
                ExtSel = 0;
                DBDataSrc = 0;
                RegWre = 1;
                RegDst = 0;
                PCSrc = 00;
                ALUOp = 011;
            end
            6'b010001:
            // and
            begin
                PCWre = 1;
                InsMemRW = 1;
                mRD = 0;
                mWR = 0;
                ALUSrcA = 0;
                ALUSrcB = 0;
                ExtSel = 1;
                DBDataSrc = 0;
                RegWre = 1;
                RegDst = 1;
                PCSrc = 00;
                ALUOp = 100;
            end
            6'b010010:
            // or
            begin
                PCWre = 1;
                InsMemRW = 1;
                mRD = 0;
                mWR = 0;
                ALUSrcA = 0;
                ALUSrcB = 0;
                ExtSel = 1;
                DBDataSrc = 0;
                RegWre = 1;
                RegDst = 1;
                PCSrc = 00;
                ALUOp = 011;
            end
            6'b011000:
            // sll
            begin
                PCWre = 1;
                InsMemRW = 1;
                mRD = 0;
                mWR = 0;
                ALUSrcA = 1;
                ALUSrcB = 0;
                ExtSel = 0;
                DBDataSrc = 0;
                RegWre = 1;
                RegDst = 1;
                PCSrc = 00;
                ALUOp = 010;
            end
            6'b011011:
            // slti
            begin
                PCWre = 1;
                InsMemRW = 1;
                mRD = 0;
                mWR = 0;
                ALUSrcA = 0;
                ALUSrcB = 1;
                ExtSel = 1;
                DBDataSrc = 0;
                RegWre = 1;
                RegDst = 0;
                PCSrc = 00;
                ALUOp = 110;
            end
            6'b100110:
            // sw
            begin
                PCWre = 1;
                InsMemRW = 1;
                mRD = 0;
                mWR = 1;
                ALUSrcA = 0;
                ALUSrcB = 1;
                ExtSel = 1;
                DBDataSrc = 0;
                RegWre = 0;
                RegDst = 0;
                PCSrc = 00;
                ALUOp = 000;
            end
            6'b100111:
            // lw
            begin
                PCWre = 1;
                InsMemRW = 1;
                mRD = 1;
                mWR = 0;
                ALUSrcA = 0;
                ALUSrcB = 1;
                ExtSel = 1;
                DBDataSrc = 1;
                RegWre = 1;
                RegDst = 0;
                PCSrc = 00;
                ALUOp = 000;
            end
            6'b110000:
            // beq
            begin
                PCWre = 1;
                if (zero) 
                begin
                    PCSrc = 01;
                end 
                else 
                begin
                    PCSrc = 00;
                end
                InsMemRW = 1;
                mRD = 0;
                mWR = 0;
                ALUSrcA = 0;
                ALUSrcB = 0;
                DBDataSrc = 0;
                RegWre = 0;
                RegDst = 0;
                ExtSel = 1;
                ALUOp = 001;
            end
            6'b110001:
            // bne
            begin
                PCWre = 1;
                if (zero) 
                begin
                    PCSrc = 00;
                end 
                else 
                begin
                    PCSrc = 01;
                end
                InsMemRW = 1;
                mRD = 0;
                mWR = 0;
                ALUSrcA = 0;
                ALUSrcB = 0;
                RegDst = 0;
                DBDataSrc = 0;
                RegWre = 0;
                ExtSel = 1;
                ALUOp = 001;
            end
            6'b111000:
            // j
            begin
                PCWre = 1;
                InsMemRW = 1;
                mRD = 0;
                mWR = 0;
                ALUSrcA = 0;
                ALUSrcB = 0;
                ExtSel = 1;
                DBDataSrc = 0;
                RegWre = 0;
                RegDst = 0;
                PCSrc = 10;
                ALUOp = 010;
            end
            6'b111111:
            // halt
            begin
                PCWre = 0;
                InsMemRW = 0;
                mRD = 0;
                mWR = 0;
                ALUSrcA = 0;
                ALUSrcB = 0;
                ExtSel = 0;
                RegDst = 0;
                DBDataSrc = 0;
                RegWre = 0;
                PCSrc = 00;
                ALUOp = 000;
            end
    endcase
  end
endmodule