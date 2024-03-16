package require ::quartus::project
set need_to_close_project 0
set make_assignments 1
# Check that the right project is open
if {[is_project_open]} {
   if {[string compare $quartus(project) "audiotestmain"]} {
      puts "Project audiotestmain is not open"
      set make_assignments 0
   }
} else {
   # Only open if not already open
   if {[project_exists audiotestmain]} {
      project_open -revision audiotestmain audiotestmain
   } else {
      project_new -revision audiotestmain audiotestmain
   }
   set need_to_close_project 1
}

# Make assignments
if {$make_assignments} {
   set_global_assignment -name COMPILER_SETTINGS audiotestmain
   set_global_assignment -name SIMULATOR_SETTINGS audiotestmain
   set_global_assignment -name SOFTWARE_SETTINGS audiotestmain
   set_global_assignment -name FMAX_REQUIREMENT 50MHz
   set_global_assignment -name FAMILY "cyclone v"
   set_global_assignment -name TOP_LEVEL_ENTITY audiotestmain
   set_global_assignment -name DEVICE 5cgxfc5c6f27c7
   set_global_assignment -name USE_COMPILER_SETTINGS audiotestmain
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/norbert/HDS/audiotest/audiotest_lib/hdl/audiotestmain_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/norbert/HDS/audiotest/audiotest_lib/hdl/i2c_master.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/norbert/HDS/audiotest/audiotest_lib/hdl/i2s_transceiver_logic.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/norbert/HDS/audiotest/audiotest_lib/hdl/ssm2603regwriter_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/norbert/HDS/audiotest/audiotest_lib/hdl/SSM2603regwriter_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/norbert/HDS/audiotest/audiotest_lib/hdl/testsoundctrl_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/norbert/HDS/audiotest/audiotest_lib/hdl/testsoundctrl1_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/norbert/HDS/audiotest/audiotest_lib/hdl/taktteiler_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/norbert/HDS/audiotest/audiotest_lib/hdl/taktteiler_behav.vhd" 
	set_global_assignment -name VERILOG_FILE "/u/home/clab/redacted/eds/norbert/HDS/audiotest/audiotest_lib/hdl/pll5012new/pll5012new_0002.v"
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/norbert/HDS/audiotest/audiotest_lib/hdl/pll5012new.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/norbert/HDS/audiotest/audiotest_lib/hdl/codecsetup_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/norbert/HDS/audiotest/audiotest_lib/hdl/codecsetup1_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/norbert/HDS/audiotest/audiotest_lib/hdl/audiotestmain_struct.vhd" 


   # Commit assignments
   export_assignments


   # Close project
   if {$need_to_close_project} {
      project_close
   }
}

