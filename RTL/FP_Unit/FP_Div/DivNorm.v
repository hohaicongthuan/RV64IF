// Divider Normaliser
module DivNorm(in_Exp, in_Mant, out_Exp, out_Mant);
    parameter EXP_WIDTH = 8;
    parameter MANT_WIDTH = 23;

    input   [EXP_WIDTH - 1:0] in_Exp;
    input   [MANT_WIDTH:0] in_Mant;

    output reg   [EXP_WIDTH - 1:0] out_Exp;
    output reg   [MANT_WIDTH:0] out_Mant;

    always @ (*) begin
        if (in_Mant[23]) begin out_Exp = in_Exp; out_Mant = in_Mant; end
        else if (in_Mant[22]) begin out_Exp = in_Exp - 8'd1; out_Mant = in_Mant << 1; end
        else if (in_Mant[21]) begin out_Exp = in_Exp - 8'd2; out_Mant = in_Mant << 2; end
        else if (in_Mant[20]) begin out_Exp = in_Exp - 8'd3; out_Mant = in_Mant << 3; end
        else if (in_Mant[19]) begin out_Exp = in_Exp - 8'd4; out_Mant = in_Mant << 4; end
        else if (in_Mant[18]) begin out_Exp = in_Exp - 8'd5; out_Mant = in_Mant << 5; end
        else if (in_Mant[17]) begin out_Exp = in_Exp - 8'd6; out_Mant = in_Mant << 6; end
        else if (in_Mant[16]) begin out_Exp = in_Exp - 8'd7; out_Mant = in_Mant << 7; end
        else if (in_Mant[15]) begin out_Exp = in_Exp - 8'd8; out_Mant = in_Mant << 8; end
        else if (in_Mant[14]) begin out_Exp = in_Exp - 8'd9; out_Mant = in_Mant << 9; end
        else if (in_Mant[13]) begin out_Exp = in_Exp - 8'd10; out_Mant = in_Mant << 10; end
        else if (in_Mant[12]) begin out_Exp = in_Exp - 8'd11; out_Mant = in_Mant << 11; end
        else if (in_Mant[11]) begin out_Exp = in_Exp - 8'd12; out_Mant = in_Mant << 12; end
        else if (in_Mant[10]) begin out_Exp = in_Exp - 8'd13; out_Mant = in_Mant << 13; end
        else if (in_Mant[9]) begin out_Exp = in_Exp - 8'd14; out_Mant = in_Mant << 14; end
        else if (in_Mant[8]) begin out_Exp = in_Exp - 8'd15; out_Mant = in_Mant << 15; end
        else if (in_Mant[7]) begin out_Exp = in_Exp - 8'd16; out_Mant = in_Mant << 16; end
        else if (in_Mant[6]) begin out_Exp = in_Exp - 8'd17; out_Mant = in_Mant << 17; end
        else if (in_Mant[5]) begin out_Exp = in_Exp - 8'd18; out_Mant = in_Mant << 18; end
        else if (in_Mant[4]) begin out_Exp = in_Exp - 8'd19; out_Mant = in_Mant << 19; end
        else if (in_Mant[3]) begin out_Exp = in_Exp - 8'd20; out_Mant = in_Mant << 20; end
        else if (in_Mant[2]) begin out_Exp = in_Exp - 8'd21; out_Mant = in_Mant << 21; end
        else if (in_Mant[1]) begin out_Exp = in_Exp - 8'd22; out_Mant = in_Mant << 22; end
        else begin out_Exp = in_Exp - 8'd23; out_Mant = in_Mant << 23; end
    end
endmodule