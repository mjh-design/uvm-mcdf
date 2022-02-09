`ifndef AGENT_BUS_SV
`define AGENT_BUS_SV

class agent_bus extends uvm_agent;
	driver_reg drv;
	monitor_reg mon;
	sequencer_reg sqr;

	// uvm_analysis_port #(transaction_bus) ap;

	`uvm_component_utils(agent_bus);
	function new(string name = "agent_bus", uvm_component parent);
		super.new(name, parent);
	endfunction

	extern virtual function void build_phase(uvm_phase phase);
	extern virtual function void connect_phase(uvm_phase phase);

endclass

function void agent_bus::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(is_active == UVM_ACTIVE) begin
		drv = driver_reg::type_id::create("drv", this);
		sqr = sequencer_reg::type_id::create("sqr", this);
	end
	mon = monitor_reg::type_id::create("mon", this);
endfunction

function void agent_bus::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	if(is_active == UVM_ACTIVE) begin
		drv.seq_item_port.connect(sqr.seq_item_export);
	end
	// ap = mon.ap;
endfunction

`endif

