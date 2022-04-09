module RegisterFile(in_data, out_data_A, out_data_B, in_addr_A, in_addr_B, in_writeAddr, in_write_En, in_Clk, in_Rst_N);
    integer i;

    parameter DATA_WIDTH = 64;
    parameter ADDR_WIDTH = 5;

    input   in_Clk, in_write_En, in_Rst_N;
    input   [ADDR_WIDTH - 1:0] in_addr_A, in_addr_B, in_writeAddr;
    input   [DATA_WIDTH - 1:0] in_data;

    output  [DATA_WIDTH - 1:0] out_data_A, out_data_B;

    reg [DATA_WIDTH - 1:0] registerFile [31:0];

    always @ (posedge in_Clk or negedge in_Rst_N) begin
        if (!in_Rst_N) begin
            for (i = 0; i < 32; i = i + 1) begin
                registerFile[i] <= 0;
            end
        end else begin
            if (in_writeAddr == 0) begin
                registerFile[in_writeAddr] <= 0;
            end else begin
                registerFile[in_writeAddr] <= (in_write_En) ? in_data : registerFile[in_writeAddr];
            end
        end
    end

    assign out_data_A = (in_addr_A == 5'd0) ? 64'd0 : registerFile[in_addr_A];
    assign out_data_B = (in_addr_B == 5'd0) ? 64'd0 : registerFile[in_addr_B];
endmodule