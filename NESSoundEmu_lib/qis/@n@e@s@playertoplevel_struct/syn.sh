#!/bin/sh
cd "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/qis/@n@e@s@playertoplevel_struct"
"/ext/eda/quartus/21_1_1/quartus/bin/quartus_sh" -t invoker.tcl
"/ext/eda/quartus/21_1_1/quartus/bin/quartus_map" NESPlayertoplevel -f map.args "--family=cyclone v" --part=5cgxfc5c6f27c7
