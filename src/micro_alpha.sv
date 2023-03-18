`timescale 1ns / 1ps

module micro_alpha (
  input                         clk,
  input                         rst,
  output MICRO1_CONTROL_ADDRESS cm_addr,
  input  MICRO1_CONTROL_WORD    cm_data,
  output MICRO1_MACHINE_ADDRESS mm_addr,
  output                        mm_we,
  input  MICRO1_MACHINE_WORD    mm_din,
  output MICRO1_MACHINE_WORD    mm_dout,
  input  [7:0]                  if_dout,
  input                         if_empty,
  output                        if_re,
  output [7:0]                  of_din,
  input                         of_full,
  output                        of_we,
  output                        led_hlt,
  output                        led_ov
);
  // registers and wires
  control_interface c_inf();

  // modules  
  controler #(
    .ENTRY_POINT(12'h101)
  )
  controler0 (
    .clk(clk),
    .rst(rst),
    .c_inf(c_inf),
    .cm_addr(cm_addr),
    .cm_din(cm_data),
    .mm_we(mm_we),
    .if_empty(if_empty),
    .if_re(if_re),
    .of_full(of_full),
    .of_we(of_we),
    .led_hlt(led_hlt),
    .led_ov(led_ov)
  );

  datapath datapath0 (
    .clk(clk),
    .rst(rst),
    .c_inf(c_inf),
    .mm_addr(mm_addr),
    .mm_din(mm_din),
    .mm_dout(mm_dout),
    .if_dout(if_dout),
    .of_din(of_din)
  );
endmodule
