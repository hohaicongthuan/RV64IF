module ControlUnit(in_inst, in_flag, out_ctrl_signal);
    // Operation codes (Opcodes)
    parameter [6:0] OP      = 7'b0110011; parameter [6:0] OP_IMM      = 7'b0010011;
    parameter [6:0] LUI_Op  = 7'b0110111; parameter [6:0] AUIPC_Op    = 7'b0010111;
    parameter [6:0] JAL_Op  = 7'b1101111; parameter [6:0] JALR_Op     = 7'b1100111;
    parameter [6:0] BRANCH  = 7'b1100011; parameter [6:0] OP_IMM_32   = 7'b0011011;
    parameter [6:0] LOAD    = 7'b0000011; parameter [6:0] STORE       = 7'b0100011;
    parameter [6:0] LOAD_FP = 7'b0000111; parameter [6:0] STORE_FP    = 7'b0100111;
    parameter [6:0] OP_FP   = 7'b1010011; parameter [6:0] OP_32       = 7'b0111011;

    // Functions/Instructions Control Signals
    parameter ADDI          = 23'b01000100000010000000000; parameter SLTI       = 23'b01000100000010010000000;
    parameter ANDI          = 23'b01000100000010000100000; parameter ORI        = 23'b01000100000010001000000;
    parameter XORI          = 23'b01000100000010001100000; parameter SLTIU      = 23'b01000100000010010100000;
    parameter SLLI          = 23'b01000100000010011000000; parameter SRLI       = 23'b01000100000010011100000;
    parameter SRAI          = 23'b01000100000010011100000; parameter LUI        = 23'b01000100010010100000000;
    parameter AUIPC         = 23'b10000100010000000000000; parameter ADD        = 23'b01000100100000000000000;
    parameter SLT           = 23'b01000100100000010000000; parameter SLTU       = 23'b01000100100000010100000;
    parameter AND           = 23'b01000100100000000100000; parameter OR         = 23'b01000100100000001000000;
    parameter XOR           = 23'b01000100100000001100000; parameter SLL        = 23'b01000100100000011000000;
    parameter SRL           = 23'b01000100100000011100000; parameter SUB        = 23'b01000100100000101000000;
    parameter SRA           = 23'b01000100100000011100000; parameter JAL        = 23'b00100100110100000000000;
    parameter JALR          = 23'b00100100001010000000000; parameter BEQ_TAKEN  = 23'b00000001000100010000000;
    parameter BEQ_UNTAKEN   = 23'b00000001000000010000000; parameter BNE_TAKEN  = 23'b00000001000100010000000;
    parameter BNE_UNTAKEN   = 23'b00000001000000010000000; parameter BLT_TAKEN  = 23'b00000001000100010000000;
    parameter BLT_UNTAKEN   = 23'b00000001000000010000000; parameter BLTU_TAKEN = 23'b00000001000100010100000;
    parameter BLTU_UNTAKEN  = 23'b00000001000000010100000; parameter BGE_TAKEN  = 23'b00000001000100010000000;
    parameter BGE_UNTAKEN   = 23'b00000001000000010000000; parameter BGEU_TAKEN = 23'b00000001000100010100000;
    parameter BGEU_UNTAKEN  = 23'b00000001000000010100000; parameter ADDIW      = 23'b01000100000010000000000;
    parameter SLLIW         = 23'b01000100000010011000000; parameter SRLIW      = 23'b01000100000010011100000;
    parameter SRAIW         = 23'b01000100000010011100000; parameter ADDW       = 23'b01000100000000000000000;
    parameter SLLW          = 23'b01000100000000011000000; parameter SRLW       = 23'b01000100000000011100000;
    parameter SUBW          = 23'b01000100000000101000000; parameter SRAW       = 23'b01000100000000011100000;
    parameter LB            = 23'b00000100000010000000000; parameter LH         = 23'b00000100000010000000000;
    parameter LW            = 23'b00000100000010000000000; parameter LD         = 23'b00000100000010000000000;
    parameter LBU           = 23'b00000100000010000000000; parameter LHU        = 23'b00000100000010000000000;
    parameter LWU           = 23'b00000100000010000000000; parameter SB         = 23'b00000001010010000000001;
    parameter SH            = 23'b00000001010010000000001; parameter SW         = 23'b00000001010010000000001;
    parameter SD            = 23'b00000001010010000000001; parameter FLW        = 23'b00000010000010000000000;
    parameter FSW           = 23'b00000001010011000000001; parameter FADD_S     = 23'b00010010100000000000000;
    parameter FSUB_S        = 23'b00010010100000000000000; parameter FMUL_S     = 23'b00010010100000000000010;
    parameter FDIV_S        = 23'b00010010100000000000100; parameter FMIN_S     = 23'b00010010100000000000110;
    parameter FMAX_S        = 23'b00010010100000000000110; parameter FCVT_W_S   = 23'b01100100100000000001100;
    parameter FCVT_S_W      = 23'b00001010100000100100000; parameter FCVT_L_S   = 23'b01100100100000000001100;
    parameter FCVT_S_L      = 23'b00001010100000100100000; parameter FSGNJ_S    = 23'b00010010100000000001010;
    parameter FSGNJN_S      = 23'b00010010100000000001010; parameter FSGNJX_S   = 23'b00010010100000000001010;
    parameter FEQ_S         = 23'b01100100100000000001000; parameter FLT_S      = 23'b01100100100000000001000;
    parameter FLE_S         = 23'b01100100100000000001000; parameter FMV_X_W    = 23'b01100100100000001001110;
    parameter FMV_W_X       = 23'b00001010100000000000000;
    
    input   [4:0] in_flag;
    input   [31:0] in_inst;

    output reg  [22:0] out_ctrl_signal;

    always @ (*) begin
        case (in_inst[6:0])
            OP: begin
                case (in_inst[14:12])
                    3'b000: out_ctrl_signal = (in_inst[30]) ? SUB : ADD;
                    3'b001: out_ctrl_signal = SLL;
                    3'b010: out_ctrl_signal = SLT;
                    3'b011: out_ctrl_signal = SLTU;
                    3'b100: out_ctrl_signal = XOR;
                    3'b101: out_ctrl_signal = (in_inst[30]) ? SRA : SRL;
                    3'b110: out_ctrl_signal = OR;
                    3'b111: out_ctrl_signal = AND;
                endcase
            end
            OP_IMM: begin
                case (in_inst[14:12])
                    3'b000: out_ctrl_signal = ADDI;
                    3'b001: out_ctrl_signal = SLLI;
                    3'b010: out_ctrl_signal = SLTI;
                    3'b011: out_ctrl_signal = SLTIU;
                    3'b100: out_ctrl_signal = XORI;
                    3'b101: out_ctrl_signal = (in_inst[30]) ? SRAI : SRLI;
                    3'b110: out_ctrl_signal = ORI;
                    3'b111: out_ctrl_signal = ANDI;
                endcase
            end
            LUI_Op: out_ctrl_signal = LUI;
            AUIPC_Op: out_ctrl_signal = AUIPC;
            JAL_Op: out_ctrl_signal = JAL;
            JALR_Op: out_ctrl_signal = JALR;
            BRANCH: begin
                case (in_inst[14:12])
                    3'b000: out_ctrl_signal = (in_flag[4]) ? BEQ_TAKEN : BEQ_UNTAKEN;
                    3'b001: out_ctrl_signal = (in_flag[4]) ? BNE_UNTAKEN : BNE_TAKEN;
                    3'b100: out_ctrl_signal = (in_flag[3]) ? BLT_TAKEN : BLT_UNTAKEN;
                    3'b101: out_ctrl_signal = (in_flag[1]) ? BGE_TAKEN : BGE_UNTAKEN;
                    3'b110: out_ctrl_signal = (in_flag[2]) ? BLTU_TAKEN : BLTU_UNTAKEN;
                    3'b111: out_ctrl_signal = (in_flag[0]) ? BGEU_TAKEN : BGEU_UNTAKEN;
                    default: out_ctrl_signal = 23'd0;
                endcase
            end
            OP_IMM_32: begin
                case (in_inst[14:12])
                    3'b000: out_ctrl_signal = ADDIW;
                    3'b001: out_ctrl_signal = SLLIW;
                    3'b101: out_ctrl_signal = (in_inst[30]) ? SRAIW : SRLIW;
                    default: out_ctrl_signal = 23'd0;
                endcase
            end
            OP_32: begin
                case (in_inst[14:12])
                    3'b000: out_ctrl_signal = (in_inst[30]) ? SUBW : ADDW;
                    3'b001: out_ctrl_signal = SLLW;
                    3'b101: out_ctrl_signal = (in_inst[30]) ? SRAW : SRLW;
                    default: out_ctrl_signal = 23'd0;
                endcase
            end
            LOAD: begin
                case (in_inst[14:12])
                    3'b000: out_ctrl_signal = LB;
                    3'b001: out_ctrl_signal = LH;
                    3'b010: out_ctrl_signal = LW;
                    3'b011: out_ctrl_signal = LD;
                    3'b100: out_ctrl_signal = LBU;
                    3'b101: out_ctrl_signal = LHU;
                    3'b110: out_ctrl_signal = LWU;
                    3'b111: out_ctrl_signal = 23'd0;
                endcase
            end
            STORE: begin
                case (in_inst[14:12])
                    3'b000: out_ctrl_signal = SB;
                    3'b001: out_ctrl_signal = SH;
                    3'b010: out_ctrl_signal = SW;
                    3'b011: out_ctrl_signal = SD;
                    default: out_ctrl_signal = 23'd0;
                endcase
            end
            LOAD_FP: begin out_ctrl_signal = FLW; end
            STORE_FP: begin out_ctrl_signal = FSW; end
            OP_FP: begin
                case (in_inst[31:25])
                    7'b0000000: out_ctrl_signal = FADD_S;
                    7'b0000100: out_ctrl_signal = FSUB_S;
                    7'b0001000: out_ctrl_signal = FMUL_S;
                    7'b0001100: out_ctrl_signal = FDIV_S;
                    7'b0010100: out_ctrl_signal = (in_inst[12]) ? FMAX_S : FMIN_S;
                    7'b1100000: out_ctrl_signal = (in_inst[21]) ? FCVT_L_S : FCVT_W_S;
                    7'b1101000: out_ctrl_signal = (in_inst[21]) ? FCVT_S_L : FCVT_S_W;
                    7'b0010000: begin
                        case (in_inst[14:12])
                            3'b000: out_ctrl_signal = FSGNJ_S;
                            3'b001: out_ctrl_signal = FSGNJN_S;
                            3'b010: out_ctrl_signal = FSGNJX_S;
                            default: out_ctrl_signal = 23'd0;
                        endcase
                    end
                    7'b1010000: begin
                        case (in_inst[14:12])
                            3'b000: out_ctrl_signal = FLE_S;
                            3'b001: out_ctrl_signal = FLT_S;
                            3'b010: out_ctrl_signal = FEQ_S;
                            default: out_ctrl_signal = 23'd0;
                        endcase
                    end
                    7'b1110000: out_ctrl_signal = FMV_X_W;
                    7'b1111000: out_ctrl_signal = FMV_W_X;
                    default: out_ctrl_signal = 23'd0;
                endcase
            end
            default: out_ctrl_signal = 23'd0;
        endcase
    end
endmodule