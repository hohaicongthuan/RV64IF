// Data Memory used for testbench
`timescale 1ns/1ps
module DMem(in_data, in_addr, in_wr_en, in_exe_finished, out_data);
    parameter DATA_WIDTH = 64;
    parameter waittime = 20;

    integer file, i;

    input   in_wr_en, in_exe_finished;
    input   [DATA_WIDTH - 1:0] in_data, in_addr;
    
    output reg  [DATA_WIDTH - 1:0] out_data;

    reg     [7:0] Mem [1048576:0]; // 2^20

    initial begin
        file = $fopen("DMem_Content.txt", "w");

        while (!in_exe_finished) begin
            #waittime;
        end

        for (i = 0; i < 1048576; i = i + 8) begin
            $fdisplay(file, "%h", Mem[i], Mem[i + 1], Mem[i + 2], Mem[i + 3], Mem[i + 4], Mem[i + 5], Mem[i + 6], Mem[i + 7]);
        end

        $fclose(file);
    end

    always @ (*) begin
        if (in_wr_en) begin
            Mem[in_addr] = in_data[7:0];
            Mem[in_addr + 1] = in_data[15:8];
            Mem[in_addr + 2] = in_data[23:16];
            Mem[in_addr + 3] = in_data[31:24];
            Mem[in_addr + 4] = in_data[39:32];
            Mem[in_addr + 5] = in_data[47:40];
            Mem[in_addr + 6] = in_data[55:48];
            Mem[in_addr + 7] = in_data[63:56];
        end
        out_data = { Mem[in_addr + 7], Mem[in_addr + 6], Mem[in_addr + 5], Mem[in_addr + 4], Mem[in_addr + 3], Mem[in_addr + 2], Mem[in_addr + 1], Mem[in_addr] };
    end
endmodule