// Controller for the mantissa divider in the 32-bit floating-point divider (FP_Div.v)
// This is a Finite State Machine with 26 states

module Mant_Div_Ctrl(in_Clk, in_start, in_Rst_N, out_load, out_shift_en, out_stall);
    input   in_Clk, in_start, in_Rst_N;
    output  out_load, out_shift_en, out_stall;

    reg     [4:0] State_Reg;    // State register

    // Next-state Logics
    always @ (posedge in_Clk or negedge in_Rst_N) begin
        if (!in_Rst_N) begin
            State_Reg <= 0;
        end else begin
            case (State_Reg)
                5'd0: State_Reg <= (in_start) ? 5'd1 : 5'd0;
                5'd1: State_Reg <= 5'd2;
                5'd2: State_Reg <= 5'd3;
                5'd3: State_Reg <= 5'd4;
                5'd4: State_Reg <= 5'd5;
                5'd5: State_Reg <= 5'd6;
                5'd6: State_Reg <= 5'd7;
                5'd7: State_Reg <= 5'd8;
                5'd8: State_Reg <= 5'd9;
                5'd9: State_Reg <= 5'd10;
                5'd10: State_Reg <= 5'd11;
                5'd11: State_Reg <= 5'd12;
                5'd12: State_Reg <= 5'd13;
                5'd13: State_Reg <= 5'd14;
                5'd14: State_Reg <= 5'd15;
                5'd15: State_Reg <= 5'd16;
                5'd16: State_Reg <= 5'd17;
                5'd17: State_Reg <= 5'd18;
                5'd18: State_Reg <= 5'd19;
                5'd19: State_Reg <= 5'd20;
                5'd20: State_Reg <= 5'd21;
                5'd21: State_Reg <= 5'd22;
                5'd22: State_Reg <= 5'd23;
                5'd23: State_Reg <= 5'd24;
                5'd24: State_Reg <= 5'd25;
                5'd25: State_Reg <= 5'd0;   // Idle state
                default: State_Reg <= 5'd0;
            endcase
        end
    end

    // Output logics
    assign out_load     = (State_Reg == 5'd1) ? 1'b1 : 1'b0;
    assign out_shift_en = (State_Reg == 5'd0 | State_Reg == 5'd25) ? 1'b0 : 1'b1;
    assign out_stall    = (State_Reg < 5'd25 & in_start) ? 1'b1 : 1'b0;
endmodule