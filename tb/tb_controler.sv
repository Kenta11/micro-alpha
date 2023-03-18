`include "vunit_defines.svh"
`timescale 1ns/1ns

module tb_control;
  import package_alu::*;
  import package_control_data::*;
  import package_gpr_destination_selector::*;
  import package_ir_source_selector::*;
  import package_lbus_source_selector::*;
  import package_rbus_source_selector::*;
  import package_shifter::*;

  localparam [31:0] CLOCK_PERIOD = 32'd10;

  logic                  clk;
  logic                  rst;
  control_interface      c_inf();
  MICRO1_CONTROL_ADDRESS cm_addr;
  MICRO1_CONTROL_WORD    cm_din;
  logic                  mm_we;
  logic                  if_empty;
  logic                  if_re;
  logic                  of_full;
  logic                  of_we;
  logic                  led_hlt;
  logic                  led_ov;

  always
    #(CLOCK_PERIOD/2) clk = ~clk;

  `TEST_SUITE begin
    `TEST_CASE_SETUP begin
      clk                = 1'b0;
      rst                = 1'b0;
      c_inf.ir           = 16'h0;
      c_inf.alu_cout     = 1'b0;
      c_inf.shifter_cout = 1'b0;
      c_inf.lbus_msb     = 1'b0;
      c_inf.rbus_msb     = 1'b0;
      c_inf.rbus_lower   = 8'h0;
      c_inf.abus         = 16'h0;
      c_inf.sbus_msb     = 1'b0;
      cm_din             = 40'hFFFFFFFFFF;
      mm_we              = 1'b0;
      if_empty           = 1'b1;
      of_full            = 1'b1;
      led_hlt            = 1'b0;
      led_ov             = 1'b0;

      #CLOCK_PERIOD;

      rst = 1'b1;

      #CLOCK_PERIOD;

      rst = 1'b0;
    end
    `TEST_CASE("test_lbus") begin
      /*************************** phase INIT ***************************/
      cm_din             = 40'h0FFFFFFE00;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_R0);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_R0);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_R0);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_R0);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_R0);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_rbus") begin
      /*************************** phase INIT ***************************/
      cm_din             = 40'hF0FFFFFE00;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_R0);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_R0);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_R0);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_R0);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_R0);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_al") begin
      /*************************** phase INIT ***************************/
      cm_din             = 40'hFF1FFFFE00;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_ADD);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b1001);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_ADD);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b1001);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_ADD);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b1001);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_ADD);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b1001);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_ADD);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b1001);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_sh") begin
      /*************************** phase INIT ***************************/
      cm_din             = 40'hFFE3FFFE00;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_LEFT_LOGICALLY);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_LEFT_LOGICALLY);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_LEFT_LOGICALLY);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_LEFT_LOGICALLY);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_LEFT_LOGICALLY);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_sbus_to_gpr") begin
      /*************************** phase INIT ***************************/
      cm_din             = 40'hFFFC3FFE00;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_GPR0);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_sbus_to_pc") begin
      /*************************** phase INIT ***************************/
      cm_din             = 40'hFFFF3FFE00;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b1);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_mm_rm") begin
      /*************************** phase INIT ***************************/
      cm_din             = 40'hFFFFCFFE00;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b1);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      cm_din             = 40'hFFFFFFFE00;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h002);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h002);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h002);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_mm_wm") begin
      /*************************** phase INIT ***************************/
      cm_din             = 40'hFFFFDFFE00;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b1);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      cm_din             = 40'hFFFFFFFE00;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b1);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h002);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h002);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h002);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_sq") begin
      /*************************** phase INIT ***************************/
      cm_din             = 40'hFFFFF0FE00;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'hE00);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'hE00);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'hE00);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_ex_fls") begin
      /*************************** phase INIT ***************************/
      cm_din             = 40'hFFFFFFE200;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hE200);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hE200);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hE200);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hE200);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b1);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hE200);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_ex_asc") begin
      /*************************** phase INIT ***************************/
      cm_din             = 40'hFFFFFFE400;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hE400);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hE400);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hE400);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hE400);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hE400);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_ex_as1") begin
      /*************************** phase INIT ***************************/
      cm_din             = 40'hFFFFFFE600;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hE600);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b1);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hE600);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b1);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hE600);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b1);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hE600);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b1);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hE600);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b1);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_ex_lir") begin
      /*************************** phase INIT ***************************/
      cm_din             = 40'hFFFFFFE800;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hE800);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hE800);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_SET_IR);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hE800);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hE800);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hE800);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_ex_lio") begin
      /*************************** phase INIT ***************************/
      c_inf.ir           = 16'hED01;
      cm_din             = 40'hFFFFFFEA00;
      of_full            = 1'b0;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hEA00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hEA00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hEA00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b1);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hEA00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hEA00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_ex_eio") begin
      /*************************** phase INIT ***************************/
      c_inf.ir           = 16'hEC00;
      cm_din             = 40'hFFFFFFEE00;
      if_empty           = 1'b0;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hEE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hEE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b1);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hEE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b1);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hEE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b1);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hEE00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b1);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_ex_ina") begin
      /*************************** phase INIT ***************************/
      cm_din             = 40'hFFFFFFF400;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hF400);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hF400);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hF400);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hF400);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_INCREASE_RA);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hF400);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_ex_inb") begin
      /*************************** phase INIT ***************************/
      cm_din             = 40'hFFFFFFF600;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hF600);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hF600);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hF600);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hF600);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_INCREASE_RB);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hF600);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_ex_dcb") begin
      /*************************** phase INIT ***************************/
      cm_din             = 40'hFFFFFFF800;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hF800);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hF800);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hF800);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hF800);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_DECREASE_RB);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hF800);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_ex_hlt") begin
      /*************************** phase INIT ***************************/
      cm_din             = 40'hFFFFFFFA00;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFA00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFA00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFA00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFA00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFA00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase HLT ***************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFA00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b1);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_ex_ov") begin
      /*************************** phase INIT ***************************/
      cm_din             = 40'hFFFFFFFC00;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFC00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFC00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFC00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFC00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFC00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase OV ****************************/
      `CHECK_EQUAL(c_inf.lbus_source_selector, LBUS_SOURCE_SELECTOR_NLB);
      `CHECK_EQUAL(c_inf.rbus_source_selector, RBUS_SOURCE_SELECTOR_NRB);
      `CHECK_EQUAL(c_inf.alu_operation, ALU_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.shifter_operation, SHIFTER_OPERATION_NOP);
      `CHECK_EQUAL(c_inf.gpr_destination_selector, GPR_DESTINATION_SELECTOR_NONE);
      `CHECK_EQUAL(c_inf.ir_source_selector, IR_SOURCE_SELECTOR_NO_OPERATION);
      `CHECK_EQUAL(c_inf.set_mar, 1'b0);
      `CHECK_EQUAL(c_inf.set_fsr, 1'b0);
      `CHECK_EQUAL(c_inf.set_pc, 1'b0);
      `CHECK_EQUAL(c_inf.literal, 16'hFC00);
      `CHECK_EQUAL(c_inf.flags, 4'b0000);
      `CHECK_EQUAL(c_inf.cin, 1'b0);
      `CHECK_EQUAL(c_inf.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b1);
    end
  end

  `WATCHDOG(1ms);

  controler dut(.*);
endmodule
