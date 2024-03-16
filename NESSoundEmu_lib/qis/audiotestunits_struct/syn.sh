#!/bin/sh
cd "/u/home/clab/redacted/eds/norbert/HDS/audiotest/audiotest_lib/qis/audiotestunits_struct"
"/ext/eda/quartus/21_1_1/quartus/bin/quartus_sh" -t invoker.tcl
"/ext/eda/quartus/21_1_1/quartus/bin/quartus_map" audiotestunits -f map.args "--family=cyclone v" --part=5cgxfc5c6f27c7
