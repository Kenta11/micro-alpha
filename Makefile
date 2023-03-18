SRCS = alu.sv \
       control_interface.sv \
       controler.sv \
	   datapath.sv \
	   mux.sv \
	   package_alu.sv \
	   package_control_data.sv \
	   package_gpr_destination_selector.sv \
	   package_ir_source_selector.sv \
	   package_lbus_source_selector.sv \
	   package_machine_data.sv \
	   package_rbus_source_selector.sv \
	   package_shifter.sv \
	   shifter.sv
TESTS = tb_alu.sv \
        tb_controler.sv \
		tb_datapath.sv \
		tb_mux.sv \
		tb_shifter.sv

.PHONY: all test clean

all:

test: vunit_out

vunit_out: $(addprefix src/, $(SRCS)) $(addprefix tb/, $(TESTS))
	python run.py

clean:
	rm -rf vunit_out
