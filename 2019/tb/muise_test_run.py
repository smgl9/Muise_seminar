# -*- coding: utf-8 -*-
from os.path import join , dirname, abspath
import subprocess
from vunit.sim_if.ghdl import GHDLInterface
from vunit.sim_if.factory import SIMULATOR_FACTORY
from vunit   import VUnit, VUnitCLI
from vunit.verilog import VUnit

##############################################################################
##############################################################################
##############################################################################

#Check simulator.
print ("=============================================")
simulator_class = SIMULATOR_FACTORY.select_simulator()
simname = simulator_class.name
print (simname)
if (simname == "modelsim"):
  f= open("modelsim.do","w+")
  f.write("add wave * \nlog -r /*\nvcd file\nvcd add -r /*\n")
  f.close()
print ("=============================================")

##############################################################################
##############################################################################
##############################################################################

#VUnit instance.
ui = VUnit.from_argv()

##############################################################################
##############################################################################
##############################################################################

ui.add_library("/opt/modelsim/18.0/modelsim_ase/altera/verilog/altera_mf")

#Add module sources.
muise_test_src_lib = ui.add_library("src_lib")
muise_test_src_lib.add_source_files("../src/if_else_test.sv")
muise_test_src_lib.add_source_files("../src/case_test.sv")
muise_test_src_lib.add_source_files("../src/flag_cdc.sv")
muise_test_src_lib.add_source_files("../src/lvds_adc.sv")

#Add tb sources.
muise_test_tb_lib = ui.add_library("tb_lib")
muise_test_tb_lib.add_source_files("if_else_test_tb.sv")
muise_test_tb_lib.add_source_files("case_test_tb.sv")
muise_test_tb_lib.add_source_files("flag_cdc_tb.sv")
muise_test_tb_lib.add_source_files("lvds_tb.sv")

##############################################################################
##############################################################################
##############################################################################

ui.set_sim_option("modelsim.init_files.after_load" ,["modelsim.do"])


#Run tests.
try:
  ui.main()
except SystemExit as exc:
  all_ok = exc.code == 0

