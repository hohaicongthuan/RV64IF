// Instruction Memory module used for testbench

module IMem(out_inst, in_inst_addr, done_load_inst);
    input   [63:0] in_inst_addr;
    output  reg  done_load_inst;
    output  [31:0] out_inst;

    integer Inst_File, i;

    reg [7:0] Inst_Mem [1048576:0]; // 2^20
    reg [31:0] Inst;

    initial begin
        i = 0;
        done_load_inst = 1'b0;
        Inst_File = $fopen("Test_Instructions.txt", "r");
        while (! $feof(Inst_File)) begin
            $fscanf(Inst_File, "%h\n", Inst);

            Inst_Mem[i] = Inst[31:24];
            Inst_Mem[i + 1] = Inst[23:16];
            Inst_Mem[i + 2] = Inst[15:8];
            Inst_Mem[i + 3] = Inst[7:0];
            
            i = i + 4;
        end
        done_load_inst = 1'b1;
        $fclose(Inst_File);
    end

    assign out_inst = {Inst_Mem[in_inst_addr], Inst_Mem[in_inst_addr + 1], Inst_Mem[in_inst_addr + 2], Inst_Mem[in_inst_addr + 3]};
endmodule