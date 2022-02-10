module FP_AddSub(in_numA, in_numB, in_ctrl_addsub, out_data);
    input   in_ctrl_addsub;
    input   [31:0] in_numA, in_numB;

    output reg  [31:0] out_data;

    // Internal wires
    reg signA, signB;
    reg [7:0] expA, expB, bigger_exp, exp_diff, normalised_exp, normalised_new_exp;
    reg [25:0] mantA, mantB, adjusted_A, adjusted_B, final_mantA, final_mantB, sum_mant, sum_mant_1, normalised_mant, normalised_new_mant;

    always @ (*) begin
        // Separate components
        signA = in_numA[31];
        signB = in_numB[31] ^ in_ctrl_addsub;
        expA = in_numA[30:23];
        expB = in_numB[30:23];
        mantA = {3'b001, in_numA[22:0]};
        mantB = {3'b001, in_numB[22:0]};

        // Compare exponents
        bigger_exp = (expA > expB) ? (expA - 8'd127) : (expB - 8'd127);
        exp_diff = (expA > expB) ? (expA - expB) : (expB - expA);

        // Adjust mantissae
        adjusted_A = (expA > expB) ? (mantA) : (mantA >> exp_diff);
        adjusted_B = (expA > expB) ? (mantB >> exp_diff) : (mantB);
        final_mantA = (signA) ? ~adjusted_A : adjusted_A;
        final_mantB = (signB) ? ~adjusted_B : adjusted_B;

        // Add mantissae
        sum_mant = final_mantA + final_mantB;
        sum_mant_1 = (sum_mant[25]) ? ~sum_mant : sum_mant;

        if (!sum_mant_1[24] & !sum_mant_1[23]) begin
            normalised_exp = normalised_new_exp;
            normalised_mant = normalised_new_mant;
        end else if (!sum_mant_1[24] & sum_mant_1[23]) begin
            normalised_mant = sum_mant_1;
            normalised_exp = bigger_exp;
        end else begin
            normalised_mant = sum_mant_1 >> 1;
            normalised_exp = bigger_exp + 8'd1;
        end

        if (sum_mant_1[22]) begin normalised_new_exp = bigger_exp - 8'd1; normalised_new_mant = sum_mant_1 << 1; end
        else if (sum_mant_1[21]) begin normalised_new_exp = bigger_exp - 8'd2; normalised_new_mant = sum_mant_1 << 2; end
        else if (sum_mant_1[20]) begin normalised_new_exp = bigger_exp - 8'd3; normalised_new_mant = sum_mant_1 << 3; end
        else if (sum_mant_1[19]) begin normalised_new_exp = bigger_exp - 8'd4; normalised_new_mant = sum_mant_1 << 4; end
        else if (sum_mant_1[18]) begin normalised_new_exp = bigger_exp - 8'd5; normalised_new_mant = sum_mant_1 << 5; end
        else if (sum_mant_1[17]) begin normalised_new_exp = bigger_exp - 8'd6; normalised_new_mant = sum_mant_1 << 6; end
        else if (sum_mant_1[16]) begin normalised_new_exp = bigger_exp - 8'd7; normalised_new_mant = sum_mant_1 << 7; end
        else if (sum_mant_1[15]) begin normalised_new_exp = bigger_exp - 8'd8; normalised_new_mant = sum_mant_1 << 8; end
        else if (sum_mant_1[14]) begin normalised_new_exp = bigger_exp - 8'd9; normalised_new_mant = sum_mant_1 << 9; end
        else if (sum_mant_1[13]) begin normalised_new_exp = bigger_exp - 8'd10; normalised_new_mant = sum_mant_1 << 10; end
        else if (sum_mant_1[12]) begin normalised_new_exp = bigger_exp - 8'd11; normalised_new_mant = sum_mant_1 << 11; end
        else if (sum_mant_1[11]) begin normalised_new_exp = bigger_exp - 8'd12; normalised_new_mant = sum_mant_1 << 12; end
        else if (sum_mant_1[10]) begin normalised_new_exp = bigger_exp - 8'd13; normalised_new_mant = sum_mant_1 << 13; end
        else if (sum_mant_1[9]) begin normalised_new_exp = bigger_exp - 8'd14; normalised_new_mant = sum_mant_1 << 14; end
        else if (sum_mant_1[8]) begin normalised_new_exp = bigger_exp - 8'd15; normalised_new_mant = sum_mant_1 << 15; end
        else if (sum_mant_1[7]) begin normalised_new_exp = bigger_exp - 8'd16; normalised_new_mant = sum_mant_1 << 16; end
        else if (sum_mant_1[6]) begin normalised_new_exp = bigger_exp - 8'd17; normalised_new_mant = sum_mant_1 << 17; end
        else if (sum_mant_1[5]) begin normalised_new_exp = bigger_exp - 8'd18; normalised_new_mant = sum_mant_1 << 18; end
        else if (sum_mant_1[4]) begin normalised_new_exp = bigger_exp - 8'd19; normalised_new_mant = sum_mant_1 << 19; end
        else if (sum_mant_1[3]) begin normalised_new_exp = bigger_exp - 8'd20; normalised_new_mant = sum_mant_1 << 20; end
        else if (sum_mant_1[2]) begin normalised_new_exp = bigger_exp - 8'd21; normalised_new_mant = sum_mant_1 << 21; end
        else if (sum_mant_1[1]) begin normalised_new_exp = bigger_exp - 8'd22; normalised_new_mant = sum_mant_1 << 22; end
        else begin normalised_new_exp = bigger_exp - 8'd23; normalised_new_mant = sum_mant_1 << 23; end

        out_data = {sum_mant[25], (normalised_exp + 8'd127), normalised_mant[22:0]};
    end
endmodule