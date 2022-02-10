// This module converts:
//      32-bit (signed/unsigned) integer to 32-bit FP
//      64-bit (signed/unsigned) integer to 32-bit FP
module IntToFP(in_data, in_fmt, out_data);
    input   [1:0] in_fmt;       // Determine the format of inputted number (32/64-bit signed/unsigned)
                                // 00: 32-bit signed integer
                                // 01: 32-bit unsigned integer
                                // 10: 64-bit signed integer
                                // 11: 64-bit unsigned integer
    input   [63:0] in_data;

    output  [31:0] out_data;

    // Internal wires
    wire    sign;
    wire    [63:0] in_num_abs;
    wire    [22:0]  mant_result, mant, mant_wire_1, mant_wire_2, mant_wire_3, mant_wire_4, mant_wire_5, mant_wire_6, mant_wire_7, mant_wire_8, mant_wire_9, mant_wire_10, mant_wire_11, mant_wire_12, mant_wire_13, mant_wire_14, mant_wire_15, mant_wire_16, mant_wire_17, mant_wire_18, mant_wire_19, mant_wire_20, mant_wire_21, mant_wire_22, mant_wire_23, mant_wire_24, mant_wire_25, mant_wire_26, mant_wire_27, mant_wire_28, mant_wire_29, mant_wire_30, mant_wire_31, mant_wire_32, mant_wire_33, mant_wire_34, mant_wire_35, mant_wire_36, mant_wire_37, mant_wire_38, mant_wire_39, mant_wire_40, mant_wire_41, mant_wire_42, mant_wire_43, mant_wire_44, mant_wire_45, mant_wire_46, mant_wire_47, mant_wire_48, mant_wire_49, mant_wire_50, mant_wire_51, mant_wire_52, mant_wire_53, mant_wire_54, mant_wire_55, mant_wire_56, mant_wire_57, mant_wire_58, mant_wire_59, mant_wire_60, mant_wire_61;
    wire    [7:0]  exp_result, exp, exp_wire_1, exp_wire_2, exp_wire_3, exp_wire_4, exp_wire_5, exp_wire_6, exp_wire_7, exp_wire_8, exp_wire_9, exp_wire_10, exp_wire_11, exp_wire_12, exp_wire_13, exp_wire_14, exp_wire_15, exp_wire_16, exp_wire_17, exp_wire_18, exp_wire_19, exp_wire_20, exp_wire_21, exp_wire_22, exp_wire_23, exp_wire_24, exp_wire_25, exp_wire_26, exp_wire_27, exp_wire_28, exp_wire_29, exp_wire_30, exp_wire_31, exp_wire_32, exp_wire_33, exp_wire_34, exp_wire_35, exp_wire_36, exp_wire_37, exp_wire_38, exp_wire_39, exp_wire_40, exp_wire_41, exp_wire_42, exp_wire_43, exp_wire_44, exp_wire_45, exp_wire_46, exp_wire_47, exp_wire_48, exp_wire_49, exp_wire_50, exp_wire_51, exp_wire_52, exp_wire_53, exp_wire_54, exp_wire_55, exp_wire_56, exp_wire_57, exp_wire_58, exp_wire_59, exp_wire_60, exp_wire_61, exp_wire_62;

    assign in_num_abs = (in_data[63] & !in_fmt[0]) ? (~in_data + 64'd1) : in_data;

    assign sign = in_data[63] & !in_fmt[0];

    assign mant = (in_num_abs[63]) ? in_num_abs[62:40] : mant_wire_1;
    assign mant_wire_1 = (in_num_abs[62]) ? in_num_abs[61:39] : mant_wire_2;
    assign mant_wire_2 = (in_num_abs[61]) ? in_num_abs[60:38] : mant_wire_3;
    assign mant_wire_3 = (in_num_abs[60]) ? in_num_abs[59:37] : mant_wire_4;
    assign mant_wire_4 = (in_num_abs[59]) ? in_num_abs[58:36] : mant_wire_5;
    assign mant_wire_5 = (in_num_abs[58]) ? in_num_abs[57:35] : mant_wire_6;
    assign mant_wire_6 = (in_num_abs[57]) ? in_num_abs[56:34] : mant_wire_7;
    assign mant_wire_7 = (in_num_abs[56]) ? in_num_abs[55:33] : mant_wire_8;
    assign mant_wire_8 = (in_num_abs[55]) ? in_num_abs[54:32] : mant_wire_9;
    assign mant_wire_9 = (in_num_abs[54]) ? in_num_abs[53:31] : mant_wire_10;
    assign mant_wire_10 = (in_num_abs[53]) ? in_num_abs[52:30] : mant_wire_11;
    assign mant_wire_11 = (in_num_abs[52]) ? in_num_abs[51:29] : mant_wire_12;
    assign mant_wire_12 = (in_num_abs[51]) ? in_num_abs[50:28] : mant_wire_13;
    assign mant_wire_13 = (in_num_abs[50]) ? in_num_abs[49:27] : mant_wire_14;
    assign mant_wire_14 = (in_num_abs[49]) ? in_num_abs[48:26] : mant_wire_15;
    assign mant_wire_15 = (in_num_abs[48]) ? in_num_abs[47:25] : mant_wire_16;
    assign mant_wire_16 = (in_num_abs[47]) ? in_num_abs[46:24] : mant_wire_17;
    assign mant_wire_17 = (in_num_abs[46]) ? in_num_abs[45:23] : mant_wire_18;
    assign mant_wire_18 = (in_num_abs[45]) ? in_num_abs[44:22] : mant_wire_19;
    assign mant_wire_19 = (in_num_abs[44]) ? in_num_abs[43:21] : mant_wire_20;
    assign mant_wire_20 = (in_num_abs[43]) ? in_num_abs[42:20] : mant_wire_21;
    assign mant_wire_21 = (in_num_abs[42]) ? in_num_abs[41:19] : mant_wire_22;
    assign mant_wire_22 = (in_num_abs[41]) ? in_num_abs[40:18] : mant_wire_23;
    assign mant_wire_23 = (in_num_abs[40]) ? in_num_abs[39:17] : mant_wire_24;
    assign mant_wire_24 = (in_num_abs[39]) ? in_num_abs[38:16] : mant_wire_25;
    assign mant_wire_25 = (in_num_abs[38]) ? in_num_abs[37:15] : mant_wire_26;
    assign mant_wire_26 = (in_num_abs[37]) ? in_num_abs[36:14] : mant_wire_27;
    assign mant_wire_27 = (in_num_abs[36]) ? in_num_abs[35:13] : mant_wire_28;
    assign mant_wire_28 = (in_num_abs[35]) ? in_num_abs[34:12] : mant_wire_29;
    assign mant_wire_29 = (in_num_abs[34]) ? in_num_abs[33:11] : mant_wire_30;
    assign mant_wire_30 = (in_num_abs[33]) ? in_num_abs[32:10] : mant_wire_31;
    assign mant_wire_31 = (in_num_abs[32]) ? in_num_abs[31:9] : mant_wire_32;
    assign mant_wire_32 = (in_num_abs[31]) ? in_num_abs[30:8] : mant_wire_33;
    assign mant_wire_33 = (in_num_abs[30]) ? in_num_abs[29:7] : mant_wire_34;
    assign mant_wire_34 = (in_num_abs[29]) ? in_num_abs[28:6] : mant_wire_35;
    assign mant_wire_35 = (in_num_abs[28]) ? in_num_abs[27:5] : mant_wire_36;
    assign mant_wire_36 = (in_num_abs[27]) ? in_num_abs[26:4] : mant_wire_37;
    assign mant_wire_37 = (in_num_abs[26]) ? in_num_abs[25:3] : mant_wire_38;
    assign mant_wire_38 = (in_num_abs[25]) ? in_num_abs[24:2] : mant_wire_39;
    assign mant_wire_39 = (in_num_abs[24]) ? in_num_abs[23:1] : mant_wire_40;
    assign mant_wire_40 = (in_num_abs[23]) ? in_num_abs[22:0] : mant_wire_41;
    assign mant_wire_41 = (in_num_abs[22]) ? {in_num_abs[21:0], 1'd0} : mant_wire_42;
    assign mant_wire_42 = (in_num_abs[21]) ? {in_num_abs[20:0], 2'd0} : mant_wire_43;
    assign mant_wire_43 = (in_num_abs[20]) ? {in_num_abs[19:0], 3'd0} : mant_wire_44;
    assign mant_wire_44 = (in_num_abs[19]) ? {in_num_abs[18:0], 4'd0} : mant_wire_45;
    assign mant_wire_45 = (in_num_abs[18]) ? {in_num_abs[17:0], 5'd0} : mant_wire_46;
    assign mant_wire_46 = (in_num_abs[17]) ? {in_num_abs[16:0], 6'd0} : mant_wire_47;
    assign mant_wire_47 = (in_num_abs[16]) ? {in_num_abs[15:0], 7'd0} : mant_wire_48;
    assign mant_wire_48 = (in_num_abs[15]) ? {in_num_abs[14:0], 8'd0} : mant_wire_49;
    assign mant_wire_49 = (in_num_abs[14]) ? {in_num_abs[13:0], 9'd0} : mant_wire_50;
    assign mant_wire_50 = (in_num_abs[13]) ? {in_num_abs[12:0], 10'd0} : mant_wire_51;
    assign mant_wire_51 = (in_num_abs[12]) ? {in_num_abs[11:0], 11'd0} : mant_wire_52;
    assign mant_wire_52 = (in_num_abs[11]) ? {in_num_abs[10:0], 12'd0} : mant_wire_53;
    assign mant_wire_53 = (in_num_abs[10]) ? {in_num_abs[9:0], 13'd0} : mant_wire_54;
    assign mant_wire_54 = (in_num_abs[9]) ? {in_num_abs[8:0], 14'd0} : mant_wire_55;
    assign mant_wire_55 = (in_num_abs[8]) ? {in_num_abs[7:0], 15'd0} : mant_wire_56;
    assign mant_wire_56 = (in_num_abs[7]) ? {in_num_abs[6:0], 16'd0} : mant_wire_57;
    assign mant_wire_57 = (in_num_abs[6]) ? {in_num_abs[5:0], 17'd0} : mant_wire_58;
    assign mant_wire_58 = (in_num_abs[5]) ? {in_num_abs[4:0], 18'd0} : mant_wire_59;
    assign mant_wire_59 = (in_num_abs[4]) ? {in_num_abs[3:0], 19'd0} : mant_wire_60;
    assign mant_wire_60 = (in_num_abs[3]) ? {in_num_abs[2:0], 20'd0} : mant_wire_61;
    assign mant_wire_61 = (in_num_abs[2]) ? {in_num_abs[1:0], 21'd0} : 23'd0;

    assign exp = (in_num_abs[63]) ? 8'd63 : exp_wire_1;
    assign exp_wire_1 = (in_num_abs[62]) ? 8'd62 : exp_wire_2;
    assign exp_wire_2 = (in_num_abs[61]) ? 8'd61 : exp_wire_3;
    assign exp_wire_3 = (in_num_abs[60]) ? 8'd60 : exp_wire_4;
    assign exp_wire_4 = (in_num_abs[59]) ? 8'd59 : exp_wire_5;
    assign exp_wire_5 = (in_num_abs[58]) ? 8'd58 : exp_wire_6;
    assign exp_wire_6 = (in_num_abs[57]) ? 8'd57 : exp_wire_7;
    assign exp_wire_7 = (in_num_abs[56]) ? 8'd56 : exp_wire_8;
    assign exp_wire_8 = (in_num_abs[55]) ? 8'd55 : exp_wire_9;
    assign exp_wire_9 = (in_num_abs[54]) ? 8'd54 : exp_wire_10;
    assign exp_wire_10 = (in_num_abs[53]) ? 8'd53 : exp_wire_11;
    assign exp_wire_11 = (in_num_abs[52]) ? 8'd52 : exp_wire_12;
    assign exp_wire_12 = (in_num_abs[51]) ? 8'd51 : exp_wire_13;
    assign exp_wire_13 = (in_num_abs[50]) ? 8'd50 : exp_wire_14;
    assign exp_wire_14 = (in_num_abs[49]) ? 8'd49 : exp_wire_15;
    assign exp_wire_15 = (in_num_abs[48]) ? 8'd48 : exp_wire_16;
    assign exp_wire_16 = (in_num_abs[47]) ? 8'd47 : exp_wire_17;
    assign exp_wire_17 = (in_num_abs[46]) ? 8'd46 : exp_wire_18;
    assign exp_wire_18 = (in_num_abs[45]) ? 8'd45 : exp_wire_19;
    assign exp_wire_19 = (in_num_abs[44]) ? 8'd44 : exp_wire_20;
    assign exp_wire_20 = (in_num_abs[43]) ? 8'd43 : exp_wire_21;
    assign exp_wire_21 = (in_num_abs[42]) ? 8'd42 : exp_wire_22;
    assign exp_wire_22 = (in_num_abs[41]) ? 8'd41 : exp_wire_23;
    assign exp_wire_23 = (in_num_abs[40]) ? 8'd40 : exp_wire_24;
    assign exp_wire_24 = (in_num_abs[39]) ? 8'd39 : exp_wire_25;
    assign exp_wire_25 = (in_num_abs[38]) ? 8'd38 : exp_wire_26;
    assign exp_wire_26 = (in_num_abs[37]) ? 8'd37 : exp_wire_27;
    assign exp_wire_27 = (in_num_abs[36]) ? 8'd36 : exp_wire_28;
    assign exp_wire_28 = (in_num_abs[35]) ? 8'd35 : exp_wire_29;
    assign exp_wire_29 = (in_num_abs[34]) ? 8'd34 : exp_wire_30;
    assign exp_wire_30 = (in_num_abs[33]) ? 8'd33 : exp_wire_31;
    assign exp_wire_31 = (in_num_abs[32]) ? 8'd32 : exp_wire_32;
    assign exp_wire_32 = (in_num_abs[31]) ? 8'd31 : exp_wire_33;
    assign exp_wire_33 = (in_num_abs[30]) ? 8'd30 : exp_wire_34;
    assign exp_wire_34 = (in_num_abs[29]) ? 8'd29 : exp_wire_35;
    assign exp_wire_35 = (in_num_abs[28]) ? 8'd28 : exp_wire_36;
    assign exp_wire_36 = (in_num_abs[27]) ? 8'd27 : exp_wire_37;
    assign exp_wire_37 = (in_num_abs[26]) ? 8'd26 : exp_wire_38;
    assign exp_wire_38 = (in_num_abs[25]) ? 8'd25 : exp_wire_39;
    assign exp_wire_39 = (in_num_abs[24]) ? 8'd24 : exp_wire_40;
    assign exp_wire_40 = (in_num_abs[23]) ? 8'd23 : exp_wire_41;
    assign exp_wire_41 = (in_num_abs[22]) ? 8'd22 : exp_wire_42;
    assign exp_wire_42 = (in_num_abs[21]) ? 8'd21 : exp_wire_43;
    assign exp_wire_43 = (in_num_abs[20]) ? 8'd20 : exp_wire_44;
    assign exp_wire_44 = (in_num_abs[19]) ? 8'd19 : exp_wire_45;
    assign exp_wire_45 = (in_num_abs[18]) ? 8'd18 : exp_wire_46;
    assign exp_wire_46 = (in_num_abs[17]) ? 8'd17 : exp_wire_47;
    assign exp_wire_47 = (in_num_abs[16]) ? 8'd16 : exp_wire_48;
    assign exp_wire_48 = (in_num_abs[15]) ? 8'd15 : exp_wire_49;
    assign exp_wire_49 = (in_num_abs[14]) ? 8'd14 : exp_wire_50;
    assign exp_wire_50 = (in_num_abs[13]) ? 8'd13 : exp_wire_51;
    assign exp_wire_51 = (in_num_abs[12]) ? 8'd12 : exp_wire_52;
    assign exp_wire_52 = (in_num_abs[11]) ? 8'd11 : exp_wire_53;
    assign exp_wire_53 = (in_num_abs[10]) ? 8'd10 : exp_wire_54;
    assign exp_wire_54 = (in_num_abs[9]) ? 8'd9 : exp_wire_55;
    assign exp_wire_55 = (in_num_abs[8]) ? 8'd8 : exp_wire_56;
    assign exp_wire_56 = (in_num_abs[7]) ? 8'd7 : exp_wire_57;
    assign exp_wire_57 = (in_num_abs[6]) ? 8'd6 : exp_wire_58;
    assign exp_wire_58 = (in_num_abs[5]) ? 8'd5 : exp_wire_59;
    assign exp_wire_59 = (in_num_abs[4]) ? 8'd4 : exp_wire_60;
    assign exp_wire_60 = (in_num_abs[3]) ? 8'd3 : exp_wire_61;
    assign exp_wire_61 = (in_num_abs[2]) ? 8'd2 : exp_wire_62;
    assign exp_wire_62 = (in_num_abs[1]) ? 8'd1 : 8'd0;

    assign exp_result = (in_fmt[1]) ? exp : exp_wire_32;
    assign mant_result = (in_fmt[1]) ? mant : mant_wire_32;

    assign out_data = {sign, (exp_result + 8'd127), mant_result};

endmodule