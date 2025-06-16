keccak_copro.v:
	ghdl -a -fsynopsys ../../3.1/low_area_coproc/keccak_globals.vhd
	ghdl -a -fsynopsys ../../3.1/low_area_coproc/fsm.vhd
	ghdl -a -fsynopsys ../../3.1/low_area_coproc/pe.vhd
	ghdl -a -fsynopsys ../../3.1/low_area_coproc/system_mem.vhd
	ghdl -a -fsynopsys ../../3.1/low_area_coproc/keccak_copro.vhd
	yosys -p 'ghdl -fsynopsys keccak_copro; synth; write_verilog keccak_copro.v'

clean:
	rm -f *.o *~ work* keccak_copro.v

