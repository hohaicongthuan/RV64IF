// Controller for the mantissa divider in the 32-bit floating-point divider (FP_Div.v)

module Mant_Div_Ctrl(in_Clk, in_start, in_Rst_N, out_load, out_shift_en, out_stall);
    input   in_Clk, in_start, in_Rst_N;
    output  out_load, out_shift_en, out_stall;

    wire    [4:0] counter_out, counter_add_one, counter_dat_in;

    REG #(.DATA_WIDTH(5)) Counter(
        .in_data(counter_dat_in),
        .out_data(counter_out),
        .Clk(in_Clk),
        .Rst_N(in_Rst_N),
        .En(in_start)
    );

    assign counter_add_one = counter_out + 5'd1;
    assign counter_dat_in = (counter_out >= 5'd29) ? 5'd0 : counter_add_one;

    assign out_load = (counter_out == 5'd0) ? 1'b1 : 1'b0;
    assign out_shift_en = (counter_out >= 5'd28 | counter_out == 5'd0) ? 1'b0 : 1'b1;
    assign out_stall = (counter_out >= 5'd28 | counter_out == 5'd0) ? 1'b0 : 1'b1;
endmodule