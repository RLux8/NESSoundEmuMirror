package require ::quartus::project
set need_to_close_project 0
set make_assignments 1
# Check that the right project is open
if {[is_project_open]} {
   if {[string compare $quartus(project) "NEStoplevelTB"]} {
      puts "Project NEStoplevelTB is not open"
      set make_assignments 0
   }
} else {
   # Only open if not already open
   if {[project_exists NEStoplevelTB]} {
      project_open -revision NEStoplevelTB NEStoplevelTB
   } else {
      project_new -revision NEStoplevelTB NEStoplevelTB
   }
   set need_to_close_project 1
}

# Make assignments
if {$make_assignments} {
   set_global_assignment -name COMPILER_SETTINGS NEStoplevelTB
   set_global_assignment -name SIMULATOR_SETTINGS NEStoplevelTB
   set_global_assignment -name SOFTWARE_SETTINGS NEStoplevelTB
   set_global_assignment -name FMAX_REQUIREMENT 50MHz
   set_global_assignment -name FAMILY "cyclone v"
   set_global_assignment -name TOP_LEVEL_ENTITY NEStoplevelTB
   set_global_assignment -name DEVICE 5cgxfc5c6f27c7
   set_global_assignment -name USE_COMPILER_SETTINGS NEStoplevelTB
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/nestopleveltb_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/nesplayertoplevel_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/booleanvectors_pkg.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/booleanvectors_pkg_body.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/toplevelcontrol_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/toplevelcontrol_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/i2c_master.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/i2s_transceiver_logic.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/ssm2603regwriter_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/SSM2603regwriter_behav.vhd" 
	set_global_assignment -name VERILOG_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/pll5012new/pll5012new_0002.v"
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/pll5012new.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/codecsetup_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/codecsetup1_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/completenes_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/memarbitermx65interface_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/memarbitermx65interface_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/mx65withtick_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/apu_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/apumixer_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/apumixer_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/noisechannel_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/noiselfsr1_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/NoiseLFSR1_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/noisetimer_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/noisetimer_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/noisewriteport_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/noisewriteport_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/pulseenv_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/pulseenv_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/premixer_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/premixer_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/pulselentghunit_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/pulselentghunit_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/noisechannel_struct.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/pulsechannel_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/psweep_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/psweep_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/pulsewriteport2_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/pulsewriteport2_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/pulsedividersequence_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/pulsedividersequence_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/pulsechannel_struct.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/statusandaddrdec_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/statusandaddrdec_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/trianglechannel_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/trianglelengthunit_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/trianglelengthunit_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/timer1_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/timer1_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/trianglewriteport_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/trianglewriteport_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/trianglelinearctr_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/trianglelinearctr_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/triangleseq_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/triangleseq_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/trianglechannel_struct.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/dmcchannnel_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/dmcmemoryreader_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/dmcmemoryReader_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/dmcoutputlevel_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/dmcoutputlevel1_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/dmcsampleshifter_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/dmcsampleshifter_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/dmctimer_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/dmctimer_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/dmcwriteport_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/dmcwriteport1_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/dmcchannnel_struct.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/framecounter_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/framecounter_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/apu_struct.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/memorieswrapper_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/quartusNESbootROM.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/quartuscompatibleram_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/songramwrapper_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/quartusNESsongRAM.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/bytemux1_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/bytemux1_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/songramwrapper_struct.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/addrdecodereadmem_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/addrdecoderead1_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/bankswitcher_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/bankswitcher_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/initialisableram_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/initialisableRAM_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/memorieswrapper_struct.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/controlport_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/controlPort_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/twoportarbiter_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/twoportarbiter_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/addrdecodereaddev_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/addrdecoderead_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/taktteilerboolean_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/taktteilerboolean_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/addrdecodewrite_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/addrdecodewrite_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/completenes_struct.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/nesplayertoplevel_struct.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/clk_res_gen_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/clk_res_gen_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/nestopleveltb_struct.vhd" 


   # Commit assignments
   export_assignments


   # Close project
   if {$need_to_close_project} {
      project_close
   }
}

