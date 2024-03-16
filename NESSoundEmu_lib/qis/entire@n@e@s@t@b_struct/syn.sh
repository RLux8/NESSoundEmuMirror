#!/bin/sh
cd "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/qis/entire@n@e@s@t@b_struct"
"/ext/eda/quartus/21_1_1/quartus/bin/quartus_sh" -t invoker.tcl
"/ext/eda/quartus/21_1_1/quartus/bin/quartus_map" entireNESTB -f map.args "--family=cyclone v" --part=5cgxfc5c6f27c7
