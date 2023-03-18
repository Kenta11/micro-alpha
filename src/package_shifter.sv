`timescale 1ns / 1ps

package package_shifter;
  typedef enum logic [2:0] {
    SHIFTER_OPERATION_LEFT_LOGICALLY       = 3'b000,
    SHIFTER_OPERATION_RIGHT_LOGICALLY      = 3'b001,
    SHIFTER_OPERATION_LEFT_ARITHMETICALLY  = 3'b010,
    SHIFTER_OPERATION_RIGHT_ARITHMETICALLY = 3'b011,
    SHIFTER_OPERATION_EXTENSION            = 3'b100,
    SHIFTER_OPERATION_SWAP                 = 3'b101,
    SHIFTER_OPERATION_NOP                  = 3'b111
  } SHIFTER_OPERATION;
endpackage
