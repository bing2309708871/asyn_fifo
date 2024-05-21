class input_agent extends uvm_agent;
  `uvm_component_utils(input_agent)

  typedef uvm_sequencer #(packet) packet_sequencer;

  virtual fifo_if_w vif;
  packet_sequencer  sqr;
  iDriver            drv;
  iMonitor          mon;
  uvm_analysis_port #(packet) analysis_port;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    if(is_active == UVM_ACTIVE) begin
      sqr = packet_sequencer::type_id::create("sqr", this);
      drv = iDriver::type_id::create("drv", this);
    end

    mon = iMonitor::type_id::create("mon", this);
    analysis_port = new("analysis_port", this);

    uvm_config_db#(virtual fifo_if_w)::get(this,"","vif_w",vif);
    uvm_config_db#(virtual fifo_if_w)::set(this,"*","vif",vif);
    //uvm_config_db#(virtual fifo_if_w)::set(this,"env.cov","vif_w",vif);

  endfunction: build_phase

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    if (is_active == UVM_ACTIVE) begin
      drv.seq_item_port.connect(sqr.seq_item_export);
    end
    mon.analysis_port.connect(this.analysis_port);
  endfunction: connect_phase

  virtual function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    if (vif == null) begin
      `uvm_fatal("CFGERR", "Interface for input agent not set");
    end
  endfunction: end_of_elaboration_phase

 endclass: input_agent
