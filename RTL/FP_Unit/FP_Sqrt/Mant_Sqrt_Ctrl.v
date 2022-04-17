module Mant_Sqrt_Ctrl(in_Clk, in_Rst_N, in_start, in_stall, out_stall, out_load, out_div_start);
    input   in_Clk, in_Rst_N, in_start, in_stall;
    output  out_stall, out_load, out_div_start;

    reg     [3:0] State_Reg;    // State register

    // Next-state Logics
    always @ (posedge in_Clk or negedge in_Rst_N) begin
        if (!in_Rst_N) begin
            State_Reg <= 0;
        end else begin
            if (!in_stall) begin
                case (State_Reg)
                    4'd0: State_Reg <= (in_start) ? 4'd1 : 4'd0;
                    4'd1: State_Reg <= 4'd2;
                    4'd2: State_Reg <= 4'd3;
                    4'd3: State_Reg <= 4'd4;
                    4'd4: State_Reg <= 4'd5;
                    4'd5: State_Reg <= 4'd6;
                    4'd6: State_Reg <= 4'd7;
                    4'd7: State_Reg <= 4'd8;
                    4'd8: State_Reg <= 4'd9;
                    4'd9: State_Reg <= 4'd10;
                    4'd10: State_Reg <= 4'd11;
                    4'd11: State_Reg <= 4'd0;
                    default: State_Reg <= 4'd0;
                endcase
            end else State_Reg <= State_Reg;
        end
    end

    // Output logics
    assign out_load       = (State_Reg == 4'd1) ? 1'b1 : 1'b0;
    assign out_stall      = (State_Reg < 4'd11 & in_start) ? 1'b1 : 1'b0;
    assign out_div_start  = (State_Reg < 4'd11 & in_start) ? 1'b1 : 1'b0;
endmodule