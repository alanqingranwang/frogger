
module lab8_soc (
	reset_reset_n,
	sdram_wire_addr,
	sdram_wire_ba,
	sdram_wire_cas_n,
	sdram_wire_cke,
	sdram_wire_cs_n,
	sdram_wire_dq,
	sdram_wire_dqm,
	sdram_wire_ras_n,
	sdram_wire_we_n,
	clk_clk,
	otg_hpi_w_export,
	otg_hpi_r_export,
	otg_hpi_data_in_port,
	otg_hpi_data_out_port,
	otg_hpi_address_export,
	otg_hpi_cs_export,
	keycode_export,
	sdram_clk_clk);	

	input		reset_reset_n;
	output	[12:0]	sdram_wire_addr;
	output	[1:0]	sdram_wire_ba;
	output		sdram_wire_cas_n;
	output		sdram_wire_cke;
	output		sdram_wire_cs_n;
	inout	[31:0]	sdram_wire_dq;
	output	[3:0]	sdram_wire_dqm;
	output		sdram_wire_ras_n;
	output		sdram_wire_we_n;
	input		clk_clk;
	output		otg_hpi_w_export;
	output		otg_hpi_r_export;
	input	[15:0]	otg_hpi_data_in_port;
	output	[15:0]	otg_hpi_data_out_port;
	output	[1:0]	otg_hpi_address_export;
	output		otg_hpi_cs_export;
	output	[15:0]	keycode_export;
	output		sdram_clk_clk;
endmodule