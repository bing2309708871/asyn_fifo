class Coverage extends uvm_component;
    `uvm_component_utils(Coverage)
    virtual fifo_if_w vif_w;
    virtual fifo_if_r vif_r;

    covergroup cov_write;
    WINC:coverpoint vif_w.winc {option.auto_bin_max = 2;}
    WFULL:coverpoint vif_w.wfull {option.auto_bin_max = 2;}
    AWFULL:coverpoint vif_w.awfull {option.auto_bin_max = 2;}
    endgroup

    covergroup cov_read;
    RINC:coverpoint vif_r.rinc {option.auto_bin_max = 2;}
    REMPTY:coverpoint vif_r.rempty {option.auto_bin_max = 2;}
    AREMPTY:coverpoint vif_r.arempty {option.auto_bin_max = 2;}
    endgroup
    
    function new(string name="Coverage", uvm_component parent);
		super.new(name, parent);
        `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
		this.cov_write = new();
		this.cov_read = new();
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
        `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
        uvm_config_db#(virtual fifo_if_w)::get(this, "", "vif_w", vif_w);
        uvm_config_db#(virtual fifo_if_r)::get(this, "", "vif_r", vif_r);
	endfunction

    virtual task run_phase(uvm_phase phase);
      `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
      fork 
        this.do_write_sample();
        this.do_read_sample();
      join
    endtask

    virtual task do_write_sample();
        forever begin
          @(posedge vif_w.wclk iff vif_w.wrst_n);
          this.cov_write.sample();
        end
    endtask

    virtual task do_read_sample();
        forever begin
          @(posedge vif_r.rclk iff vif_r.rrst_n);
          this.cov_read.sample();
        end
    endtask

    function void report_phase(uvm_phase phase);
      string s;
      super.report_phase(phase);
      s = "\n---------------------------------------------------------------\n";
      s = {s, "COVERAGE SUMMARY \n"}; 
      s = {s, $sformatf("total coverage: %.1f \n", $get_coverage())}; 
      s = {s, $sformatf("write coverage: %.1f \n", this.cov_write.get_coverage())}; 
      s = {s, $sformatf("read coverage: %.1f \n", this.cov_read.get_coverage())}; 
      s = {s, "---------------------------------------------------------------\n"};
      `uvm_info(get_type_name(), s, UVM_LOW)
    endfunction

endclass
