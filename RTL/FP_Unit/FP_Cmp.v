// This module compares two given numbers and returns 1 if the result is true
// otherwise, returns 0
module FP_Cmp(in_numA, in_numB, in_cmp_type, out_data, out_flag_NV);
    parameter DATA_WIDTH = 32;

    input   [DATA_WIDTH - 1:0] in_numA, in_numB;
    input   [1:0] in_cmp_type;  // Comparison type, including: equal (10),
                                // less than (01), and less than or equal comparison (00)

    output  out_flag_NV;
    output  [63:0] out_data;

    // Internal wires
    wire    NaN_exception, numA_sp_exception, numB_sp_exception;
    wire    [DATA_WIDTH - 1:0]  equ_result, lt_result, lte_result,
                                wire_1, wire_2, wire_3, wire_4,
                                sign_cmp, exp_cmp;
    wire    [63:0] wire_5, wire_6;

    // Check NaN in numA as 32-bit FP
    assign numA_sp_exception = ((in_numA[31:23] == 9'b111111111) & (in_numA[22:0] != 23'd0)) ? 1'b1 : 1'b0;
    // Check NaN in numB as 32-bit FP
    assign numB_sp_exception = ((in_numB[31:23] == 9'b111111111) & (in_numB[22:0] != 23'd0)) ? 1'b1 : 1'b0;
    assign NaN_exception = numA_sp_exception | numB_sp_exception;
    assign out_flag_NV = NaN_exception;

    // EQU Comparison
    assign equ_result = (NaN_exception) ? 32'd0 : wire_1;
    assign wire_1 = (in_numA == in_numB) ? 32'd1 : 32'd0;

    // LT Comparison
    assign sign_cmp = (in_numA[31] & !in_numB[31]) ? 32'd1 : 32'd0;
    assign exp_cmp = (in_numA[30:23] < in_numB[30:23]) ? 32'd1 : 32'd0;

    assign lt_result = (NaN_exception) ? 32'd0 : wire_2;
    assign wire_2 = (in_numA[31] == in_numB[31]) ? wire_3 : sign_cmp;
    assign wire_3 = (in_numA[30:23] == in_numB[30:23]) ? wire_4 : exp_cmp;
    assign wire_4 = (in_numA[22:0] < in_numB[22:0]) ? 32'd1 : 32'd0;

    // LTE Comparison
    assign lte_result = (equ_result == 32'd1 | lt_result == 32'd1) ? 32'd1 : 32'd0;

    // Final output
    assign out_data = (in_cmp_type == 2'b10) ? {32'd0, equ_result} : wire_5;
    assign wire_5 = (in_cmp_type == 2'b01) ? {32'd0, lt_result} : wire_6;
    assign wire_6 = (in_cmp_type == 2'b00) ? {32'd0, lte_result} : 64'd0;
endmodule