// Bimodal Predictor

module bimodal(in_PC, in_hit, in_Clk, in_Rst_N, out_prediction);
    input   in_hit, in_Clk, in_Rst_N;
    input   [8:0] in_PC;
    output  out_prediction;

    pht pht_Inst0(
        .in_addr(in_PC),
        .in_data(in_hit),
        .in_Clk(in_Clk),
        .in_Rst_N(in_Rst_N),
        .out_prediction(out_prediction)
    );
endmodule