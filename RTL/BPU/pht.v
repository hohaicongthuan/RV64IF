// Pattern History Table

module pht(in_addr, in_data, in_Clk, in_Rst_N, out_prediction);
    parameter   ADDR_WIDTH = 9;
    parameter   ENTRY_NUM = 512;    // 2^9 = 512 entries

    input   in_data, in_Clk, in_Rst_N;
    input   [ADDR_WIDTH - 1:0] in_addr;
    output  out_prediction;

    wire    [ENTRY_NUM - 1:0] prediction_out, selector;

    sat_counter counter[ENTRY_NUM - 1:0] (
        .in_data(in_data),
        .out_prediction(prediction_out),
        .in_Clk(in_Clk),
        .in_Rst_N(in_Rst_N),
        .in_En(selector)
    );

    assign selector = 512'd1 << in_addr; // Used Barrel Shifter as Decoder here, dunno if it's okay
    assign out_prediction = prediction_out[in_addr];
endmodule