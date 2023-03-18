# MICRO-alpha processor

## About

MICRO-alpha is a CISC implementation.
It is the tiny microprogram-controlled computer for educational purposes.
It runs all MICRO-1 control programs and machine programs.

## Features

- 16-bit CISC core built with microprogram control unit and simple datapath
- Synthesizable SystemVerilog in Xilinx Vivado
- Rich unit tests for the components
- Serial communication support with read and write instructions

## Directories

|  name  | Contents                                     |
|:------:|:---------------------------------------------|
|  src   | MICRO-alpha in SystemVerilog                 |
|   tb   | Unit tests for MICRO-alpha components in src |
| script | Utility script                               |

## Unit tests

### Environment

- OS: Linux (Manjaro)
- Testing framework: [VUnit](https://github.com/VUnit/vunit)
- GNU Make

### Usage

Run the following command on the environment installed ModelSim.

```
$ make test
python run.py
Compiling into lib:       src/package_shifter.sv                                                  passed
Compiling into lib:       src/package_rbus_source_selector.sv                                     passed
Compiling into lib:       src/package_machine_data.sv                                             passed
Compiling into lib:       src/shifter.sv                                                          passed
Compiling into lib:       src/package_lbus_source_selector.sv                                     passed
Compiling into lib:       src/package_ir_source_selector.sv                                       passed
Compiling into lib:       src/package_gpr_destination_selector.sv                                 passed
Compiling into lib:       src/package_control_data.sv                                             passed
Compiling into lib:       src/package_alu.sv                                                      passed
Compiling into lib:       src/mux.sv                                                              passed
Compiling into lib:       src/controler.sv                                                        passed
Compiling into lib:       src/control_interface.sv                                                passed
Compiling into lib:       src/alu.sv                                                              passed
Compiling into lib:       src/datapath.sv                                                         passed
Compiling into vunit_lib: ../../../.local/lib/python3.10/site-packages/vunit/verilog/vunit_pkg.sv passed
Compiling into lib:       tb/tb_shifter.sv                                                        passed
Compiling into lib:       tb/tb_mux.sv                                                            passed
Compiling into lib:       tb/tb_datapath.sv                                                       passed
Compiling into lib:       tb/tb_controler.sv                                                      passed
Compiling into lib:       tb/tb_alu.sv                                                            passed
Compile passed

Starting lib.tb_alu.test_add_without_carry
Output file: /home/kenta/Programs/fpga/micro1/vunit_out/test_output/lib.tb_alu.test_add_without_carry_57a1e4a5b731c43abe88abd39eb7735a108137ce/output.txt
pass (P=1 S=0 F=0 T=76) lib.tb_alu.test_add_without_carry (0.7 seconds)

...

Starting lib.tb_shifter.test_nop
Output file: /home/kenta/Programs/fpga/micro1/vunit_out/test_output/lib.tb_shifter.test_nop_000928b615edea74de0f9847e69063394879774f/output.txt
pass (P=76 S=0 F=0 T=76) lib.tb_shifter.test_nop (0.2 seconds)

==== Summary ========================================================================
pass lib.tb_alu.test_add_without_carry                            (0.7 seconds)
pass lib.tb_alu.test_add_with_carry                               (0.2 seconds)
pass lib.tb_alu.test_add_without_carry_then_overflow              (0.2 seconds)
pass lib.tb_alu.test_add_with_carry_then_overflow                 (0.2 seconds)
pass lib.tb_alu.test_sub_without_carry                            (0.2 seconds)
pass lib.tb_alu.test_sub_with_carry                               (0.2 seconds)
pass lib.tb_alu.test_sub_without_carry_then_underflow             (0.2 seconds)
pass lib.tb_alu.test_sub_with_carry_then_underflow                (0.2 seconds)
pass lib.tb_alu.test_and                                          (0.2 seconds)
pass lib.tb_alu.test_or                                           (0.2 seconds)
pass lib.tb_alu.test_xor                                          (0.2 seconds)
pass lib.tb_alu.test_nop                                          (0.2 seconds)
pass lib.tb_control.test_lbus                                     (0.4 seconds)
pass lib.tb_control.test_rbus                                     (0.4 seconds)
pass lib.tb_control.test_al                                       (0.4 seconds)
pass lib.tb_control.test_sh                                       (0.4 seconds)
pass lib.tb_control.test_sbus_to_gpr                              (0.4 seconds)
pass lib.tb_control.test_sbus_to_pc                               (0.4 seconds)
pass lib.tb_control.test_mm_rm                                    (0.4 seconds)
pass lib.tb_control.test_mm_wm                                    (0.4 seconds)
pass lib.tb_control.test_sq                                       (0.4 seconds)
pass lib.tb_control.test_ex_fls                                   (0.4 seconds)
pass lib.tb_control.test_ex_asc                                   (0.4 seconds)
pass lib.tb_control.test_ex_as1                                   (0.4 seconds)
pass lib.tb_control.test_ex_lir                                   (0.4 seconds)
pass lib.tb_control.test_ex_lio                                   (0.4 seconds)
pass lib.tb_control.test_ex_eio                                   (0.4 seconds)
pass lib.tb_control.test_ex_ina                                   (0.4 seconds)
pass lib.tb_control.test_ex_inb                                   (0.4 seconds)
pass lib.tb_control.test_ex_dcb                                   (0.4 seconds)
pass lib.tb_control.test_ex_hlt                                   (0.4 seconds)
pass lib.tb_control.test_ex_ov                                    (0.4 seconds)
pass lib.tb_datapath.test_mar                                     (0.2 seconds)
pass lib.tb_datapath.test_ir                                      (0.2 seconds)
pass lib.tb_datapath.test_flag_zer                                (0.2 seconds)
pass lib.tb_datapath.test_flag_neg                                (0.2 seconds)
pass lib.tb_datapath.test_flag_cry                                (0.2 seconds)
pass lib.tb_datapath.test_flag_ov                                 (0.2 seconds)
pass lib.tb_datapath.test_gpr0                                    (0.2 seconds)
pass lib.tb_datapath.test_gpr1                                    (0.2 seconds)
pass lib.tb_datapath.test_gpr2                                    (0.2 seconds)
pass lib.tb_datapath.test_gpr3                                    (0.2 seconds)
pass lib.tb_datapath.test_gpr4                                    (0.3 seconds)
pass lib.tb_datapath.test_gpr5                                    (0.2 seconds)
pass lib.tb_datapath.test_gpr6                                    (0.2 seconds)
pass lib.tb_datapath.test_gpr7                                    (0.2 seconds)
pass lib.tb_datapath.test_ra                                      (0.2 seconds)
pass lib.tb_datapath.test_rap                                     (0.2 seconds)
pass lib.tb_datapath.test_rb                                      (0.2 seconds)
pass lib.tb_datapath.test_rbp                                     (0.2 seconds)
pass lib.tb_datapath.test_io                                      (0.2 seconds)
pass lib.tb_datapath.test_add                                     (0.2 seconds)
pass lib.tb_datapath.test_sub                                     (0.2 seconds)
pass lib.tb_datapath.test_and                                     (0.2 seconds)
pass lib.tb_datapath.test_or                                      (0.2 seconds)
pass lib.tb_datapath.test_xor                                     (0.2 seconds)
pass lib.tb_datapath.test_sll                                     (0.2 seconds)
pass lib.tb_datapath.test_srl                                     (0.2 seconds)
pass lib.tb_datapath.test_sla                                     (0.2 seconds)
pass lib.tb_datapath.test_sra                                     (0.2 seconds)
pass lib.tb_datapath.test_snx                                     (0.2 seconds)
pass lib.tb_datapath.test_swap                                    (0.2 seconds)
pass lib.tb_mux.test_select_first                                 (0.2 seconds)
pass lib.tb_mux.test_select_second                                (0.2 seconds)
pass lib.tb_shifter.test_shift_left_logically_without_carry       (0.2 seconds)
pass lib.tb_shifter.test_shift_left_logically_with_carry          (0.2 seconds)
pass lib.tb_shifter.test_shift_right_logically_without_carry      (0.2 seconds)
pass lib.tb_shifter.test_shift_right_logically_with_carry         (0.2 seconds)
pass lib.tb_shifter.test_shift_left_arithmetically_without_carry  (0.2 seconds)
pass lib.tb_shifter.test_shift_left_arithmetically_with_carry     (0.2 seconds)
pass lib.tb_shifter.test_shift_right_arithmetically_without_carry (0.2 seconds)
pass lib.tb_shifter.test_shift_right_arithmetically_with_carry    (0.2 seconds)
pass lib.tb_shifter.test_extension_with_unsigned                  (0.2 seconds)
pass lib.tb_shifter.test_extension_with_signed                    (0.2 seconds)
pass lib.tb_shifter.test_swap                                     (0.2 seconds)
pass lib.tb_shifter.test_nop                                      (0.2 seconds)
=====================================================================================
pass 76 of 76
=====================================================================================
Total time was 19.3 seconds
Elapsed time was 19.3 seconds
=====================================================================================
All passed!
```

## Reference

- 馬場敬信：マイクロプログラミング，昭晃堂（1985）

## Links

- simulator: [m1sim](https://github.com/kaien3/micro1)
- machine assembler: [rm1asm](https://github.com/Kenta11/rm1asm)
- micro assembler: [rm1masm](https://github.com/Kenta11/rm1masm)

## License

It is licensed under MIT license. See [LICENSE](LICENSE) for details.
