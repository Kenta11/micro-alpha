`timescale 1ns / 1ps

import package_alu::*;
import package_control_data::*;
import package_gpr_destination_selector::*;
import package_ir_source_selector::*;
import package_lbus_source_selector::*;
import package_rbus_source_selector::*;
import package_shifter::*;

module controler #(
  parameter [11:0] ENTRY_POINT = 12'h0
)(
  input                         clk,
  input                         rst,
  control_interface.controler   c_inf,
  output MICRO1_CONTROL_ADDRESS cm_addr,
  input  MICRO1_CONTROL_WORD    cm_din,
  output logic                  mm_we,
  input  logic                  if_empty,
  output logic                  if_re,
  input  logic                  of_full,
  output logic                  of_we,
  output logic                  led_hlt,
  output logic                  led_ov
);
  // type definitions
  typedef enum logic [2:0] {
    PHASE_INIT = 3'h0,
    PHASE_T1   = 3'h1,
    PHASE_T2   = 3'h2,
    PHASE_T3   = 3'h3,
    PHASE_T4   = 3'h4,
    PHASE_T5   = 3'h5,
    PHASE_HLT  = 3'h6
  } PHASE;
  typedef enum logic [3:0] {
    SB_R0   = 4'h0,
    SB_R1   = 4'h1,
    SB_R2   = 4'h2,
    SB_R3   = 4'h3,
    SB_R4   = 4'h4,
    SB_R5   = 4'h5,
    SB_R6   = 4'h6,
    SB_R7   = 4'h7,
    SB_RA   = 4'h8,
    SB_RAP  = 4'h9,
    SB_RB   = 4'hA,
    SB_RBP  = 4'hB,
    SB_PC   = 4'hC,
    SB_NONE = 4'hF
  } sb_t;
  typedef enum logic [1:0] {
    MM_RM  = 2'h0,
    MM_WM  = 2'h1,
    MM_NMM = 2'h3
  } mm_t;
  typedef enum logic [3:0] {
    SQ_B   = 4'h0,
    SQ_BP  = 4'h1,
    SQ_RTN = 4'h2,
    SQ_BT  = 4'h3,
    SQ_BF  = 4'h4,
    SQ_IOP = 4'h5,
    SQ_IRA = 4'h6,
    SQ_IAB = 4'h7,
    SQ_EI  = 4'h8,
    SQ_NSQ = 4'hF
  } sq_t;
  typedef enum logic [2:0] {
    TS_ZER = 3'h0,
    TS_NEG = 3'h1,
    TS_CRY = 3'h2,
    TS_OV  = 3'h3,
    TS_T   = 3'h4,
    TS_CZ  = 3'h5,
    TS_NTS = 3'h7
  } ts_t;
  typedef enum logic [3:0] {
    EX_CM1 = 4'h0,
    EX_FLS = 4'h1,
    EX_ASC = 4'h2,
    EX_AS1 = 4'h3,
    EX_LIR = 4'h4,
    EX_LIO = 4'h5,
    EX_SC  = 4'h6,
    EX_EIO = 4'h7,
    EX_ST  = 4'h8,
    EX_RT  = 4'h9,
    EX_INA = 4'hA,
    EX_INB = 4'hB,
    EX_DCB = 4'hC,
    EX_HLT = 4'hD,
    EX_OV  = 4'hE,
    EX_NEX = 4'hF
  } ex_t;

  // constant value
  localparam [39:0] CONSTANT_ZERO_40 = 40'h0;
  localparam [2:0]
    FLAG_INDEX_ZER = 3'h4,
    FLAG_INDEX_NEG = 3'h3,
    FLAG_INDEX_CRY = 3'h2,
    FLAG_INDEX_OV  = 3'h1,
    FLAG_INDEX_T   = 3'h0;

  // registers and wires
  PHASE                  phase;
  MICRO1_CONTROL_ADDRESS cmar;
  MICRO1_CONTROL_WORD    cmdr;
  MICRO1_CONTROL_WORD    cmar_stack [0:7];
  logic [2:0]            cmar_stack_pointer;
  logic                  mm_write_reservation;
  logic [7:0]            c;
  logic [5:0]            flags;
  logic                  flag_zer;
  logic                  flag_neg;
  logic                  flag_cry;
  logic                  flag_ov;
  logic                  flag_cz;
  logic                  flag_t;
  logic                  test;
  LBUS_SOURCE_SELECTOR   lb;
  RBUS_SOURCE_SELECTOR   rb;
  ALU_OPERATION          al;
  SHIFTER_OPERATION      sh;
  sb_t                   sb;
  mm_t                   mm;
  sq_t                   sq;
  wire [2:0]             ts;
  ex_t                   ex;
  wire [8:0]             lt;

  // logics
  assign c_inf.lbus_source_selector = lb;
  assign c_inf.rbus_source_selector = rb;

  always_comb
  case (al)
    ALU_OPERATION_IAL:
      case (c_inf.ir[14:12])
        3'b000:  c_inf.alu_operation = ALU_OPERATION_ADD;
        3'b001:  c_inf.alu_operation = ALU_OPERATION_SUB;
        3'b010:  c_inf.alu_operation = ALU_OPERATION_AND;
        3'b011:  c_inf.alu_operation = ALU_OPERATION_OR;
        3'b100:  c_inf.alu_operation = ALU_OPERATION_XOR;
        default: c_inf.alu_operation = ALU_OPERATION_NOP;
      endcase
    default: c_inf.alu_operation = al;
  endcase

  assign c_inf.shifter_operation = sh;
  
  always_comb
  case (phase)
    PHASE_T5:
    case (sb)
      SB_R0:   c_inf.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR0;
      SB_R1:   c_inf.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR1;
      SB_R2:   c_inf.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR2;
      SB_R3:   c_inf.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR3;
      SB_R4:   c_inf.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR4;
      SB_R5:   c_inf.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR5;
      SB_R6:   c_inf.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR6;
      SB_R7:   c_inf.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR7;
      SB_RA:   c_inf.gpr_destination_selector = GPR_DESTINATION_SELECTOR_RA;
      SB_RAP:  c_inf.gpr_destination_selector = GPR_DESTINATION_SELECTOR_RAP;
      SB_RB:   c_inf.gpr_destination_selector = GPR_DESTINATION_SELECTOR_RB;
      SB_RBP:  c_inf.gpr_destination_selector = GPR_DESTINATION_SELECTOR_RBP;
      default: c_inf.gpr_destination_selector = GPR_DESTINATION_SELECTOR_NONE;
    endcase
    default: c_inf.gpr_destination_selector = GPR_DESTINATION_SELECTOR_NONE;
  endcase

  always_comb
  case (phase)
    PHASE_T3:
    case (ex)
      EX_LIR:  c_inf.ir_source_selector = IR_SOURCE_SELECTOR_SET_IR;
      default: c_inf.ir_source_selector = IR_SOURCE_SELECTOR_NO_OPERATION;
    endcase
    PHASE_T5:
    case (ex)
      EX_INA:  c_inf.ir_source_selector = IR_SOURCE_SELECTOR_INCREASE_RA;
      EX_INB:  c_inf.ir_source_selector = IR_SOURCE_SELECTOR_INCREASE_RB;
      EX_DCB:  c_inf.ir_source_selector = IR_SOURCE_SELECTOR_DECREASE_RB;
      default: c_inf.ir_source_selector = IR_SOURCE_SELECTOR_NO_OPERATION;
    endcase
    default: c_inf.ir_source_selector = IR_SOURCE_SELECTOR_NO_OPERATION;
  endcase

  always_comb
  case (phase)
    PHASE_T2:
    case (mm)
      MM_RM:   c_inf.set_mar = 1'b1;
      MM_WM:   c_inf.set_mar = 1'b1;
      default: c_inf.set_mar = 1'b0;
    endcase
    default: c_inf.set_mar = 1'b0;
  endcase

  always_comb
  case (phase)
    PHASE_T5:
    case (ex)
      EX_FLS:  c_inf.set_fsr = 1'b1;
      default: c_inf.set_fsr = 1'b0;
    endcase
    default: c_inf.set_fsr = 1'b0;
  endcase

  always_comb
  case (phase)
    PHASE_T5:
    case (sb)
      SB_PC:   c_inf.set_pc = 1'b1;
      default: c_inf.set_pc = 1'b0;
    endcase
    default: c_inf.set_pc = 1'b0;
  endcase

  assign c_inf.literal = {ts, ex, lt};
  assign c_inf.flags = {flag_zer, flag_neg, flag_cry, flag_ov};

  always_comb
  case (ex)
    EX_ASC:  c_inf.cin = flags[FLAG_INDEX_CRY];
    EX_AS1:  c_inf.cin = 1'h1;
    default: c_inf.cin = 1'h0;
  endcase

  always_ff@(posedge clk)
  if (rst) c_inf.inbus_valid <= 1'b0;
  else
  case (phase)
    PHASE_T2:
      case (ex)
        EX_EIO:
        begin
          if (c_inf.ir == 16'hEC00) c_inf.inbus_valid <= ~if_empty;
          else                      c_inf.inbus_valid <= c_inf.inbus_valid;
        end
        default: c_inf.inbus_valid <= c_inf.inbus_valid;
      endcase
    default: c_inf.inbus_valid <= c_inf.inbus_valid;
  endcase

  assign cm_addr = cmar;

  always_comb
  case (phase)
    PHASE_T2: mm_we = mm_write_reservation;
    default:  mm_we = 1'h0;
  endcase

  always_comb
  case (phase)
    PHASE_T2:
    case (ex)
      EX_EIO:  if_re = (c_inf.ir == 16'hEC00) && (~if_empty);
      default: if_re = 1'b0;
    endcase
    default: if_re = 1'b0;
  endcase

  always_comb
  case (phase)
    PHASE_T3:
    case (ex)
      EX_LIO:  of_we = (c_inf.ir == 16'hED01) && (~of_full);
      default: of_we = 1'b0;
    endcase
    default: of_we = 1'b0;
  endcase

  always_ff@(posedge clk)
  if (rst) led_hlt <= 1'h0;
  else
  case (phase)
    PHASE_T5:
    case (ex)
      EX_HLT:  led_hlt <= 1'h1;
      default: led_hlt <= 1'h0;
    endcase
    default: led_hlt <= led_hlt;
  endcase

  always_ff@(posedge clk)
  if (rst) led_ov <= 1'h0;
  else
  case (phase)
    PHASE_T5:
    case (ex)
      EX_OV:   led_ov <= 1'h1;
      default: led_ov <= 1'h0;
    endcase
    default: led_ov <= led_ov;
  endcase

  always_ff@(posedge clk)
  if (rst) phase <= PHASE_INIT;
  else
  case (phase)
    PHASE_INIT: phase <= PHASE_T1;
    PHASE_T1:   phase <= PHASE_T2;
    PHASE_T2:   phase <= PHASE_T3;
    PHASE_T3:   phase <= PHASE_T4;
    PHASE_T4:   phase <= PHASE_T5;
    PHASE_T5:
    case (ex)
      EX_HLT:  phase <= PHASE_HLT;
      EX_OV:   phase <= PHASE_HLT;
      default: phase <= PHASE_T1;
    endcase
    default:    phase <= phase;
  endcase

  always_ff@(posedge clk)
  if (rst) cmar <= ENTRY_POINT;
  else
  case (phase)
    PHASE_T2:
    case (sq)
      SQ_B:    cmar <= {ts, lt};
      SQ_BP:   cmar <= {ts, lt};
      SQ_RTN:  cmar <= cmar_stack[cmar_stack_pointer - 3'h1];
      SQ_BT:   cmar <= test ? {cmar[11:9], lt} : (cmar + 12'h1);
      SQ_BF:   cmar <= test ? (cmar + 12'h1) : {cmar[11:9], lt};
      SQ_IOP:  cmar <= {lt[7:0], c_inf.ir[15:12]};
      SQ_IRA:  cmar <= {ts[0], lt[8:2], c_inf.ir[11:10], lt[1:0]};
      SQ_IAB:  cmar <= {ts[0], lt[8:4], c_inf.ir[11: 8], lt[1:0]};
      SQ_EI:   cmar <= test ? CONSTANT_ZERO_40[11:0] : {cmar[11:9], lt};
      default: cmar <= cmar + 12'h1;
    endcase
    default: cmar <= cmar;
  endcase

  always_ff@(posedge clk)
  if (rst)
    cmdr <= {
      LBUS_SOURCE_SELECTOR_NLB,
      RBUS_SOURCE_SELECTOR_NRB,
      ALU_OPERATION_NOP,
      SHIFTER_OPERATION_NOP,
      SB_NONE,
      MM_NMM,
      SQ_NSQ,
      TS_NTS,
      EX_NEX,
      9'h0
    };
  else
  case (phase)
    PHASE_INIT: cmdr <= cm_din;
    PHASE_T5:   cmdr <= cm_din;
    default:    cmdr <= cmdr;
  endcase

  always_ff@(posedge clk)
  if (rst)
    for (integer i = 0; i < 8; i = i + 1)
      cmar_stack[i] <= CONSTANT_ZERO_40[11:0];
  else
  case (phase)
    PHASE_T2:
    case (sq)
      SQ_BP:   cmar_stack[cmar_stack_pointer] <= cmar;
      default: cmar_stack[cmar_stack_pointer] <= cmar_stack[cmar_stack_pointer];
    endcase
    default: cmar_stack[cmar_stack_pointer] <= cmar_stack[cmar_stack_pointer];
  endcase

  always_ff@(posedge clk)
  if (rst) cmar_stack_pointer = 3'h0;
  else
  case (phase)
    PHASE_T2:
    case (sq)
      SQ_BP:   cmar_stack_pointer <= cmar_stack_pointer + 3'h1;
      SQ_RTN:  cmar_stack_pointer <= cmar_stack_pointer - 3'h1;
      default: cmar_stack_pointer <= cmar_stack_pointer;
    endcase
    default: cmar_stack_pointer <= cmar_stack_pointer;
  endcase

  always_ff@(posedge clk)
  if (rst) mm_write_reservation <= 1'h0;
  else
  case (phase)
    PHASE_T2: mm_write_reservation <= mm == MM_WM;
    default:  mm_write_reservation <= mm_write_reservation;
  endcase

  always_ff@(posedge clk)
  if (rst) c <= CONSTANT_ZERO_40[7:0];
  else
  case (phase)
    PHASE_T5:
      case (ex)
        EX_CM1:  c <= c - 8'h1;
        EX_SC:   c <= c_inf.rbus_lower;
        default: c <= c;
      endcase
    default: c <= c;
  endcase

  always_ff@(posedge clk)
  if (rst) flags <= 6'h0;
  else
  case (phase)
    PHASE_T5: flags <= {flag_zer, flag_neg, flag_cry, flag_ov, flag_t};
    default:  flags <= flags;
  endcase

  always_comb
  case (al)
    ALU_OPERATION_ADD: flag_zer = c_inf.abus == CONSTANT_ZERO_40[15:0];
    ALU_OPERATION_SUB: flag_zer = c_inf.abus == CONSTANT_ZERO_40[15:0];
    ALU_OPERATION_AND: flag_zer = c_inf.abus == CONSTANT_ZERO_40[15:0];
    ALU_OPERATION_OR:  flag_zer = c_inf.abus == CONSTANT_ZERO_40[15:0];
    default:           flag_zer = 1'h0;
  endcase

  always_comb
  case (al)
    ALU_OPERATION_ADD: flag_neg = c_inf.abus[15];
    ALU_OPERATION_SUB: flag_neg = c_inf.abus[15];
    default:           flag_neg = 1'h0;
  endcase

  always_comb
  case (c_inf.shifter_operation)
    SHIFTER_OPERATION_LEFT_LOGICALLY:       flag_cry = c_inf.shifter_cout;
    SHIFTER_OPERATION_RIGHT_LOGICALLY:      flag_cry = c_inf.shifter_cout;
    SHIFTER_OPERATION_LEFT_ARITHMETICALLY:  flag_cry = c_inf.shifter_cout;
    SHIFTER_OPERATION_RIGHT_ARITHMETICALLY: flag_cry = c_inf.shifter_cout;
    SHIFTER_OPERATION_EXTENSION:            flag_cry = c_inf.shifter_cout;
    default:
      case (al)
        ALU_OPERATION_ADD: flag_cry = c_inf.alu_cout;
        ALU_OPERATION_SUB: flag_cry = c_inf.alu_cout;
        default:           flag_cry = c_inf.alu_cout;
      endcase
  endcase

  always_comb
  case (c_inf.shifter_operation)
    SHIFTER_OPERATION_LEFT_ARITHMETICALLY: flag_ov = c_inf.abus[15] ^ c_inf.sbus_msb;
    default:
      case (al)
        ALU_OPERATION_ADD: flag_ov = (c_inf.lbus_msb == c_inf.rbus_msb) ^ c_inf.abus[15];
        ALU_OPERATION_SUB: flag_ov = (c_inf.lbus_msb | (~c_inf.rbus_msb) | c_inf.abus[15]) | ((~c_inf.lbus_msb) | c_inf.rbus_msb | (~c_inf.abus[15]));
        default:           flag_ov = 1'h0;
      endcase
  endcase

  assign flag_cz = c == 8'h0;

  always_comb
  case (ex)
    EX_ST:   flag_t = 1'h1;
    EX_RT:   flag_t = 1'h0;
    default: flag_t = 1'h0;
  endcase

  always_comb
  case (ts)
    TS_ZER:  test = flags[FLAG_INDEX_ZER];
    TS_NEG:  test = flags[FLAG_INDEX_NEG];
    TS_CRY:  test = flags[FLAG_INDEX_CRY];
    TS_OV:   test = flags[FLAG_INDEX_OV];
    TS_T:    test = flags[FLAG_INDEX_T];
    TS_CZ:   test = flag_cz;
    default: test = 1'h1;
  endcase

  assign {lb, rb, al, sh, sb, mm, sq, ts, ex, lt} = cmdr;
endmodule
