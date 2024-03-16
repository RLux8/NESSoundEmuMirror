onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /audiotest_tb/U_0/U_2/clk
add wave -noupdate /audiotest_tb/U_0/U_2/busy
add wave -noupdate /audiotest_tb/U_0/U_2/ena
add wave -noupdate /audiotest_tb/U_0/U_2/line__12/state
add wave -noupdate /audiotest_tb/U_0/U_2/line__12/regaddr
add wave -noupdate /audiotest_tb/U_0/U_2/line__12/data
add wave -noupdate /audiotest_tb/U_0/U_2/busy
add wave -noupdate /audiotest_tb/U_0/SSM2603_scl
add wave -noupdate /audiotest_tb/U_0/SSM2603_sda
add wave -noupdate /audiotest_tb/U_0/U_0/ena
add wave -noupdate /audiotest_tb/U_0/U_0/busy
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2594 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 262
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {636 ns} {7782 ns}
