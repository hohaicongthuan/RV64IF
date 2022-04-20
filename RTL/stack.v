module stack(in_data, in_Clk, in_Rst_N, in_push, in_pop, out_data, out_full, out_empty);
    parameter   DATA_WIDTH  = 64;
    parameter   STACK_DEPTH = 16;
    parameter   SP_WIDTH    = 4;    // stack pointer width: 2^4 = 16

    integer     i;

    input   in_Clk, in_Rst_N, in_push, in_pop;
    input   [DATA_WIDTH - 1:0] in_data;

    output  out_empty, out_full;
    output  [DATA_WIDTH - 1:0] out_data;

    reg     [SP_WIDTH - 1:0] sp;
    reg     [DATA_WIDTH - 1:0] stack_mem [STACK_DEPTH - 1:0];

    // Internal wires

    assign  out_data = (sp != 0) ? stack_mem[sp - 1] : stack_mem[sp];
    assign  out_empty = (sp == 0) ? 1'b1 : 1'b0;
    assign  out_full = (sp == (STACK_DEPTH - 1)) ? 1'b1 : 1'b0;

    always @ (posedge in_Clk or negedge in_Rst_N) begin
        if (!in_Rst_N) begin
            sp <= 0;
            for (i = 0; i < STACK_DEPTH; i = i + 1) begin
                stack_mem[i] <= 0;
            end
        end else begin
            if (in_push & !out_full) begin
                stack_mem[sp] <= in_data;
                sp <= sp + 1;
            end else if (in_pop & !out_empty) begin
                stack_mem[sp] <= stack_mem[sp];
                sp <= sp - 1;
            end else begin
                stack_mem[sp] <= stack_mem[sp];
            end
        end
    end
endmodule