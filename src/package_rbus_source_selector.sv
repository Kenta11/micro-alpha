`timescale 1ns / 1ps

package package_rbus_source_selector;
  typedef enum logic [3:0] {
    RBUS_SOURCE_SELECTOR_R0  = 4'b0000,
    RBUS_SOURCE_SELECTOR_R1  = 4'b0001,
    RBUS_SOURCE_SELECTOR_R2  = 4'b0010,
    RBUS_SOURCE_SELECTOR_R3  = 4'b0011,
    RBUS_SOURCE_SELECTOR_R4  = 4'b0100,
    RBUS_SOURCE_SELECTOR_R5  = 4'b0101,
    RBUS_SOURCE_SELECTOR_R6  = 4'b0110,
    RBUS_SOURCE_SELECTOR_R7  = 4'b0111,
    RBUS_SOURCE_SELECTOR_RA  = 4'b1000,
    RBUS_SOURCE_SELECTOR_RAP = 4'b1001,
    RBUS_SOURCE_SELECTOR_SLT = 4'b1010,
    RBUS_SOURCE_SELECTOR_LLT = 4'b1011,
    RBUS_SOURCE_SELECTOR_NRB = 4'b1111
  } RBUS_SOURCE_SELECTOR;
endpackage