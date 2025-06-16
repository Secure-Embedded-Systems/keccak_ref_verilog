#!/bin/bash

# Copyright (c) 2025 Patrick Schaumont
# Licensed under the Apache License, Version 2.0, see LICENSE for details.

echo "Substituting variables names of keccak.vcd into gtkwave-friendly versions in output.vcd"
awk '{if ($1=="$var") {print $5}}' keccak.vcd >tmp_vars
sort tmp_vars | uniq >tmp_vars2
grep ':' tmp_vars2 >tmp_vars3
cat tmp_vars3 | tr [:punct:] _ > tmp_vars4
paste tmp_vars3 tmp_vars4 >tmp_vars5
awk '{printf("s/%s/%s/g\n",$1,$2)}' tmp_vars5 >tmp_vars6
sed -f tmp_vars6 keccak.vcd >output.vcd
rm -f tmp_vars tmp_vars2 tmp_vars3 tmp_vars4 tmp_vars5 tmp_vars6
