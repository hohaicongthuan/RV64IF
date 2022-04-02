// Gshare Predictor

module gshare(in_PC, in_hit, in_Clk, in_Rst_N, out_prediction);
    input   in_hit, in_Clk, in_Rst_N;
    input   [8:0] in_PC;
    output  out_prediction;

    wire    [8:0] addr, GR_Out;

    assign addr = in_PC ^ GR_Out;

    shift_reg #(.DATA_WIDTH(9)) GR(
        .in_shift_in(in_hit),
        .in_Clk(in_Clk),
        .in_Rst_N(in_Rst_N),
        .in_En(1'b1),
        .out_data(GR_Out)
    );

    pht pht_Inst0(
        .in_addr(addr),
        .in_data(in_hit),
        .in_Clk(in_Clk),
        .in_Rst_N(in_Rst_N),
        .out_prediction(out_prediction)
    );
endmodule