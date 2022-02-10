// Bits logical/arithmetic left/right shifter
module Shift(in_numA, in_numB, in_ctrl, out_LeftShift, out_RightShift);
    parameter DATA_WIDTH = 64;

    input   in_ctrl;    // Control logical or arithmetic right shift
    input   [DATA_WIDTH - 1:0] in_numA, in_numB;

    output reg signed [DATA_WIDTH - 1:0] out_LeftShift, out_RightShift;

    always @ (*) begin
        out_LeftShift = in_numA << in_numB[5:0];
        if (!in_ctrl) out_RightShift = in_numA >> in_numB[5:0];
        else begin
            case (in_numB[5:0])
            6'd0: out_RightShift = in_numA;
            6'd1: out_RightShift = {{1{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 1]};
            6'd2: out_RightShift = {{2{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 2]};
            6'd3: out_RightShift = {{3{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 3]};
            6'd4: out_RightShift = {{4{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 4]};
            6'd5: out_RightShift = {{5{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 5]};
            6'd6: out_RightShift = {{6{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 6]};
            6'd7: out_RightShift = {{7{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 7]};
            6'd8: out_RightShift = {{8{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 8]};
            6'd9: out_RightShift = {{9{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 9]};
            6'd10: out_RightShift = {{10{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 10]};
            6'd11: out_RightShift = {{11{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 11]};
            6'd12: out_RightShift = {{12{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 12]};
            6'd13: out_RightShift = {{13{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 13]};
            6'd14: out_RightShift = {{14{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 14]};
            6'd15: out_RightShift = {{15{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 15]};
            6'd16: out_RightShift = {{16{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 16]};
            6'd17: out_RightShift = {{17{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 17]};
            6'd18: out_RightShift = {{18{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 18]};
            6'd19: out_RightShift = {{19{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 19]};
            6'd20: out_RightShift = {{20{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 20]};
            6'd21: out_RightShift = {{21{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 21]};
            6'd22: out_RightShift = {{22{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 22]};
            6'd23: out_RightShift = {{23{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 23]};
            6'd24: out_RightShift = {{24{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 24]};
            6'd25: out_RightShift = {{25{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 25]};
            6'd26: out_RightShift = {{26{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 26]};
            6'd27: out_RightShift = {{27{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 27]};
            6'd28: out_RightShift = {{28{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 28]};
            6'd29: out_RightShift = {{29{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 29]};
            6'd30: out_RightShift = {{30{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 30]};
            6'd31: out_RightShift = {{31{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 31]};
            6'd32: out_RightShift = {{32{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 32]};
            6'd33: out_RightShift = {{33{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 33]};
            6'd34: out_RightShift = {{34{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 34]};
            6'd35: out_RightShift = {{35{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 35]};
            6'd36: out_RightShift = {{36{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 36]};
            6'd37: out_RightShift = {{37{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 37]};
            6'd38: out_RightShift = {{38{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 38]};
            6'd39: out_RightShift = {{39{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 39]};
            6'd40: out_RightShift = {{40{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 40]};
            6'd41: out_RightShift = {{41{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 41]};
            6'd42: out_RightShift = {{42{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 42]};
            6'd43: out_RightShift = {{43{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 43]};
            6'd44: out_RightShift = {{44{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 44]};
            6'd45: out_RightShift = {{45{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 45]};
            6'd46: out_RightShift = {{46{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 46]};
            6'd47: out_RightShift = {{47{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 47]};
            6'd48: out_RightShift = {{48{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 48]};
            6'd49: out_RightShift = {{49{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 49]};
            6'd50: out_RightShift = {{50{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 50]};
            6'd51: out_RightShift = {{51{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 51]};
            6'd52: out_RightShift = {{52{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 52]};
            6'd53: out_RightShift = {{53{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 53]};
            6'd54: out_RightShift = {{54{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 54]};
            6'd55: out_RightShift = {{55{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 55]};
            6'd56: out_RightShift = {{56{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 56]};
            6'd57: out_RightShift = {{57{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 57]};
            6'd58: out_RightShift = {{58{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 58]};
            6'd59: out_RightShift = {{59{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 59]};
            6'd60: out_RightShift = {{60{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 60]};
            6'd61: out_RightShift = {{61{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 61]};
            6'd62: out_RightShift = {{62{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 62]};
            6'd63: out_RightShift = {{63{in_numA[DATA_WIDTH - 1]}}, in_numA[DATA_WIDTH - 1: 63]};
            endcase
        end
    end
endmodule