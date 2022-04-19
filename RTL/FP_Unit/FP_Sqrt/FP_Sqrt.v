// Floating-point Square-root Calculation
// The Newton - Raphson method is used here:
// x_(i) = 0,5 * (x_(i-1) + (X/x_(i-1))), with X is the number to find square-root

module FP_Sqrt(in_data, in_Clk, in_Rst_N, in_start, out_data, out_stall);
    parameter   DATA_WIDTH = 32;

    input   in_Clk, in_Rst_N, in_start;
    input   [DATA_WIDTH - 1:0] in_data;
    output  out_stall;
    output  [DATA_WIDTH - 1:0] out_data;

    // Internal wires
    wire    [7:0] true_exp, exp_div_two, final_exp;
    wire    [253:0] true_mant, extended_mant, mant_sqrt_out, final_mant;

    assign  true_exp = in_data[30:23] - 8'd127;
    assign  exp_div_two = true_exp >> 1;

    assign extended_mant = {127'd1, in_data[22:0], 104'd0};
    assign true_mant = (true_exp[7]) ? extended_mant >> (~true_exp + 8'd1) : extended_mant << true_exp;

    assign out_data = {1'b0, (final_exp + 8'd127), final_mant[126:104]};

    Mant_Sqrt Mant_Sqrt_Inst0(
        .in_data(true_mant),
        .in_Clk(in_Clk),
        .in_Rst_N(in_Rst_N),
        .in_start(in_start),
        .out_data(mant_sqrt_out),
        .out_stall(out_stall)
    );

    Sqrt_Norm Sqrt_Norm_Inst0(
        .in_Exp(exp_div_two),
        .in_Mant(mant_sqrt_out),
        .out_Exp(final_exp),
        .out_Mant(final_mant)
    );
endmodule