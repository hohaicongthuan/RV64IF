module FP_Mul(in_numA, in_numB, out_result);
    parameter DATA_WIDTH = 32;
    parameter EXP_WIDTH = 8;
    parameter MANT_WIDTH = 23;

    input   [DATA_WIDTH - 1:0] in_numA, in_numB;
    output  [DATA_WIDTH - 1:0] out_result;

    // Internal wires
    wire    result_sign;
    wire    [EXP_WIDTH - 1:0] result_exp, normalised_exp, sp_final_exp;
    wire    [MANT_WIDTH:0] normalised_mant;
    wire    [DATA_WIDTH - 1:0] numA, numB;
    wire    [47:0] product_mant;

    assign numA = {in_numA[31], (in_numA[30:23] - 8'd127), in_numA[22:0]};
    assign numB = {in_numB[31], (in_numB[30:23] - 8'd127), in_numB[22:0]};

    assign result_sign = numA[31] ^ numB[31];
    assign result_exp = normalised_exp + 8'd127;

    Mant_Mult Mant_Mult_Inst0(
        .in_multiplicand({25'd1, numA[22:0]}),
        .in_multiplier({1'b1, numB[22:0]}),
        .out_product(product_mant)
    );
    MultNorm MultNorm_Inst0(
        .in_Exp(numA[30:23] + numB[30:23]),
        .in_Mant(product_mant),
        .out_Exp(normalised_exp),
        .out_Mant(normalised_mant)
    );

    assign sp_final_exp = (normalised_mant == 24'd0) ? 8'd0 : result_exp;
    assign out_result = {result_sign, sp_final_exp, normalised_mant[22:0]};

endmodule