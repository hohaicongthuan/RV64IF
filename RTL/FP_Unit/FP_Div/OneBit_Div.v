module OneBit_Div(in_dividend, in_divisor, out_quotient, out_remainder);
    parameter   DIVIDEND_SIZE   = 25;
    parameter   DIVISOR_SIZE    = 24;
    
    input [DIVIDEND_SIZE - 1:0] in_dividend;
    input [DIVISOR_SIZE - 1:0] in_divisor;

    output reg out_quotient;
    output reg [DIVIDEND_SIZE - 1:0] out_remainder;

    always @ (*) begin
        out_quotient = (in_dividend > in_divisor) ? 1'b1 : 1'b0;
        out_remainder = (out_quotient) ? ((in_dividend - in_divisor) << 1) : (in_dividend << 1);
    end
endmodule