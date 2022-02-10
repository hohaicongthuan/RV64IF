// Multiplier Normaliser
module MultNorm(in_Exp, in_Mant, out_Exp, out_Mant);
    input [7:0] in_Exp;
    input [47:0] in_Mant;

    output [7:0] out_Exp;
    output [23:0] out_Mant;

    assign out_Exp = (in_Mant[47]) ? (in_Exp + 8'd1) : in_Exp;
    assign out_Mant = (in_Mant[47]) ? in_Mant[47:24] : in_Mant[46:23];
endmodule