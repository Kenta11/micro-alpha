`timescale 1ns / 1ps

module uart_transmitter #(
  parameter [31:0] CLOCK_FREQUENCY = 32'd100_000_000,
  parameter [31:0] BAUD_RATE = 32'd115200,
  parameter [31:0] WORD_WIDTH = 32'd8
) (
  input                  clk,
  input                  rst,
  input [WORD_WIDTH-1:0] din,
  output                 full,
  input                  we,
  output                 txd
);
  // registers and wires
  logic [WORD_WIDTH-1:0] data;
  logic                  empty;
  logic                  re;

  // modules
  fifo_generator_0 fifo (
    .clk(clk),
    .srst(rst),
    .din(din),
    .full(full),
    .wr_en(we),
    .dout(data),
    .empty(empty),
    .rd_en(re)
  );

  uart_transmitter_controler #(
    .CLOCK_FREQUENCY(CLOCK_FREQUENCY),
    .BAUD_RATE(BAUD_RATE),
    .WORD_WIDTH(WORD_WIDTH)
  ) tx (
    .clk(clk),
    .rst(rst),
    .din(data),
    .empty(empty),
    .re(re),
    .dout(txd)
  );
endmodule
