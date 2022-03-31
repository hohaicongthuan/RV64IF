// Top-level module of floating-point divisor

module FP_Div(in_numA, in_numB, in_Clk, in_Rst_N, in_start, out_result, out_stall);
    parameter DATA_WIDTH = 32;
    parameter EXP_WIDTH = 8;
    parameter MANT_WIDTH = 23;

    input   in_Clk, in_Rst_N, in_start;
    input   [DATA_WIDTH - 1:0] in_numA, in_numB;
    output  out_stall;
    output  [DATA_WIDTH - 1:0] out_result;

    // Internal wires
    wire    result_sign;
    wire    [EXP_WIDTH - 1:0] result_exp, normalised_exp, final_Exp;
    wire    [MANT_WIDTH:0] result_mant, result_quotient;
    wire    [DATA_WIDTH - 1:0] numA, numB;

    assign numA = {in_numA[31], (in_numA[30:23] - 8'd127), in_numA[22:0]};
    assign numB = {in_numB[31], (in_numB[30:23] - 8'd127), in_numB[22:0]};

    assign result_sign = in_numA[31] ^ in_numB[31];
    assign result_exp = normalised_exp + 8'd127;

    Mant_Div Mant_Div_Inst0(
        .in_dividend({2'd1, numA[22:0]}),
        .in_divisor({1'b1, numB[22:0]}),
        .in_Clk(in_Clk),
        .in_Rst_N(in_Rst_N),
        .in_start(in_start),
        .out_quotient(result_quotient),
        .out_stall(out_stall)
    );
    Div_Norm Div_Norm_Inst0(
        .in_Exp(numA[30:23] - numB[30:23]),
        .in_Mant(result_quotient),
        .out_Exp(normalised_exp),
        .out_Mant(result_mant)
    );

    assign final_Exp = (result_mant == 24'd0) ? 8'd0 : result_exp;
    assign out_result = {result_sign, final_Exp, result_mant[22:0]};
endmodule