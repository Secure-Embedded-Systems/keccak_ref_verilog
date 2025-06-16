# Copyright (c) 2025 Patrick Schaumont
# Licensed under the Apache License, Version 2.0, see LICENSE for details.

keccak_generic.v:
	ghdl -a -fsynopsys ../../3.1/high_speed_core/keccak_globals.vhd
	ghdl -a -fsynopsys ../../3.1/high_speed_core/keccak_buffer.vhd
	ghdl -a -fsynopsys ../../3.1/high_speed_core/keccak_round_constants_gen.vhd
	ghdl -a -fsynopsys ../../3.1/high_speed_core/keccak_round.vhd
	ghdl -a -fsynopsys ../../3.1/high_speed_core/keccak.vhd
	yosys -p 'ghdl -fsynopsys keccak; synth; write_verilog keccak_generic.v'

clean:
	rm -f *.o work-obj93.cf *~ keccak_generic.v

