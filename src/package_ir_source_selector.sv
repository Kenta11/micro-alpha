`timescale 1ns / 1ps

package package_ir_source_selector;
  typedef enum logic [2:0] {
    IR_SOURCE_SELECTOR_NO_OPERATION = 3'b000,
    IR_SOURCE_SELECTOR_SET_IR       = 3'b001,
    IR_SOURCE_SELECTOR_INCREASE_RA  = 3'b010,
    IR_SOURCE_SELECTOR_INCREASE_RB  = 3'b011,
    IR_SOURCE_SELECTOR_DECREASE_RB  = 3'b100
  } IR_SOURCE_SELECTOR;
endpackage
