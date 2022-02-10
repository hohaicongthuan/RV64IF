module OneBit_Div(in_dividend, in_divisor, out_quotient, out_remainder);
    input [24:0] in_dividend;
    input [23:0] in_divisor;

    output reg out_quotient;
    output reg [24:0] out_remainder;

    always @ (*) begin
        out_quotient = (in_dividend > in_divisor) ? 1'b1 : 1'b0;
        out_remainder = (out_quotient) ? ((in_dividend - in_divisor) << 1) : (in_dividend << 1);
    end
endmodule