`timescale 1ns / 1ps

package package_lbus_source_selector;
  typedef enum logic [3:0] {
    LBUS_SOURCE_SELECTOR_R0  = 4'b0000,
    LBUS_SOURCE_SELECTOR_R1  = 4'b0001,
    LBUS_SOURCE_SELECTOR_R2  = 4'b0010,
    LBUS_SOURCE_SELECTOR_R3  = 4'b0011,
    LBUS_SOURCE_SELECTOR_R4  = 4'b0100,
    LBUS_SOURCE_SELECTOR_R5  = 4'b0101,
    LBUS_SOURCE_SELECTOR_R6  = 4'b0110,
    LBUS_SOURCE_SELECTOR_R7  = 4'b0111,
    LBUS_SOURCE_SELECTOR_RB  = 4'b1000,
    LBUS_SOURCE_SELECTOR_RBP = 4'b1001,
    LBUS_SOURCE_SELECTOR_PC  = 4'b1010,
    LBUS_SOURCE_SELECTOR_IO  = 4'b1011,
    LBUS_SOURCE_SELECTOR_MM  = 4'b1100,
    LBUS_SOURCE_SELECTOR_IR  = 4'b1101,
    LBUS_SOURCE_SELECTOR_FSR = 4'b1110,
    LBUS_SOURCE_SELECTOR_NLB = 4'b1111
  } LBUS_SOURCE_SELECTOR;
endpackage
