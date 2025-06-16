# Copyright (c) 2025 Patrick Schaumont
# Licensed under the Apache License, Version 2.0, see LICENSE for details.

all: keccak.vcd

obj_dir/keccak_sim:
	verilator --binary --trace ../../syn_ver/highspeed/keccak_generic.v tbkeccak.v -Wno-IMPLICIT -Wno-TIMESCALEMOD -o keccak_sim

keccak.vcd: obj_dir/keccak_sim
	./obj_dir/keccak_sim

clean:
	rm -rf keccak.vcd obj_dir *~

