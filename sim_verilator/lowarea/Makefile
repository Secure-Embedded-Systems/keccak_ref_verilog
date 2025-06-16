all: keccak.vcd

obj_dir/keccak_sim:
	verilator --binary --trace system_mem.v --top-module tbkeccak ../../syn_ver/lowarea/keccak_copro.v tbkeccak.v -o keccak_sim

keccak.vcd: obj_dir/keccak_sim
	./obj_dir/keccak_sim

clean:
	rm -rf keccak.vcd obj_dir *~

