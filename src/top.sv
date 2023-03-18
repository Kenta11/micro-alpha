`timescale 1ns / 1ps

module top (
  input clk_in,
  input rst_in,
  input rxd,
  output txd,
  output led_hlt,
  output led_ov
);
  // constant
  localparam [31:0] CLOCK_FREQUENCY = 32'd100_000_000;

  // registers and wires
  wire                   rst;
  MICRO1_CONTROL_ADDRESS cm_addr;
  MICRO1_CONTROL_WORD    cm_data;
  wire                   mm_we;
  MICRO1_MACHINE_ADDRESS mm_addr;
  MICRO1_MACHINE_WORD    mm_din;
  MICRO1_MACHINE_WORD    mm_dout;
  wire [7:0]             if_dout;
  wire                   if_empty;
  wire                   if_re;
  wire [7:0]             of_din;
  wire                   of_full;
  wire                   of_we;
  
  // modules
  micro_alpha cpu (
    .clk(clk_in),
    .rst(rst),
    .cm_addr(cm_addr),
    .cm_data(cm_data),
    .mm_addr(mm_addr),
    .mm_we(mm_we),
    .mm_din(mm_din),
    .mm_dout(mm_dout),
    .if_dout(if_dout),
    .if_empty(if_empty),
    .if_re(if_re),
    .of_din(of_din),
    .of_full(of_full),
    .of_we(of_we),
    .led_hlt(led_hlt),
    .led_ov(led_ov)
  );
  
  control_memory cm (
    .clka(clk_in),
    .addra(cm_addr),
    .douta(cm_data)
  );
  
  main_memory mm (
    .clka(clk_in),
    .addra(mm_addr),
    .dina(mm_dout),
    .douta(mm_din),
    .wea(mm_we)
  );
  
  uart_receiver #(
    .CLOCK_FREQUENCY(CLOCK_FREQUENCY)
  ) rx (
    .clk(clk_in),
    .rst(rst),
    .rxd(rxd),
    .dout(if_dout),
    .empty(if_empty),
    .re(if_re)
  );
  
  uart_transmitter #(
    .CLOCK_FREQUENCY(CLOCK_FREQUENCY)
  ) tx (
    .clk(clk_in),
    .rst(rst),
    .din(of_din),
    .full(of_full),
    .we(of_we),
    .txd(txd)
  );
  
  // logic
  assign rst = (~rst_in);
endmodule
