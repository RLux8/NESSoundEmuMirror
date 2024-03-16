package require ::quartus::project
set need_to_close_project 0
set make_assignments 1
# Check that the right project is open
if {[is_project_open]} {
   if {[string compare $quartus(project) "completeNES"]} {
      puts "Project completeNES is not open"
      set make_assignments 0
   }
} else {
   # Only open if not already open
   if {[project_exists completeNES]} {
      project_open -revision completeNES completeNES
   } else {
      project_new -revision completeNES completeNES
   }
   set need_to_close_project 1
}

# Make assignments
if {$make_assignments} {
   set_global_assignment -name COMPILER_SETTINGS completeNES
   set_global_assignment -name SIMULATOR_SETTINGS completeNES
   set_global_assignment -name SOFTWARE_SETTINGS completeNES
   set_global_assignment -name FMAX_REQUIREMENT 50MHz
   set_global_assignment -name FAMILY "cyclone v"
   set_global_assignment -name TOP_LEVEL_ENTITY completeNES
   set_global_assignment -name DEVICE 5cgxfc5c6f27c7
   set_global_assignment -name USE_COMPILER_SETTINGS completeNES
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/completenes_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/booleanvectors_pkg.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/booleanvectors_pkg_body.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/memarbitermx65interface_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/memarbitermx65interface_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/quartuscompatibleram_behav.vhd" 
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
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/dmcchannnel_struct.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/framecounter_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/framecounter_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/apu_struct.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/clk_res_gen_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/clk_res_gen_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/twoportarbiter_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/twoportarbiter_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/addrdecoderead_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/addrdecoderead_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/taktteilerboolean_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/taktteilerboolean_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/addrdecodewrite_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/addrdecodewrite_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/bankswitcher_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/bankswitcher_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/initialisableram_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/initialisableRAM_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/redacted/eds/NESSoundEmu/NESSoundEmu_lib/hdl/completenes_struct.vhd" 


   # Commit assignments
   export_assignments


   # Close project
   if {$need_to_close_project} {
      project_close
   }
}

