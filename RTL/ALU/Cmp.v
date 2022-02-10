// Signed and Unsigned integer comparator
module Cmp(in_numA, in_numB, out_Signed, out_Unsigned, out_flag);
    parameter DATA_WIDTH = 64;

    input   [DATA_WIDTH - 1:0] in_numA, in_numB;
    output  [DATA_WIDTH - 1:0] out_Signed, out_Unsigned;
    output  [4:0] out_flag;

    wire same_sign;
    wire [DATA_WIDTH - 1:0] unsigned_numA, unsigned_numB, same_sign_cmp, diff_sign_cmp;

    assign same_sign = !(in_numA[DATA_WIDTH - 1] ^ in_numB[DATA_WIDTH - 1]);
    assign unsigned_numA = (in_numA[DATA_WIDTH - 1]) ? (~in_numA + 64'd1) : in_numA;
    assign unsigned_numB = (in_numB[DATA_WIDTH - 1]) ? (~in_numB + 64'd1) : in_numB;
    assign same_sign_cmp = (unsigned_numA < unsigned_numB) ? 64'd1 : 64'd0;
    assign diff_sign_cmp = (in_numA[DATA_WIDTH - 1]) ? 64'd1 : 64'd0;

    assign out_Signed = (same_sign) ? same_sign_cmp : diff_sign_cmp;
    assign out_Unsigned = (in_numA < in_numB) ? 64'd1 : 64'd0;

    assign out_flag[4] = (in_numA == in_numB) ? 1'b1 : 1'b0;    // Equal flag
    assign out_flag[3] = out_Signed[0];                         // Less than flag
    assign out_flag[2] = out_Unsigned[0];                       // Less than flag (unsigned comparison)
    assign out_flag[1] = (out_flag[4] | (!out_flag[3]));        // Greater or equal flag
    assign out_flag[0] = (out_flag[4] | (!out_flag[2]));        // Greater or equal flag (unsigned comparison)
endmodule