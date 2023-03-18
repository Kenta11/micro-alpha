`timescale 1ns / 1ps

import package_alu::*;
import package_machine_data::*;

module alu (
  input ALU_OPERATION        operation,
  input MICRO1_MACHINE_WORD  left,
  input MICRO1_MACHINE_WORD  right,
  input                      cin,
  output MICRO1_MACHINE_WORD result,
  output logic               cout
);
  always_comb 
  case (operation)
    ALU_OPERATION_ADD: {cout, result} = left + right + cin;
    ALU_OPERATION_SUB: {cout, result} = left - right - cin;
    ALU_OPERATION_AND: {cout, result} = left & right;
    ALU_OPERATION_XOR: {cout, result} = left ^ right;
    default:           {cout, result} = left | right;
  endcase
endmodule
