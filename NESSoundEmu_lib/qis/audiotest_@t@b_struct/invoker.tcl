package require ::quartus::project
set need_to_close_project 0
set make_assignments 1
# Check that the right project is open
if {[is_project_open]} {
   if {[string compare $quartus(project) "audiotest_TB"]} {
      puts "Project audiotest_TB is not open"
      set make_assignments 0
   }
} else {
   # Only open if not already open
   if {[project_exists audiotest_TB]} {
      project_open -revision audiotest_TB audiotest_TB
   } else {
      project_new -revision audiotest_TB audiotest_TB
   }
   set need_to_close_project 1
}

# Make assignments
if {$make_assignments} {
   set_global_assignment -name COMPILER_SETTINGS audiotest_TB
   set_global_assignment -name SIMULATOR_SETTINGS audiotest_TB
   set_global_assignment -name SOFTWARE_SETTINGS audiotest_TB
   set_global_assignment -name FMAX_REQUIREMENT 50MHz
   set_global_assignment -name FAMILY "cyclone v"
   set_global_assignment -name TOP_LEVEL_ENTITY audiotest_TB
   set_global_assignment -name DEVICE 5cgxfc5c6f27c7
   set_global_assignment -name USE_COMPILER_SETTINGS audiotest_TB
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/norbert/HDS/audiotest/audiotest_lib/hdl/audiotest_tb_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/norbert/HDS/audiotest/audiotest_lib/hdl/clk_res_gen_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/norbert/HDS/audiotest/audiotest_lib/hdl/clk_res_gen_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/norbert/HDS/audiotest/audiotest_lib/hdl/debounce.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/norbert/HDS/audiotest/audiotest_lib/hdl/I2C_minion.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/norbert/HDS/audiotest/audiotest_lib/hdl/audiotestmain_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/norbert/HDS/audiotest/audiotest_lib/hdl/i2c_master.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/norbert/HDS/audiotest/audiotest_lib/hdl/i2s_transceiver_logic.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/norbert/HDS/audiotest/audiotest_lib/hdl/ssm2603regwriter_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/norbert/HDS/audiotest/audiotest_lib/hdl/SSM2603regwriter_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/norbert/HDS/audiotest/audiotest_lib/hdl/testsoundctrl1_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/norbert/HDS/audiotest/audiotest_lib/hdl/testsoundctrl1_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/norbert/HDS/audiotest/audiotest_lib/hdl/taktteiler_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/norbert/HDS/audiotest/audiotest_lib/hdl/taktteiler_behav.vhd" 
	set_global_assignment -name VERILOG_FILE "/u/home/clab/redacted/eds/norbert/HDS/audiotest/audiotest_lib/hdl/pll5012new/pll5012new_0002.v"
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/norbert/HDS/audiotest/audiotest_lib/hdl/pll5012new.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/norbert/HDS/audiotest/audiotest_lib/hdl/codecsetup1_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/norbert/HDS/audiotest/audiotest_lib/hdl/codecsetup1_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/norbert/HDS/audiotest/audiotest_lib/hdl/audiotestmain_struct.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/norbert/HDS/audiotest/audiotest_lib/hdl/audiotest_tb_struct.vhd" 


   # Commit assignments
   export_assignments


   # Close project
   if {$need_to_close_project} {
      project_close
   }
}

