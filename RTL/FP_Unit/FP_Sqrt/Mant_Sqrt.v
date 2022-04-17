module Mant_Sqrt(in_data, in_Clk, in_Rst_N, in_start, out_data, out_stall);
    input   in_Clk, in_Rst_N, in_start;
    input   [253:0] in_data;
    output  out_stall;
    output  [253:0] out_data;

    // Internal wires
    wire    load_signal, div_start_signal, div_stall;
    wire    [253:0] sqrt_result_src, sqrt_result_out;
    wire    [254:0] sqrt_div_out;

    assign sqrt_result_src = (load_signal) ? in_data : out_data;
    assign out_data = (sqrt_div_out[253:0] + sqrt_result_out) >> 1;

    Mant_Sqrt_Ctrl Mant_Sqrt_Ctrl_Inst0(
        .in_Clk(in_Clk),
        .in_Rst_N(in_Rst_N),
        .in_start(in_start),
        .in_stall(div_stall),
        .out_stall(out_stall),
        .out_load(load_signal),
        .out_div_start(div_start_signal)
    );

    Mant_Sqrt_Div Mant_Sqrt_Div_Inst0(
        .in_dividend({1'b0, in_data}),
        .in_divisor(sqrt_result_out),
        .in_Clk(in_Clk),
        .in_Rst_N(in_Rst_N),
        .in_start(div_start_signal),
        .out_stall(div_stall),
        .out_quotient(sqrt_div_out)
    );

    REG #(.DATA_WIDTH(254)) REG_Result_Inst0(
        .in_data(sqrt_result_src),
        .out_data(sqrt_result_out),
        .Clk(in_Clk),
        .Rst_N(in_Rst_N),
        .En(!div_stall)
    );
endmodule