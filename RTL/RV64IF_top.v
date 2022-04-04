module RV64IF_top(in_DM_data, in_inst, in_Clk, Rst_N, out_inst_addr, out_addr, out_wr_data, out_DM_wr_en);
    input   in_Clk, Rst_N;
    input   [31:0] in_inst;
    input   [63:0] in_DM_data;

    output  out_DM_wr_en;
    output  [63:0] out_inst_addr, out_addr, out_wr_data;

    wire    bpu_prediction;
    wire    [4:0] wire_flag;
    wire    [23:0] wire_ctrl_signal;

    Datapath Datapath_Inst0 (
        .in_ctrl_signal(wire_ctrl_signal),
        .in_inst(in_inst),
        .in_DM_data(in_DM_data),
        .Clk(in_Clk),
        .out_inst_addr(out_inst_addr),
        .out_addr(out_addr),
        .out_wr_data(out_wr_data),
        .out_DM_write_en(out_DM_wr_en),
        .out_flag(wire_flag),
        .Rst_N(Rst_N),
        .out_prediction(bpu_prediction)
    );
    ControlUnit ControlUnit_Inst0 (
        .in_inst(in_inst),
        .in_flag(wire_flag),
        .in_prediction(bpu_prediction),
        .out_ctrl_signal(wire_ctrl_signal),
        .out_flush()
    );
endmodule