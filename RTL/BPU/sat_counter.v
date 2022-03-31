// Saturating Counter

module sat_counter(in_data, out_prediction, in_Clk, in_Rst_N);
    input   in_data, in_Clk, in_Rst_N;
    output  out_prediction;

    reg [1:0] counter;

    always @ (posedge in_Clk or negedge in_Rst_N) begin
        if (!in_Rst_N) begin
            counter <= 2'd0;
        end else begin
            case (counter)
                2'b00: counter <= (in_data) ? counter + 2'd1 : counter;        // Strongly not taken
                2'b01: counter <= (in_data) ? counter + 2'd1 : counter - 2'd1; // Weakly not taken
                2'b10: counter <= (in_data) ? counter + 2'd1 : counter - 2'd1; // Weakly taken
                2'b11: counter <= (in_data) ? counter        : counter - 2'd1; // Strongly taken
            endcase
        end
    end

    assign out_prediction = ((counter[1] & counter [0]) | (counter[1] & !counter [0])) ? 1'b1 : 1'b0;
endmodule