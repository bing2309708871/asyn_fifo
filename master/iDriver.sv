class iDriver extends uvm_driver #(packet);

  `uvm_component_utils(iDriver)

   virtual fifo_if_w vif;           // DUT virtual interface


  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    uvm_config_db#(virtual fifo_if_w)::get(this, "", "vif", vif);
  endfunction: build_phase

  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    if (vif == null) begin
      `uvm_fatal("CFGERR", "Interface for Driver not set");
    end
  endfunction: end_of_elaboration_phase

  virtual function void start_of_simulation_phase(uvm_phase phase);
    super.start_of_simulation_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: start_of_simulation_phase

  virtual task run_phase(uvm_phase phase);
    integer i;
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    vif.winc = 1'b0;
    wait(vif.wrst_n == 1);

    
    forever begin
      seq_item_port.get_next_item(req);
	  //`uvm_info("DRV_RUN", {"\n", req.sprint()}, UVM_MEDIUM);
      if (req.valid)
        write(req);
      seq_item_port.item_done();
    end
  endtask: run_phase

  virtual task write(packet tr);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
        @ (posedge vif.wclk);
		if (vif.wfull==1'b0) begin
			vif.winc = 1'b1;
			vif.wdata = tr.wdata;
			@ (posedge vif.wclk);
		end
        vif.winc = 1'b0;
  endtask: write

endclass: iDriver
