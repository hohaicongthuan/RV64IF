// This module converts:
//      32-bit floating-point to 32-bit (signed/unsigned) integer
//      32-bit floating-point to 64-bit (signed/unsigned) integer
module FP_Int_Convert(in_data, in_fmt, out_data, out_flg_NV);
    input   [1:0] in_fmt;       // Determine the output format (32-bit or 64 bit, signed or unsigned integer)
                                // 00: 32-bit signed integer
                                // 01: 32-bit unsigned integer
                                // 10: 64-bit signed integer
                                // 11: 64-bit unsigned integer

    input   [31:0] in_data;

    output  out_flg_NV;             // Invalid flag
    output  [63:0] out_data;

    // Internal wires
    wire    [86:0] shifted_num, mant;
    wire    sign, invalid_case_1, invalid_case_2, invalid_case_3, invalid_case_4;
    wire    [7:0] exp, exp_abs;
    wire    [63:0] output_1, output_2;

    assign sign = in_data[31];
    assign exp = in_data[30:23] - 8'd127;
    assign mant = {64'd1, in_data[22:0]};

    assign shifted_num = mant << exp[5:0];

    assign output_1 = (in_fmt[1]) ? shifted_num[86:23] : {32'd0, shifted_num[54:23]};
    assign output_2 = (sign & !in_fmt[0]) ? (~output_1 + 64'd1) : output_1;

    assign out_data = (exp[7]) ? 64'd0 : output_2; // The exponent is negative, which means the integer < 0

    // Get absolute value of exponent
    assign exp_abs = (exp[7]) ? (~exp + 8'd1) : exp;

    // Check if the inputted number could be represent in 32 or 64 bit integer
    // If it could, NV flag is clear, otherwise, it is set
    assign invalid_case_1 = ((exp_abs > 8'd31) & (in_fmt == 2'b00)) ? 1'b1 : 1'b0;
    assign invalid_case_2 = ((exp_abs > 8'd32) & (in_fmt == 2'b01)) ? 1'b1 : 1'b0;
    assign invalid_case_3 = ((exp_abs > 8'd63) & (in_fmt == 2'b10)) ? 1'b1 : 1'b0;
    assign invalid_case_4 = ((exp_abs > 8'd64) & (in_fmt == 2'b11)) ? 1'b1 : 1'b0;
    assign out_flg_NV = invalid_case_1 | invalid_case_2 | invalid_case_3 | invalid_case_4;
endmodule