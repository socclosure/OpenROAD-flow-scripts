source $::env(SCRIPTS_DIR)/load.tcl
erase_non_stage_variables place
load_design 2_floorplan.odb 2_floorplan.sdc


if { [env_var_exists_and_non_empty FLOORPLAN_DEF] } {
  puts "FLOORPLAN_DEF is set. Skipping global placement without IOs"
} else {
  set place_density [place_density_with_lb_addon]

  if { 0 != [llength [array get ::env GLOBAL_PLACEMENT_ARGS]] } {
    log_cmd global_placement -skip_io -density $place_density \
        -pad_left $::env(CELL_PAD_IN_SITES_GLOBAL_PLACEMENT) \
        -pad_right $::env(CELL_PAD_IN_SITES_GLOBAL_PLACEMENT) \
        {*}$::env(GLOBAL_PLACEMENT_ARGS)
  } else {
    log_cmd global_placement -skip_io -density $place_density \
        -pad_left $::env(CELL_PAD_IN_SITES_GLOBAL_PLACEMENT) \
        -pad_right $::env(CELL_PAD_IN_SITES_GLOBAL_PLACEMENT)
  }
}

write_db $::env(RESULTS_DIR)/3_1_place_gp_skip_io.odb
