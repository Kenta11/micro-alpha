`timescale 1ns / 1ps

package package_alu;
  typedef enum logic [2:0] {
    ALU_OPERATION_ADD = 3'b000,
    ALU_OPERATION_SUB = 3'b001,
    ALU_OPERATION_AND = 3'b010,
    ALU_OPERATION_OR  = 3'b011,
    ALU_OPERATION_XOR = 3'b100,
    ALU_OPERATION_IAL = 3'b101,
    ALU_OPERATION_NOP = 3'b111
  } ALU_OPERATION;
endpackage
