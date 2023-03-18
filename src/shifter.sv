`timescale 1ns / 1ps

import package_machine_data::*;
import package_shifter::*;

module shifter (
  input SHIFTER_OPERATION    operation,
  input MICRO1_MACHINE_WORD  in,
  input                      cin,
  output MICRO1_MACHINE_WORD out,
  output logic               cout
);
  always_comb
  case (operation)
    SHIFTER_OPERATION_LEFT_LOGICALLY:       {cout, out} = {in, cin};
    SHIFTER_OPERATION_RIGHT_LOGICALLY:      {cout, out} = {in[0], cin, in[15:1]};
    SHIFTER_OPERATION_LEFT_ARITHMETICALLY:  {cout, out} = {in[15], in[15], in[13:0], cin};
    SHIFTER_OPERATION_RIGHT_ARITHMETICALLY: {cout, out} = {in[0], in[15], in[15:1]};
    SHIFTER_OPERATION_EXTENSION:            {cout, out} = {in[7], {8{in[7]}}, in[7:0]};
    SHIFTER_OPERATION_SWAP:                 {cout, out} = {1'b0, in[7:0], in[15:8]};
    default:                                {cout, out} = {1'b0, in};
  endcase
endmodule
