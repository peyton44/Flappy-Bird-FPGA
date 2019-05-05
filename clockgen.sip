set_global_assignment -entity "clockgen" -library "lib_clockgen" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "clockgen" -library "lib_clockgen" -name IP_TOOL_VERSION "16.1"
set_global_assignment -entity "clockgen" -library "lib_clockgen" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_clockgen" -name SPD_FILE [file join $::quartus(sip_path) "clockgen.spd"]

set_global_assignment -library "lib_clockgen" -name MISC_FILE [file join $::quartus(sip_path) "clockgen_sim/clockgen.vo"]
