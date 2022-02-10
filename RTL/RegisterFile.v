module RegisterFile(data_in, data_outA, data_outB, addr_A, addr_B, writeAddr, write_En, Clk);

    parameter DATA_WIDTH = 64;
    parameter ADDR_WIDTH = 5;

    input   Clk, write_En;
    input   [ADDR_WIDTH - 1:0] addr_A, addr_B, writeAddr;
    input   [DATA_WIDTH - 1:0] data_in;

    output  [DATA_WIDTH - 1:0] data_outA, data_outB;

    reg [DATA_WIDTH - 1:0] registerFile [31:0];

    always @ (posedge Clk) begin
        if (writeAddr == 0) begin
            registerFile[writeAddr] <= 0;
        end else begin
            registerFile[writeAddr] <= (write_En) ? data_in : registerFile[writeAddr];
        end
    end

    assign data_outA = (addr_A == 5'd0) ? 64'd0 : registerFile[addr_A];
    assign data_outB = (addr_B == 5'd0) ? 64'd0 : registerFile[addr_B];
endmodule