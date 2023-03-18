`timescale 1ns / 1ps

import package_alu::*;
import package_gpr_destination_selector::*;
import package_ir_source_selector::*;
import package_lbus_source_selector::*;
import package_machine_data::*;
import package_rbus_source_selector::*;
import package_shifter::*;

interface control_interface;
  LBUS_SOURCE_SELECTOR     lbus_source_selector;
  RBUS_SOURCE_SELECTOR     rbus_source_selector;
  ALU_OPERATION            alu_operation;
  SHIFTER_OPERATION        shifter_operation;
  GPR_DESTINATION_SELECTOR gpr_destination_selector;
  IR_SOURCE_SELECTOR       ir_source_selector;
  logic                    set_mar;
  logic                    set_fsr;
  logic                    set_pc;
  MICRO1_MACHINE_WORD      literal;
  logic [3:0]              flags;
  logic                    cin;
  logic                    inbus_valid;
  MICRO1_MACHINE_WORD      ir;
  logic                    alu_cout;
  logic                    shifter_cout;
  logic                    lbus_msb;
  logic                    rbus_msb;
  logic [7:0]              rbus_lower;
  MICRO1_MACHINE_WORD      abus;
  logic                    sbus_msb;

  modport controler (
    output lbus_source_selector,
    output rbus_source_selector,
    output alu_operation,
    output shifter_operation,
    output gpr_destination_selector,
    output ir_source_selector,
    output set_mar,
    output set_fsr,
    output set_pc,
    output literal,
    output flags,
    output cin,
    output inbus_valid,
    input ir,
    input alu_cout,
    input shifter_cout,
    input lbus_msb,
    input rbus_msb,
    input rbus_lower,
    input abus,
    input sbus_msb
  );

  modport datapath (
    input lbus_source_selector,
    input rbus_source_selector,
    input alu_operation,
    input shifter_operation,
    input gpr_destination_selector,
    input ir_source_selector,
    input set_mar,
    input set_fsr,
    input set_pc,
    input literal,
    input flags,
    input cin,
    input  inbus_valid,
    output ir,
    output alu_cout,
    output shifter_cout,
    output lbus_msb,
    output rbus_msb,
    output rbus_lower,
    output abus,
    output sbus_msb
  );
endinterface
