module Mant_Sqrt_Div(in_dividend, in_divisor, in_Clk, in_Rst_N, in_start, out_stall, out_quotient);
    input   in_Clk, in_Rst_N, in_start;
    input   [254:0] in_dividend;
    input   [253:0] in_divisor;
    output  out_stall;
    output  [254:0] out_quotient;

    wire    shift_en, load_signal, divider_quotient;
    wire    [254:0] dividend_src, remainder_out, divider_remainder;

    OneBit_Div #(.DIVIDEND_SIZE(255), .DIVISOR_SIZE(254)) OneBit_Div_Inst0(
        .in_dividend(dividend_src),
        .in_divisor(in_divisor),
        .out_quotient(divider_quotient),
        .out_remainder(divider_remainder)
    );

    REG #(.DATA_WIDTH(255)) Remainder(
        .in_data(divider_remainder),
        .out_data(remainder_out),
        .Clk(in_Clk),
        .Rst_N(in_Rst_N),
        .En(1'b1)
    );

    shift_reg #(.DATA_WIDTH(254)) Quotient(
        .in_shift_in(divider_quotient),
        .in_Clk(in_Clk),
        .in_Rst_N(in_Rst_N),
        .in_En(shift_en),
        .out_data(out_quotient)
    );

    Mant_Sqrt_Div_Ctrl Mant_Sqrt_Div_Ctrl_Inst0(
        .in_Clk(in_Clk),
        .in_start(in_start),
        .out_load(load_signal),
        .out_shift_en(shift_en),
        .out_stall(out_stall),
        .in_Rst_N(in_Rst_N)
    );

    assign dividend_src = (load_signal) ? in_dividend : remainder_out;
endmodule