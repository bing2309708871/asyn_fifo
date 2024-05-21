#-------------------------------------------------------------------------------------------------------
comp  : clean vcs

test = test_base

verbosity = UVM_MEDIUM
#-------------------------------------------------------------------------------------------------------
vcs   :
	vcs -f filelist.f  \
		-timescale=1ns/1ps \
		-ntb_opts uvm-1.2\
		-full64  -R  +vc  +v2k  -sverilog -debug_access+all\
		+UVM_TESTNAME=${test} +UVM_VERBOSITY=${verbosity}\
		|  tee  vcs.log
#-------------------------------------------------------------------------------------------------------
verdi  :
	verdi -f filelist.f -ssf tb.fsdb &
#-------------------------------------------------------------------------------------------------------
viewcov:
	urg -full64 -format both -dir simv.vdb 
	firefox urgReport/dashboard.html
clean  :
	 rm  -rf  *~  core  csrc  simv*  vc_hdrs.h  ucli.key  urg* *.log  novas.* *.fsdb* verdiLog  64* DVEfiles *.vpd
#-------------------------------------------------------------------------------------------------------
