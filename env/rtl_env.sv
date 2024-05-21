class rtl_env extends uvm_env;
  input_agent i_agt;
  scoreboard sb;
  Coverage   cov;
  output_agent o_agt;

  virtual fifo_if_w vif_w;
  virtual fifo_if_r vif_r;

  `uvm_component_utils(rtl_env)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    i_agt = input_agent::type_id::create("i_agt", this);
    uvm_config_db #(uvm_object_wrapper)::set(this, "i_agt.sqr.main_phase", "default_sequence", packet_sequence::get_type());
    uvm_config_db #(uvm_object_wrapper)::set(this, "o_agt.sqr.main_phase", "default_sequence", packet_sequence::get_type());

    sb = scoreboard::type_id::create("sb", this);
    cov = Coverage::type_id::create("cov",this);

    o_agt = output_agent::type_id::create("o_agt", this);
    uvm_config_db#(virtual fifo_if_w)::get(this, "", "vif_w", vif_w);
    uvm_config_db#(virtual fifo_if_w)::set(this, "*", "vif_w", vif_w); 

    uvm_config_db#(virtual fifo_if_r)::get(this, "", "vif_r", vif_r);
    uvm_config_db#(virtual fifo_if_r)::set(this, "*", "vif_r", vif_r); 


  endfunction: build_phase

    virtual function void connect_phase(uvm_phase phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
      i_agt.analysis_port.connect(sb.before_export);
      o_agt.analysis_port.connect(sb.after_export);
  endfunction: connect_phase
  
endclass: rtl_env
