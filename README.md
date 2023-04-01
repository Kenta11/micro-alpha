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

|  name  | Contents                                      |
|:------:|:----------------------------------------------|
| fpga   | Files to create a Xilinx Vivado project       |
| script | Utility scripts                               |
| src    | MICRO-alpha in SystemVerilog                  |
| tb     | Testbenches for MICRO-alpha components in src |

## Try on a FPGA board

### Environment

- OS: Linux
- Xilinx Vivado 2022.1
- GNU Make

### Usage

- Supported FPGA board
  - [Arty A7-100](https://digilent.com/reference/programmable-logic/arty-a7/start)
  - [Basys 3](https://digilent.com/reference/programmable-logic/basys-3/start) (**NOTE: Due to lack of resources, control and main memory are limited to 512 bytes and 1024 bytes respectively**)

- Write programs into the COE files

```
$ rm1masm MICROONE -o MICROONE.O
$ python script/obj2coe.py arty-a7-100 MICROONE.o fpga/arty-a7-100/control_program.coe
$ rm1asm PROGRAM -o PROGRAM.B
$ python script/obj2coe.py arty-a7-100 PROGRAM.B fpga/arty-a7-100/machine_program.coe
```

<details>
<summary>Run "make all"</summary>

```
$ make all
vivado -mode tcl -source fpga/arty-a7-100/create_project.tcl 

****** Vivado v2022.1 (64-bit)
  **** SW Build 3526262 on Mon Apr 18 15:47:01 MDT 2022
  **** IP Build 3524634 on Mon Apr 18 20:55:01 MDT 2022
    ** Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.

source fpga/arty-a7-100/create_project.tcl
# set project_directory "vivado/arty-a7-100"
# set project_name      "arty-a7-100"
# create_project ${project_name} ${project_directory} -part xc7a100tcsg324-1
# set project_root [get_property directory [current_project]]
# if {[string equal [get_filesets -quiet sources_1] ""]} {
#   create_fileset -srcset sources_1
# }
# add_files [list \
#   [file normalize "${project_root}/../../src/package_alu.sv"]\
#   [file normalize "${project_root}/../../src/package_machine_data.sv"]\
#   [file normalize "${project_root}/../../src/alu.sv"]\
#   [file normalize "${project_root}/../../src/package_gpr_destination_selector.sv"]\
#   [file normalize "${project_root}/../../src/package_ir_source_selector.sv"]\
#   [file normalize "${project_root}/../../src/package_lbus_source_selector.sv"]\
#   [file normalize "${project_root}/../../src/package_rbus_source_selector.sv"]\
#   [file normalize "${project_root}/../../src/package_shifter.sv"]\
#   [file normalize "${project_root}/../../src/control_interface.sv"]\
#   [file normalize "${project_root}/../../src/package_control_data.sv"]\
#   [file normalize "${project_root}/../../src/controler.sv"]\
#   [file normalize "${project_root}/../../src/datapath.sv"]\
#   [file normalize "${project_root}/../../src/micro_alpha.sv"]\
#   [file normalize "${project_root}/../../src/mux.sv"]\
#   [file normalize "${project_root}/../../src/shifter.sv"]\
#   [file normalize "${project_root}/../../src/uart_receiver.sv"]\
#   [file normalize "${project_root}/../../src/uart_receiver_controler.sv"]\
#   [file normalize "${project_root}/../../src/uart_transmitter.sv"]\
#   [file normalize "${project_root}/../../src/uart_transmitter_controler.sv"]\
#   [file normalize "${project_root}/../../src/top.sv"]\
# ]
# create_ip -name blk_mem_gen -vendor xilinx.com -library ip -version 8.4 -module_name main_memory
INFO: [IP_Flow 19-234] Refreshing IP repositories
INFO: [IP_Flow 19-1704] No user IP repositories specified
INFO: [IP_Flow 19-2313] Loaded Vivado IP repository '/opt/Xilinx/2022.1/Vivado/2022.1/data/ip'.
# set_property -dict [list CONFIG.Component_Name {main_memory} CONFIG.Write_Depth_A {65536} CONFIG.Enable_A {Always_Enabled} CONFIG.Load_Init_File {true} CONFIG.Coe_File [file normalize "${project_root}/../../fpga/arty-a7-100/machine_program.coe"]] [get_ips main_memory]
WARNING: [Vivado 12-3523] Attempt to change 'Component_Name' from 'main_memory' to 'main_memory' is not allowed and is ignored.
INFO: [IP_Flow 19-3484] Absolute path of file '/home/kenta/Git/Kenta11/micro-alpha/fpga/arty-a7-100/machine_program.coe' provided. It will be converted relative to IP Instance files '../../../../../../fpga/arty-a7-100/machine_program.coe'
# create_ip -name blk_mem_gen -vendor xilinx.com -library ip -version 8.4 -module_name control_memory
# set_property -dict [list CONFIG.Component_Name {control_memory} CONFIG.Memory_Type {Single_Port_ROM} CONFIG.Write_Width_A {40} CONFIG.Write_Depth_A {4096} CONFIG.Read_Width_A {40} CONFIG.Enable_A {Always_Enabled} CONFIG.Write_Width_B {40} CONFIG.Read_Width_B {40} CONFIG.Load_Init_File {true} CONFIG.Coe_File [file normalize "${project_root}/../../fpga/arty-a7-100/control_program.coe"] CONFIG.Port_A_Write_Rate {0}] [get_ips control_memory]
WARNING: [Vivado 12-3523] Attempt to change 'Component_Name' from 'control_memory' to 'control_memory' is not allowed and is ignored.
INFO: [IP_Flow 19-3484] Absolute path of file '/home/kenta/Git/Kenta11/micro-alpha/fpga/arty-a7-100/control_program.coe' provided. It will be converted relative to IP Instance files '../../../../../../fpga/arty-a7-100/control_program.coe'
# create_ip -name fifo_generator -vendor xilinx.com -library ip -version 13.2 -module_name fifo_generator_0
# set_property -dict [list CONFIG.Input_Data_Width {8} CONFIG.Input_Depth {256} CONFIG.Output_Data_Width {8} CONFIG.Output_Depth {256} CONFIG.Data_Count_Width {8} CONFIG.Write_Data_Count_Width {8} CONFIG.Read_Data_Count_Width {8} CONFIG.Full_Threshold_Assert_Value {254} CONFIG.Full_Threshold_Negate_Value {253}] [get_ips fifo_generator_0]
# if {[string equal [get_filesets -quiet constrs_1] ""]} {
#   create_fileset -constrset constrs_1
# }
# add_files -fileset constrs_1 "${project_root}/../../fpga/arty-a7-100/constr.xdc"
# if {[string equal [get_filesets -quiet sim_1] ""]} {
#     create_fileset -simset sim_1
# }
# add_files -fileset sim_1 "${project_root}/../../tb/testbench.sv"
# if {[string equal [get_runs -quiet synth_1] ""]} {
#     create_run -name synth_1 -part xc7a100tcsg324-1 -flow {Vivado Synthesis 2022} -strategy "Flow_PerfOptimized_high" -report_strategy {No Reports} -constrset constrs_1
# } else {
#   set_property strategy "Flow_PerfOptimized_high" [get_runs synth_1]
#   set_property flow "Vivado Synthesis 2022" [get_runs synth_1]
# }
# current_run -synthesis [get_runs synth_1]
# if {[string equal [get_runs -quiet impl_1] ""]} {
#     create_run -name impl_1 -part xc7a100tcsg324-1 -flow {Vivado Implementation 2022} -strategy "Vivado Implementation Defaults" -report_strategy {No Reports} -constrset constrs_1 -parent_run synth_1
# } else {
#   set_property strategy "Vivado Implementation Defaults" [get_runs impl_1]
#   set_property flow "Vivado Implementation 2022" [get_runs impl_1]
# }
# current_run -implementation [get_runs impl_1]
# quit
INFO: [Common 17-206] Exiting Vivado at Sat Apr  1 17:02:44 2023...
$ ls vivado/arty-a7-100
arty-a7-100.cache  arty-a7-100.gen  arty-a7-100.hw  arty-a7-100.ip_user_files  arty-a7-100.srcs  arty-a7-100.xpr
```
</details>

## Unit tests

### Environment

- OS: Linux
- Simulator: ModelSim
- Testing framework: [VUnit](https://github.com/VUnit/vunit)
- GNU Make

### Usage

<details>
<summary>Run "make test"</summary>

```
$ make test
python script/unittest.py
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
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_alu.test_add_without_carry_57a1e4a5b731c43abe88abd39eb7735a108137ce/output.txt
pass (P=1 S=0 F=0 T=76) lib.tb_alu.test_add_without_carry (0.7 seconds)

Starting lib.tb_alu.test_add_with_carry
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_alu.test_add_with_carry_e702c2c28c4d86b55f14154ae9579e506c0f0ef6/output.txt
pass (P=2 S=0 F=0 T=76) lib.tb_alu.test_add_with_carry (0.2 seconds)

Starting lib.tb_alu.test_add_without_carry_then_overflow
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_alu.test_add_without_carry_then_overflow_77228538b7b704ff883be0f0054c9e2d9f4293ff/output.txt
pass (P=3 S=0 F=0 T=76) lib.tb_alu.test_add_without_carry_then_overflow (0.2 seconds)

Starting lib.tb_alu.test_add_with_carry_then_overflow
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_alu.test_add_with_carry_then_overflow_03253ae9d6bde400f1960042eb3b1829984e0e9b/output.txt
pass (P=4 S=0 F=0 T=76) lib.tb_alu.test_add_with_carry_then_overflow (0.2 seconds)

Starting lib.tb_alu.test_sub_without_carry
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_alu.test_sub_without_carry_ae29afd923c7c468cc1821e4a2bedf6a030fc5fe/output.txt
pass (P=5 S=0 F=0 T=76) lib.tb_alu.test_sub_without_carry (0.2 seconds)

Starting lib.tb_alu.test_sub_with_carry
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_alu.test_sub_with_carry_5601249dce843255d1a37549d8e18d3c54bb6fa7/output.txt
pass (P=6 S=0 F=0 T=76) lib.tb_alu.test_sub_with_carry (0.2 seconds)

Starting lib.tb_alu.test_sub_without_carry_then_underflow
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_alu.test_sub_without_carry_then_underflow_9d69dcfd4fe05cd7339201acdf866c7664935eab/output.txt
pass (P=7 S=0 F=0 T=76) lib.tb_alu.test_sub_without_carry_then_underflow (0.2 seconds)

Starting lib.tb_alu.test_sub_with_carry_then_underflow
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_alu.test_sub_with_carry_then_underflow_a507c7eea8bf35fb473ff8d583f32314413bbe5d/output.txt
pass (P=8 S=0 F=0 T=76) lib.tb_alu.test_sub_with_carry_then_underflow (0.2 seconds)

Starting lib.tb_alu.test_and
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_alu.test_and_45007e98a2424f31df3d3bc6ce7da5318f1e1f20/output.txt
pass (P=9 S=0 F=0 T=76) lib.tb_alu.test_and (0.2 seconds)

Starting lib.tb_alu.test_or
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_alu.test_or_710b87ffbc3b904a1d12562c2d27372f086057fa/output.txt
pass (P=10 S=0 F=0 T=76) lib.tb_alu.test_or (0.2 seconds)

Starting lib.tb_alu.test_xor
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_alu.test_xor_0c2d58cd7c61e3de893fbb7b21180f1ae7968499/output.txt
pass (P=11 S=0 F=0 T=76) lib.tb_alu.test_xor (0.2 seconds)

Starting lib.tb_alu.test_nop
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_alu.test_nop_9ccc3381b915ac5f998d65b411ae69b68f157dca/output.txt
pass (P=12 S=0 F=0 T=76) lib.tb_alu.test_nop (0.2 seconds)

Starting lib.tb_control.test_lbus
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_control.test_lbus_250235baf94d844c34bc1549e8a2c6a2b015b25e/output.txt
pass (P=13 S=0 F=0 T=76) lib.tb_control.test_lbus (0.4 seconds)

Starting lib.tb_control.test_rbus
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_control.test_rbus_166c4153f025f9fff090390b008b6130842f0449/output.txt
pass (P=14 S=0 F=0 T=76) lib.tb_control.test_rbus (0.4 seconds)

Starting lib.tb_control.test_al
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_control.test_al_c9e3fb57c50020f8ff5ea8360cbc1d1117dc6b13/output.txt
pass (P=15 S=0 F=0 T=76) lib.tb_control.test_al (0.4 seconds)

Starting lib.tb_control.test_sh
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_control.test_sh_cb49166e929e378991cc55c016b18e5f9dc64434/output.txt
pass (P=16 S=0 F=0 T=76) lib.tb_control.test_sh (0.4 seconds)

Starting lib.tb_control.test_sbus_to_gpr
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_control.test_sbus_to_gpr_4a820f165afc54fce006e69597587074a065a29d/output.txt
pass (P=17 S=0 F=0 T=76) lib.tb_control.test_sbus_to_gpr (0.4 seconds)

Starting lib.tb_control.test_sbus_to_pc
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_control.test_sbus_to_pc_5c5069259a14237951078f037f700944442ad658/output.txt
pass (P=18 S=0 F=0 T=76) lib.tb_control.test_sbus_to_pc (0.4 seconds)

Starting lib.tb_control.test_mm_rm
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_control.test_mm_rm_6aeeb90228b7e0bb00aba0e2f00eb253d178cb9b/output.txt
pass (P=19 S=0 F=0 T=76) lib.tb_control.test_mm_rm (0.4 seconds)

Starting lib.tb_control.test_mm_wm
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_control.test_mm_wm_687ce9f124dffc13229d517a8be886bd58363eac/output.txt
pass (P=20 S=0 F=0 T=76) lib.tb_control.test_mm_wm (0.4 seconds)

Starting lib.tb_control.test_sq
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_control.test_sq_921c45846e3c1c02bd8a536ca0379f86d5593676/output.txt
pass (P=21 S=0 F=0 T=76) lib.tb_control.test_sq (0.4 seconds)

Starting lib.tb_control.test_ex_fls
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_control.test_ex_fls_903b0bccee1baa6320f43141ba306438be43134f/output.txt
pass (P=22 S=0 F=0 T=76) lib.tb_control.test_ex_fls (0.4 seconds)

Starting lib.tb_control.test_ex_asc
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_control.test_ex_asc_9106a651bac7e20fc45fbcc3509565d19dfefec4/output.txt
pass (P=23 S=0 F=0 T=76) lib.tb_control.test_ex_asc (0.4 seconds)

Starting lib.tb_control.test_ex_as1
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_control.test_ex_as1_8c141cf4e917a994a21cd8216be16a1cf893dea3/output.txt
pass (P=24 S=0 F=0 T=76) lib.tb_control.test_ex_as1 (0.4 seconds)

Starting lib.tb_control.test_ex_lir
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_control.test_ex_lir_22540925bd253786f813e363e4aedfd2aeedaab2/output.txt
pass (P=25 S=0 F=0 T=76) lib.tb_control.test_ex_lir (0.4 seconds)

Starting lib.tb_control.test_ex_lio
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_control.test_ex_lio_08a0ee1098f1f7bf3a51e41ace42122b5961e051/output.txt
pass (P=26 S=0 F=0 T=76) lib.tb_control.test_ex_lio (0.4 seconds)

Starting lib.tb_control.test_ex_eio
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_control.test_ex_eio_ad70a2cc8ba8bbaaf7ede53568dadcfd32271d2c/output.txt
pass (P=27 S=0 F=0 T=76) lib.tb_control.test_ex_eio (0.4 seconds)

Starting lib.tb_control.test_ex_ina
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_control.test_ex_ina_86ff6502a9b4536d7f8e82561313d15ee4c30436/output.txt
pass (P=28 S=0 F=0 T=76) lib.tb_control.test_ex_ina (0.4 seconds)

Starting lib.tb_control.test_ex_inb
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_control.test_ex_inb_6ec213fc19f66fa920456278cebc139c001be207/output.txt
pass (P=29 S=0 F=0 T=76) lib.tb_control.test_ex_inb (0.4 seconds)

Starting lib.tb_control.test_ex_dcb
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_control.test_ex_dcb_e8ca253b4dae06109f37b72b65f9e0fbe0b79880/output.txt
pass (P=30 S=0 F=0 T=76) lib.tb_control.test_ex_dcb (0.4 seconds)

Starting lib.tb_control.test_ex_hlt
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_control.test_ex_hlt_110224d0de5ebb1281abb495f37999b2c820bd37/output.txt
pass (P=31 S=0 F=0 T=76) lib.tb_control.test_ex_hlt (0.4 seconds)

Starting lib.tb_control.test_ex_ov
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_control.test_ex_ov_9a19b86d96a0cea664c0634ac7e7005cad076a6e/output.txt
pass (P=32 S=0 F=0 T=76) lib.tb_control.test_ex_ov (0.4 seconds)

Starting lib.tb_datapath.test_mar
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_datapath.test_mar_5196b612077063ac22c654329005413a1db4eec2/output.txt
pass (P=33 S=0 F=0 T=76) lib.tb_datapath.test_mar (0.2 seconds)

Starting lib.tb_datapath.test_ir
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_datapath.test_ir_0b9fa6b5bb4c999b97beac0b3e29cbd771c646ab/output.txt
pass (P=34 S=0 F=0 T=76) lib.tb_datapath.test_ir (0.2 seconds)

Starting lib.tb_datapath.test_flag_zer
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_datapath.test_flag_zer_861be5b13371c21ec99aa173d7d49982f87ec499/output.txt
pass (P=35 S=0 F=0 T=76) lib.tb_datapath.test_flag_zer (0.2 seconds)

Starting lib.tb_datapath.test_flag_neg
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_datapath.test_flag_neg_2c23567c4b3c08ce2e1a6dfabc64e76b8a10d1ce/output.txt
pass (P=36 S=0 F=0 T=76) lib.tb_datapath.test_flag_neg (0.2 seconds)

Starting lib.tb_datapath.test_flag_cry
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_datapath.test_flag_cry_4b6720a9f92eb5b2360dbdffa94ab3075a563928/output.txt
pass (P=37 S=0 F=0 T=76) lib.tb_datapath.test_flag_cry (0.2 seconds)

Starting lib.tb_datapath.test_flag_ov
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_datapath.test_flag_ov_a88d3f915e941ec04e530760cbbd80fd9649c01c/output.txt
pass (P=38 S=0 F=0 T=76) lib.tb_datapath.test_flag_ov (0.2 seconds)

Starting lib.tb_datapath.test_gpr0
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_datapath.test_gpr0_dbe8b66baeea2c3c828d062370d5bbc91ed30184/output.txt
pass (P=39 S=0 F=0 T=76) lib.tb_datapath.test_gpr0 (0.2 seconds)

Starting lib.tb_datapath.test_gpr1
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_datapath.test_gpr1_22432e4461dd9e9276912c06a86b613f52bc32a8/output.txt
pass (P=40 S=0 F=0 T=76) lib.tb_datapath.test_gpr1 (0.2 seconds)

Starting lib.tb_datapath.test_gpr2
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_datapath.test_gpr2_8deca453cf956b3784ff8ce08cfff0f6b164d8dc/output.txt
pass (P=41 S=0 F=0 T=76) lib.tb_datapath.test_gpr2 (0.2 seconds)

Starting lib.tb_datapath.test_gpr3
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_datapath.test_gpr3_438ad86f3003f5fa98299016b61a4ff2e38129b7/output.txt
pass (P=42 S=0 F=0 T=76) lib.tb_datapath.test_gpr3 (0.2 seconds)

Starting lib.tb_datapath.test_gpr4
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_datapath.test_gpr4_5b7bf0a0e9bf2428dfde32c0f4861e8a57908e90/output.txt
pass (P=43 S=0 F=0 T=76) lib.tb_datapath.test_gpr4 (0.2 seconds)

Starting lib.tb_datapath.test_gpr5
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_datapath.test_gpr5_ef5d33c1d33da79d7a0411e03a053f341543d7fb/output.txt
pass (P=44 S=0 F=0 T=76) lib.tb_datapath.test_gpr5 (0.2 seconds)

Starting lib.tb_datapath.test_gpr6
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_datapath.test_gpr6_feed6f727bb2c2a3d33133c478164b654b9c2274/output.txt
pass (P=45 S=0 F=0 T=76) lib.tb_datapath.test_gpr6 (0.2 seconds)

Starting lib.tb_datapath.test_gpr7
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_datapath.test_gpr7_fab8208416bd5434fe546c074817cc19817da7e5/output.txt
pass (P=46 S=0 F=0 T=76) lib.tb_datapath.test_gpr7 (0.2 seconds)

Starting lib.tb_datapath.test_ra
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_datapath.test_ra_d1003cb8e6a3b16fff4ac21283ed3a6a946e0d5c/output.txt
pass (P=47 S=0 F=0 T=76) lib.tb_datapath.test_ra (0.2 seconds)

Starting lib.tb_datapath.test_rap
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_datapath.test_rap_760580d8414b013c92eb0457e28c87b3018fc595/output.txt
pass (P=48 S=0 F=0 T=76) lib.tb_datapath.test_rap (0.2 seconds)

Starting lib.tb_datapath.test_rb
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_datapath.test_rb_45b60754e051446a04b0c7da5ff759fa5e3f71d4/output.txt
pass (P=49 S=0 F=0 T=76) lib.tb_datapath.test_rb (0.2 seconds)

Starting lib.tb_datapath.test_rbp
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_datapath.test_rbp_37ac11d808cecff561b79afa144733db510cc4c9/output.txt
pass (P=50 S=0 F=0 T=76) lib.tb_datapath.test_rbp (0.2 seconds)

Starting lib.tb_datapath.test_io
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_datapath.test_io_4bf10b56043bf8e1d8caf4bc0ad67bffeeb8d3c3/output.txt
pass (P=51 S=0 F=0 T=76) lib.tb_datapath.test_io (0.2 seconds)

Starting lib.tb_datapath.test_add
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_datapath.test_add_1ccb8f18fd2f3ac5576cffcf06508e466714d685/output.txt
pass (P=52 S=0 F=0 T=76) lib.tb_datapath.test_add (0.2 seconds)

Starting lib.tb_datapath.test_sub
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_datapath.test_sub_7f24fe2c4ec1d55f2960f01fcbc03f2dff9fb0d2/output.txt
pass (P=53 S=0 F=0 T=76) lib.tb_datapath.test_sub (0.2 seconds)

Starting lib.tb_datapath.test_and
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_datapath.test_and_f0c14ed791aafd060c1598764f6c9f0ee100a12c/output.txt
pass (P=54 S=0 F=0 T=76) lib.tb_datapath.test_and (0.2 seconds)

Starting lib.tb_datapath.test_or
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_datapath.test_or_ad7a18fd8dcd394569a0f69f6aa88373fdb19179/output.txt
pass (P=55 S=0 F=0 T=76) lib.tb_datapath.test_or (0.2 seconds)

Starting lib.tb_datapath.test_xor
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_datapath.test_xor_e15b6eead899a513a0d2aae32eeee5d138095296/output.txt
pass (P=56 S=0 F=0 T=76) lib.tb_datapath.test_xor (0.2 seconds)

Starting lib.tb_datapath.test_sll
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_datapath.test_sll_22d46b0e3768e72756f60dae88cd36cfd701038b/output.txt
pass (P=57 S=0 F=0 T=76) lib.tb_datapath.test_sll (0.2 seconds)

Starting lib.tb_datapath.test_srl
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_datapath.test_srl_4ca61327ce7a2bced78b307a12cb6bb83824d060/output.txt
pass (P=58 S=0 F=0 T=76) lib.tb_datapath.test_srl (0.2 seconds)

Starting lib.tb_datapath.test_sla
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_datapath.test_sla_e3f4a964e27e98a10801b02874bfd6080266e24d/output.txt
pass (P=59 S=0 F=0 T=76) lib.tb_datapath.test_sla (0.2 seconds)

Starting lib.tb_datapath.test_sra
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_datapath.test_sra_43b09acbe9467edbd022aed2ace532139e79fa30/output.txt
pass (P=60 S=0 F=0 T=76) lib.tb_datapath.test_sra (0.2 seconds)

Starting lib.tb_datapath.test_snx
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_datapath.test_snx_9d1087f01b2c07ae1847a6d5c7ae375953f7906b/output.txt
pass (P=61 S=0 F=0 T=76) lib.tb_datapath.test_snx (0.2 seconds)

Starting lib.tb_datapath.test_swap
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_datapath.test_swap_13f91f77474912686966c8c1f6864e2ce4d4b1dd/output.txt
pass (P=62 S=0 F=0 T=76) lib.tb_datapath.test_swap (0.2 seconds)

Starting lib.tb_mux.test_select_first
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_mux.test_select_first_84f283b185829e785562bf751b5a08dee394960c/output.txt
pass (P=63 S=0 F=0 T=76) lib.tb_mux.test_select_first (0.2 seconds)

Starting lib.tb_mux.test_select_second
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_mux.test_select_second_2a9a326f1fd2c8db84461aea9cb54799a4ce6689/output.txt
pass (P=64 S=0 F=0 T=76) lib.tb_mux.test_select_second (0.2 seconds)

Starting lib.tb_shifter.test_shift_left_logically_without_carry
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_shifter.test_shift_left_logically_without_carry_78d79400865ea808ebdb697f6029ad4809ba809a/output.txt
pass (P=65 S=0 F=0 T=76) lib.tb_shifter.test_shift_left_logically_without_carry (0.2 seconds)

Starting lib.tb_shifter.test_shift_left_logically_with_carry
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_shifter.test_shift_left_logically_with_carry_72c0f9c82c9ff76ac730dac83f439f73413ecbed/output.txt
pass (P=66 S=0 F=0 T=76) lib.tb_shifter.test_shift_left_logically_with_carry (0.2 seconds)

Starting lib.tb_shifter.test_shift_right_logically_without_carry
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_shifter.test_shift_right_logically_without_carry_00d2d2ec6fb2fef09dbad860d339966d0f4a2b32/output.txt
pass (P=67 S=0 F=0 T=76) lib.tb_shifter.test_shift_right_logically_without_carry (0.2 seconds)

Starting lib.tb_shifter.test_shift_right_logically_with_carry
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_shifter.test_shift_right_logically_with_carry_ac9736b5ba481a340e8ad4415a531b0810ac96fe/output.txt
pass (P=68 S=0 F=0 T=76) lib.tb_shifter.test_shift_right_logically_with_carry (0.2 seconds)

Starting lib.tb_shifter.test_shift_left_arithmetically_without_carry
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_shifter.test_shift_left_arithmetically_without_carry_3da212baf4ec473d0a94227c6a8dc7d1cc890be4/output.txt
pass (P=69 S=0 F=0 T=76) lib.tb_shifter.test_shift_left_arithmetically_without_carry (0.2 seconds)

Starting lib.tb_shifter.test_shift_left_arithmetically_with_carry
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_shifter.test_shift_left_arithmetically_with_carry_ac7685dc7d3a4cae535e668fb0fe5033b6794ffa/output.txt
pass (P=70 S=0 F=0 T=76) lib.tb_shifter.test_shift_left_arithmetically_with_carry (0.2 seconds)

Starting lib.tb_shifter.test_shift_right_arithmetically_without_carry
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_shifter.test_shift_right_arithmetically_without_carry_6147638a1a1a09167ce41efb2292a20ce4b7ad4c/output.txt
pass (P=71 S=0 F=0 T=76) lib.tb_shifter.test_shift_right_arithmetically_without_carry (0.2 seconds)

Starting lib.tb_shifter.test_shift_right_arithmetically_with_carry
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_shifter.test_shift_right_arithmetically_with_carry_9d3d30c0f4bfae6b31b0c99fe036365b59cf41f1/output.txt
pass (P=72 S=0 F=0 T=76) lib.tb_shifter.test_shift_right_arithmetically_with_carry (0.2 seconds)

Starting lib.tb_shifter.test_extension_with_unsigned
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_shifter.test_extension_with_unsigned_a5a31f6391eb05e746c1b201ad67f26b57903594/output.txt
pass (P=73 S=0 F=0 T=76) lib.tb_shifter.test_extension_with_unsigned (0.2 seconds)

Starting lib.tb_shifter.test_extension_with_signed
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_shifter.test_extension_with_signed_d53b5f09f2781d07d457f8a23a749898bb65b4ba/output.txt
pass (P=74 S=0 F=0 T=76) lib.tb_shifter.test_extension_with_signed (0.2 seconds)

Starting lib.tb_shifter.test_swap
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_shifter.test_swap_763582881f62431616db9fb31f08842ae3de38f2/output.txt
pass (P=75 S=0 F=0 T=76) lib.tb_shifter.test_swap (0.2 seconds)

Starting lib.tb_shifter.test_nop
Output file: /home/kenta/Git/Kenta11/micro-alpha/vunit_out/test_output/lib.tb_shifter.test_nop_000928b615edea74de0f9847e69063394879774f/output.txt
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
pass lib.tb_datapath.test_gpr4                                    (0.2 seconds)
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
Total time was 19.1 seconds
Elapsed time was 19.1 seconds
=====================================================================================
All passed!
```
</details>

## Reference

- 馬場敬信：マイクロプログラミング，昭晃堂（1985）

## Links

- simulator: [m1sim](https://github.com/kaien3/micro1)
- machine assembler: [rm1asm](https://github.com/Kenta11/rm1asm)
- micro assembler: [rm1masm](https://github.com/Kenta11/rm1masm)
- my blog: [Kenta Arai Webpage](https://kenta11.github.io/posts/2023-03-18-micro-alpha/)

## License

It is licensed under MIT license. See [LICENSE](LICENSE) for details.
