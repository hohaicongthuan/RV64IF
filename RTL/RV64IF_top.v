module RV64IF_top(in_DM_data, in_inst, in_Clk, Rst_N, out_inst_addr, out_addr, out_wr_data, out_DM_wr_en);
    input   in_Clk, Rst_N;
    input   [31:0] in_inst;
    input   [63:0] in_DM_data;

    output  out_DM_wr_en;
    output  [63:0] out_inst_addr, out_addr, out_wr_data;

    wire    [4:0] wire_flag;
    wire    [22:0] wire_ctrl_signal;

    assign out_DM_wr_en = wire_ctrl_signal[0];

    Datapath Datapath_Inst0 (
        .in_ctrl_signal(wire_ctrl_signal[22:1]),
        .in_inst(in_inst),
        .in_DM_data(in_DM_data),
        .Clk(in_Clk),
        .out_inst_addr(out_inst_addr),
        .out_addr(out_addr),
        .out_wr_data(out_wr_data),
        .out_flag(wire_flag),
        .Rst_N(Rst_N)
    );
    ControlUnit ControlUnit_Inst0 (
        .in_inst(in_inst),
        .in_flag(wire_flag),
        .out_ctrl_signal(wire_ctrl_signal)
    );
endmodule