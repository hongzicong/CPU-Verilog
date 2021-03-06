# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir E:/Vivado_workspace/project_1/project_1.cache/wt [current_project]
set_property parent.project_path E:/Vivado_workspace/project_1/project_1.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property vhdl_version vhdl_2k [current_fileset]
read_verilog -library xil_defaultlib {
  E:/Vivado_workspace/project_1/project_1.srcs/sources_1/new/DataSelect32_plus.v
  E:/Vivado_workspace/project_1/project_1.srcs/sources_1/new/Register.v
  E:/Vivado_workspace/project_1/project_1.srcs/sources_1/new/SignOrZeroExtend.v
  E:/Vivado_workspace/project_1/project_1.srcs/sources_1/new/ROM.v
  E:/Vivado_workspace/project_1/project_1.srcs/sources_1/new/RAM.v
  E:/Vivado_workspace/project_1/project_1.srcs/sources_1/new/PCImmediate.v
  E:/Vivado_workspace/project_1/project_1.srcs/sources_1/new/PC4.v
  E:/Vivado_workspace/project_1/project_1.srcs/sources_1/new/PC.v
  E:/Vivado_workspace/project_1/project_1.srcs/sources_1/new/DataSelect32.v
  E:/Vivado_workspace/project_1/project_1.srcs/sources_1/new/ControlUnit.v
  E:/Vivado_workspace/project_1/project_1.srcs/sources_1/new/ALU.v
  E:/Vivado_workspace/project_1/project_1.srcs/sources_1/new/DataSelect5.v
  E:/Vivado_workspace/project_1/project_1.srcs/sources_1/new/main.v
}
synth_design -top main -part xc7a35tcpg236-1
write_checkpoint -noxdef main.dcp
catch { report_utilization -file main_utilization_synth.rpt -pb main_utilization_synth.pb }
