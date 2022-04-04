// Predictor Selector selects which branch predictor to use

module predictor_sel(in_hit, in_Clk, in_Rst_N, out_selection);
    input   in_Clk, in_Rst_N;
    input   [1:0] in_hit;

    output  out_selection;

    // 00: both predictors not hit              -> 0 (no change)
    // 01: predictor 1 not hit, predictor 0 hit -> 0 (move towards predictor 0)
    // 10: predictor 1 hit, predictor 0 not hit -> 1 (move towards predictor 1)
    // 11: both predictors hit                  -> 1 (no change)

    sat_counter sat_counter_Inst0(
        .in_data(in_hit[1]),
        .out_prediction(out_selection),
        .in_Clk(in_Clk),
        .in_Rst_N(in_Rst_N),
        .in_En(1'b1)
    );
endmodule