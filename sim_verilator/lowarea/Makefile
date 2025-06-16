# Copyright (c) 2025 Patrick Schaumont
# Licensed under the Apache License, Version 2.0, see LICENSE for details.

all: keccak.vcd

obj_dir/keccak_sim:
	verilator --binary --trace system_mem.v --top-module tbkeccak ../../syn_ver/lowarea/keccak_copro.v tbkeccak.v -o keccak_sim

keccak.vcd: obj_dir/keccak_sim
	./obj_dir/keccak_sim

clean:
	rm -rf keccak.vcd obj_dir *~

