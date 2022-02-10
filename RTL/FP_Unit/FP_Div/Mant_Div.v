module Mant_Div(in_dividend, in_divisor, out_quotient, out_remainder);
    input [24:0] in_dividend;
    input [23:0] in_divisor;

    output [23:0] out_quotient;
    output [24:0] out_remainder;

    wire [24:0] remainder_1, remainder_2, remainder_3, remainder_4, remainder_5, remainder_6, remainder_7, remainder_8, remainder_9, remainder_10, remainder_11, remainder_12, remainder_13, remainder_14, remainder_15, remainder_16, remainder_17, remainder_18, remainder_19, remainder_20, remainder_21, remainder_22, remainder_23;

    // OneBit_Div OneBit_Div_Inst24(
    //     .in_dividend(remainder_25), .in_divisor(in_divisor),
    //     .out_quotient(out_quotient[24]), .out_remainder(remainder_24));
    OneBit_Div OneBit_Div_Inst23(
        .in_dividend(in_dividend), .in_divisor(in_divisor),
        .out_quotient(out_quotient[23]), .out_remainder(remainder_23));
    OneBit_Div OneBit_Div_Inst22(
        .in_dividend(remainder_23), .in_divisor(in_divisor),
        .out_quotient(out_quotient[22]), .out_remainder(remainder_22));
    OneBit_Div OneBit_Div_Inst21(
        .in_dividend(remainder_22), .in_divisor(in_divisor),
        .out_quotient(out_quotient[21]), .out_remainder(remainder_21));
    OneBit_Div OneBit_Div_Inst20(
        .in_dividend(remainder_21), .in_divisor(in_divisor),
        .out_quotient(out_quotient[20]), .out_remainder(remainder_20));
    OneBit_Div OneBit_Div_Inst19(
        .in_dividend(remainder_20), .in_divisor(in_divisor),
        .out_quotient(out_quotient[19]), .out_remainder(remainder_19));
    OneBit_Div OneBit_Div_Inst18(
        .in_dividend(remainder_19), .in_divisor(in_divisor),
        .out_quotient(out_quotient[18]), .out_remainder(remainder_18));
    OneBit_Div OneBit_Div_Inst17(
        .in_dividend(remainder_18), .in_divisor(in_divisor),
        .out_quotient(out_quotient[17]), .out_remainder(remainder_17));
    OneBit_Div OneBit_Div_Inst16(
        .in_dividend(remainder_17), .in_divisor(in_divisor),
        .out_quotient(out_quotient[16]), .out_remainder(remainder_16));
    OneBit_Div OneBit_Div_Inst15(
        .in_dividend(remainder_16), .in_divisor(in_divisor),
        .out_quotient(out_quotient[15]), .out_remainder(remainder_15));
    OneBit_Div OneBit_Div_Inst14(
        .in_dividend(remainder_15), .in_divisor(in_divisor),
        .out_quotient(out_quotient[14]), .out_remainder(remainder_14));
    OneBit_Div OneBit_Div_Inst13(
        .in_dividend(remainder_14), .in_divisor(in_divisor),
        .out_quotient(out_quotient[13]), .out_remainder(remainder_13));
    OneBit_Div OneBit_Div_Inst12(
        .in_dividend(remainder_13), .in_divisor(in_divisor),
        .out_quotient(out_quotient[12]), .out_remainder(remainder_12));
    OneBit_Div OneBit_Div_Inst11(
        .in_dividend(remainder_12), .in_divisor(in_divisor),
        .out_quotient(out_quotient[11]), .out_remainder(remainder_11));
    OneBit_Div OneBit_Div_Inst10(
        .in_dividend(remainder_11), .in_divisor(in_divisor),
        .out_quotient(out_quotient[10]), .out_remainder(remainder_10));
    OneBit_Div OneBit_Div_Inst9(
        .in_dividend(remainder_10), .in_divisor(in_divisor),
        .out_quotient(out_quotient[9]), .out_remainder(remainder_9));
    OneBit_Div OneBit_Div_Inst8(
        .in_dividend(remainder_9), .in_divisor(in_divisor),
        .out_quotient(out_quotient[8]), .out_remainder(remainder_8));
    OneBit_Div OneBit_Div_Inst7(
        .in_dividend(remainder_8), .in_divisor(in_divisor),
        .out_quotient(out_quotient[7]), .out_remainder(remainder_7));
    OneBit_Div OneBit_Div_Inst6(
        .in_dividend(remainder_7), .in_divisor(in_divisor),
        .out_quotient(out_quotient[6]), .out_remainder(remainder_6));
    OneBit_Div OneBit_Div_Inst5(
        .in_dividend(remainder_6), .in_divisor(in_divisor),
        .out_quotient(out_quotient[5]), .out_remainder(remainder_5));
    OneBit_Div OneBit_Div_Inst4(
        .in_dividend(remainder_5), .in_divisor(in_divisor),
        .out_quotient(out_quotient[4]), .out_remainder(remainder_4));
    OneBit_Div OneBit_Div_Inst3(
        .in_dividend(remainder_4), .in_divisor(in_divisor),
        .out_quotient(out_quotient[3]), .out_remainder(remainder_3));
    OneBit_Div OneBit_Div_Inst2(
        .in_dividend(remainder_3), .in_divisor(in_divisor),
        .out_quotient(out_quotient[2]), .out_remainder(remainder_2));
    OneBit_Div OneBit_Div_Inst1(
        .in_dividend(remainder_2), .in_divisor(in_divisor),
        .out_quotient(out_quotient[1]), .out_remainder(remainder_1));
    OneBit_Div OneBit_Div_Inst0(
        .in_dividend(remainder_1), .in_divisor(in_divisor),
        .out_quotient(out_quotient[0]), .out_remainder(out_remainder));
endmodule