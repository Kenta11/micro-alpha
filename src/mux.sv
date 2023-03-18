`timescale 1ns / 1ps
module mux #(
  parameter WIDTH = 32,
  parameter NUMBER = 2,
  localparam CEILING_LOG2_OF_NUMBER = $clog2(NUMBER)
)(
  input  [WIDTH - 1:0]                  din [0:NUMBER - 1],
  input  [CEILING_LOG2_OF_NUMBER - 1:0] selector,
  output [WIDTH - 1:0]                  dout
);
  assign dout = din[selector];
endmodule
