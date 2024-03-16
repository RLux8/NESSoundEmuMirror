package require ::quartus::project
set need_to_close_project 0
set make_assignments 1
# Check that the right project is open
if {[is_project_open]} {
   if {[string compare $quartus(project) "NESPlayertoplevel"]} {
      puts "Project NESPlayertoplevel is not open"
      set make_assignments 0
   }
} else {
   # Only open if not already open
   if {[project_exists NESPlayertoplevel]} {
      project_open -revision NESPlayertoplevel NESPlayertoplevel
   } else {
      project_new -revision NESPlayertoplevel NESPlayertoplevel
   }
   set need_to_close_project 1
}

# Make assignments
if {$make_assignments} {
   set_global_assignment -name COMPILER_SETTINGS NESPlayertoplevel
   set_global_assignment -name SIMULATOR_SETTINGS NESPlayertoplevel
   set_global_assignment -name SOFTWARE_SETTINGS NESPlayertoplevel
   set_global_assignment -name FMAX_REQUIREMENT 50MHz
   set_global_assignment -name FAMILY "cyclone v"
   set_global_assignment -name TOP_LEVEL_ENTITY NESPlayertoplevel
   set_global_assignment -name DEVICE 5cgxfc5c6f27c7
   set_global_assignment -name USE_COMPILER_SETTINGS NESPlayertoplevel
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/nesplayertoplevel_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/codecsetup_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/codecsetup1_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/booleanvectors_pkg.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/booleanvectors_pkg_body.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/toplevelcontrol_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/toplevelcontrol_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/synchroniser_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/entirenes_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/taktteilerboolean_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/taktteilerboolean_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/apu_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/apumixer_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/apumixer_behav.vhd" 
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
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/apustatusandaddrdec_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/boolstdlogicbusconverter_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/statusandaddrdec_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/trianglechannel_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/trianglelengthunit_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/trianglelengthunit_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/tritimer_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/timer1_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/trianglewriteport_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/trianglewriteport_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/trianglelinearctr_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/trianglelinearctr_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/triangleseq_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/triangleseq_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/trianglechannel_struct.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/framecounter_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/framecounter_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/apu_struct.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/memarbitermx65interface_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/memarbitermx65interface1_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/twoportstdlogicarbi.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/controlport_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/controlPort_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/varfrequencydivider.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/konamivrc6square.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/konamivrc6saw.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/konamivrc6.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/memorieswrapper_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/addrdecodereadmem_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/addrdecoderead1_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/bankswitcher_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/bankswitcher_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/quartusNESbootROM.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/quartuscompatibleram_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/songramwrapper_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/quartusNESsongRAM.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/bytemux1_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/bytemux1_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/songramwrapper_struct.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/initialisableram_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/initialisableRAM_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/memorieswrapper_struct.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/mx65withtick_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/namco163_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/namco163statemachine_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/namco163statemachine_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/dualportramboolean_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/namco163writeport_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/manco163writeport_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/namco163_struct.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/nesmixer_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/nesmixer_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/addrdecodereaddev_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/addrdecodereaddev1_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/loadabletimer_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/addrdecodewritedev_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/addrdecodewrite1_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/entirenes_struct.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/taktteiler_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/taktteiler_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/ssm2603regwriter_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/SSM2603regwriter_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/i2c_master.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/i2s_transceiver_logic.vhd" 
	set_global_assignment -name VERILOG_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/PLL50M_to_12M_13_3M_14_3M/PLL50M_to_12M_13_3M_14_3M_0002.v"
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/PLL50M_to_12M_13_3M_14_3M.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/nesplayertoplevel_struct.vhd" 


   # Commit assignments
   export_assignments


   # Close project
   if {$need_to_close_project} {
      project_close
   }
}

