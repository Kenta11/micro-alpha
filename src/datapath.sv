`timescale 1ns / 1ps

import package_alu::*;
import package_machine_data::*;
import package_gpr_destination_selector::*;
import package_ir_source_selector::*;
import package_lbus_source_selector::*;
import package_rbus_source_selector::*;
import package_shifter::*;

module datapath #(
  parameter [15:0] ENTRY_POINT = 16'h0140
)(
  input                         clk,
  input                         rst,
  control_interface.datapath    c_inf,
  output MICRO1_MACHINE_ADDRESS mm_addr,
  input  MICRO1_MACHINE_WORD    mm_din,
  output MICRO1_MACHINE_WORD    mm_dout,
  input  [7:0]                  if_dout,
  output [7:0]                  of_din
);
  // constant value
  localparam [15:0] CONSTANT_ZERO_16 = 16'h0;

  // registers and wires
  MICRO1_MACHINE_WORD gpr [0:7];
  MICRO1_MACHINE_WORD pc;
  logic [3:0]         fsr;
  MICRO1_MACHINE_WORD mar;
  wire  [3:0]         op;
  wire  [1:0]         ra;
  wire  [1:0]         rb;
  wire  [7:0]         nd;
  wire  [1:0]         rap;
  wire  [1:0]         rbp;
  wire  [1:0]         rbm;
  wire  [15:0]        lbus;
  wire  [15:0]        rbus;
  wire  [15:0]        sbus;
  MICRO1_MACHINE_WORD inbus;

  // submodules
  mux #(
    .WIDTH(16),
    .NUMBER(16)
  ) mux_for_lbus(
    .din({
      gpr[0],
      gpr[1],
      gpr[2],
      gpr[3],
      gpr[4],
      gpr[5],
      gpr[6],
      gpr[7],
      gpr[rb],
      gpr[rbp],
      pc,
      inbus,
      mm_din,
      c_inf.ir,
      {CONSTANT_ZERO_16[11:0], fsr},
      CONSTANT_ZERO_16
    }),
    .selector(c_inf.lbus_source_selector),
    .dout(lbus)
  );

  mux #(
    .WIDTH(16),
    .NUMBER(16)
  ) mux_for_rbus(
    .din({
      gpr[0],
      gpr[1],
      gpr[2],
      gpr[3],
      gpr[4],
      gpr[5],
      gpr[6],
      gpr[7],
      gpr[ra],
      gpr[rap],
      {7'h0, c_inf.literal[8:0]},
      c_inf.literal,
      CONSTANT_ZERO_16,
      CONSTANT_ZERO_16,
      CONSTANT_ZERO_16,
      CONSTANT_ZERO_16
    }),
    .selector(c_inf.rbus_source_selector),
    .dout(rbus)
  );

  alu alu0(
    .operation(c_inf.alu_operation),
    .left(lbus),
    .right(rbus),
    .cin(c_inf.cin),
    .result(c_inf.abus),
    .cout(c_inf.alu_cout)
  );

  shifter shifter0(
    .operation(c_inf.shifter_operation),
    .in(c_inf.abus),
    .cin(c_inf.cin),
    .out(sbus),
    .cout(c_inf.shifter_cout)
  );

  // logics
  assign c_inf.lbus_msb = lbus[15];
  assign c_inf.rbus_msb = rbus[15];
  assign c_inf.rbus_lower = rbus[7:0];
  assign c_inf.sbus_msb = sbus[15];

  always_ff@(posedge clk)
  if (rst)
  begin
    for (integer i = 0; i < 8; i = i + 1)
      gpr[i] <= CONSTANT_ZERO_16;
  end
  else
    case (c_inf.gpr_destination_selector)
      GPR_DESTINATION_SELECTOR_GPR0: gpr[0]   <= sbus;
      GPR_DESTINATION_SELECTOR_GPR1: gpr[1]   <= sbus;
      GPR_DESTINATION_SELECTOR_GPR2: gpr[2]   <= sbus;
      GPR_DESTINATION_SELECTOR_GPR3: gpr[3]   <= sbus;
      GPR_DESTINATION_SELECTOR_GPR4: gpr[4]   <= sbus;
      GPR_DESTINATION_SELECTOR_GPR5: gpr[5]   <= sbus;
      GPR_DESTINATION_SELECTOR_GPR6: gpr[6]   <= sbus;
      GPR_DESTINATION_SELECTOR_GPR7: gpr[7]   <= sbus;
      GPR_DESTINATION_SELECTOR_RA:   gpr[ra]  <= sbus;
      GPR_DESTINATION_SELECTOR_RAP:  gpr[rap] <= sbus;
      GPR_DESTINATION_SELECTOR_RB:   gpr[rb]  <= sbus;
      GPR_DESTINATION_SELECTOR_RBP:  gpr[rbp] <= sbus;
      default:                       gpr[0]   <= gpr[0];
    endcase

  always_ff@(posedge clk)
  if (rst)
    pc <= CONSTANT_ZERO_16;
  else if (c_inf.set_pc)
    pc <= sbus;
  else
    pc <= pc;

  always_ff@(posedge clk)
  if (rst)
    fsr <= CONSTANT_ZERO_16[3:0];
  else if (c_inf.set_fsr)
    fsr <= c_inf.flags;
  else
    fsr <= fsr;

  always_ff@(posedge clk)
  if (rst)
    mar <= ENTRY_POINT;
  else if (c_inf.set_mar)
    mar <= lbus;
  else
    mar <= mar;

  always_ff@(posedge clk)
  if (rst)
    c_inf.ir <= CONSTANT_ZERO_16;
  else
    case (c_inf.ir_source_selector)
      IR_SOURCE_SELECTOR_SET_IR:      c_inf.ir <= lbus;
      IR_SOURCE_SELECTOR_INCREASE_RA: c_inf.ir <= {op, rap, rb, nd};
      IR_SOURCE_SELECTOR_INCREASE_RB: c_inf.ir <= {op, ra, rbp, nd};
      IR_SOURCE_SELECTOR_DECREASE_RB: c_inf.ir <= {op, ra, rbm, nd};
      default:                        c_inf.ir <= c_inf.ir;
    endcase

  assign mm_addr          = mar;
  assign mm_dout          = lbus;
  assign of_din           = lbus[7:0];
  assign {op, ra, rb, nd} = c_inf.ir;
  assign rap              = c_inf.ir[11:10] + 2'b1;
  assign rbp              = c_inf.ir[ 9: 8] + 2'b1;
  assign rbm              = c_inf.ir[ 9: 8] - 2'b1;

  always_comb
  if (c_inf.inbus_valid) inbus = {CONSTANT_ZERO_16[7:0], if_dout};
  else                   inbus = CONSTANT_ZERO_16;
endmodule
