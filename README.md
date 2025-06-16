This is a translation of the keccak reference implementation by keccak.team (Guido Bertoni, Joan Daemen, Seth Hoffert, Michaël Peeters, Gilles Van Assche and Ronny Van Keer) into Verilog using GHDL and yosys. The original VDHL reference implementations are available at the keccak standard website: https://keccak.team/files/KeccakVHDL-3.1.zip

To set up GHDL, yosys, and Verilator, I recommend the docker image developed by JKU: https://github.com/iic-jku/IIC-OSIC-TOOLS

# Usage

1. Use yosys to translate the VHDL to Verilog generic technology

```
cd syn_ver
make
```

2. Run the simulation in Verilator and verify the test vectors

```
cd sim_verilator
make
```

3. To open the VCD into gtkwave, first cleanup the colons from variable names

```
cd sim_verilator/low_area
. gtkfriendly.sh
```

Copyright (c) 2025 Patrick Schaumont  
Licensed under the Apache License, Version 2.0, see LICENSE for details.

