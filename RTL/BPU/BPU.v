// Branch Prediction Unit

module BPU(in_PC, in_hit, in_Clk, in_Rst_N, out_prediction);
    input   in_Clk, in_Rst_N;
    input   [1:0] in_hit;   // LSB defines if predictor 0 hit or not, MSB defines if predictor 1 hit or not
    input   [8:0] in_PC;
    output  out_prediction;

    wire    predictor_selector_Out, bimodal_prediction, gshare_prediction;

    assign out_prediction = (predictor_selector_Out) ? gshare_prediction : bimodal_prediction;

    predictor_sel predictor_sel_Inst0(
        .in_hit(in_hit),
        .in_Clk(in_Clk),
        .in_Rst_N(in_Rst_N),
        .out_selection(predictor_selector_Out)
    );

    bimodal bimodal_Inst0(
        .in_PC(in_PC),
        .in_hit(in_hit[0]),
        .in_Clk(in_Clk),
        .in_Rst_N(in_Clk),
        .out_prediction(bimodal_prediction)
    );

    gshare gshare_Inst0(
        .in_PC(in_PC),
        .in_hit(in_hit[1]),
        .in_Clk(in_Clk),
        .in_Rst_N(in_Rst_N),
        .out_prediction(gshare_prediction)
    );
endmodule