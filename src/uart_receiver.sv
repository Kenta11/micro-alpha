`timescale 1ns / 1ps

module uart_receiver #(
  parameter [31:0] CLOCK_FREQUENCY = 32'd100_000_000,
  parameter [31:0] BAUD_RATE = 32'd115200,
  parameter [31:0] WORD_WIDTH = 32'd8
) (
  input                   clk,
  input                   rst,
  input                   rxd,
  output [WORD_WIDTH-1:0] dout,
  output                  empty,
  input                   re
);
  // registers and wires
  logic [WORD_WIDTH-1:0] data;
  logic                  full;
  logic                  we;

  // modules
  uart_receiver_controler #(
    .CLOCK_FREQUENCY(CLOCK_FREQUENCY),
    .BAUD_RATE(BAUD_RATE),
    .WORD_WIDTH(WORD_WIDTH)
  ) rx (
    .clk(clk),
    .rst(rst),
    .din(rxd),
    .dout(data),
    .full(full),
    .we(we)
  );

  fifo_generator_0 fifo (
    .clk(clk),
    .srst(rst),
    .din(data),
    .full(full),
    .wr_en(we),
    .dout(dout),
    .empty(empty),
    .rd_en(re)
  );
endmodule
