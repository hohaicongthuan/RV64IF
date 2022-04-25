main:
    nop
    addi    ra, x0, 0
    addi    t0, x0, 0
    jal     ADDI_Inst
    jal     SLTI_Inst
    jal     ANDI_Inst
    jal     ORI_Inst
    jal     XORI_Inst
    jal     SLTIU_Inst
    jal     SLLI_Inst
    jal     SRLI_Inst
    jal     SRAI_Inst
    jal     ADD_Inst
    jal     SLT_Inst
    jal     SLTU_Inst
    jal     AND_Inst
    jal     OR_Inst
    jal     XOR_Inst
    jal     SLL_Inst
    jal     SRL_Inst
    jal     SRA_Inst
    jal     FMIN_S_Inst
    jal     FMAX_S_Inst
    jal     FP_Test

ADDI_Inst:
    addi    t1, x0, 1
    nop
    nop
    nop
    nop
    addi    t2, t1, 2
    ret
    
SLTI_Inst:
    addi    t1, x0, 1
    nop
    nop
    nop
    nop
    slti    t2, t1, 2   # 1 < 2 -> 1
    ret

ANDI_Inst:
    addi    t1, x0, 123
    nop
    nop
    nop
    nop
    andi    t2, t1, 456 # 123 AND 456 = 72
    ret

ORI_Inst:
    addi    t1, x0, 123
    nop
    nop
    nop
    nop
    ori     t2, t1, 456 # 123 OR 456 = 507
    ret

XORI_Inst:
    addi    t1, x0, 123
    nop
    nop
    nop
    nop
    xori    t2, t1, 456 # 123 XOR 456 = 435
    ret

SLTIU_Inst:
    addi    t1, x0, 1
    nop
    nop
    nop
    nop
    sltiu    t2, t1, 2   # 1 < 2 -> 1
    ret

SLLI_Inst:
    addi    t1, x0, 1
    nop
    nop
    nop
    nop
    slli    t2, t1, 2   # 1 << 2 = 4
    ret

SRLI_Inst:
    addi    t1, x0, 8
    nop
    nop
    nop
    nop
    srli    t2, t1, 3   # 8 >> 3 = 1
    ret

SRAI_Inst:
    addi    t1, x0, -8
    nop
    nop
    nop
    nop
    srai    t2, t1, 3   # -8 >>> 3 = -1
    ret

ADD_Inst:
    addi    t1, x0, 1
    addi    t2, x0, 1
    nop
    nop
    nop
    nop
    add     t3, t1, t2  # 1 + 1 = 2
    ret

SLT_Inst:
    addi    t1, x0, 1
    addi    t2, x0, 2
    nop
    nop
    nop
    nop
    slt     t3, t1, t2  # 1 < 2 -> 1
    ret

SLTU_Inst:
    addi    t1, x0, 1
    addi    t2, x0, 2
    nop
    nop
    nop
    nop
    sltu    t3, t1, t2  # 1 < 2 -> 1
    ret

AND_Inst:
    addi    t1, x0, 123
    addi    t2, x0, 456
    nop
    nop
    nop
    nop
    and     t3, t1, t2  # 123 AND 456 = 72
    ret

OR_Inst:
    addi    t1, x0, 123
    addi    t2, x0, 456
    nop
    nop
    nop
    nop
    or      t3, t1, t2  # 123 OR 456 = 507
    ret

XOR_Inst:
    addi    t1, x0, 123
    addi    t2, x0, 456
    nop
    nop
    nop
    nop
    xor     t3, t1, t2  # 123 XOR 456 = 435
    ret

SLL_Inst:
    addi    t1, x0, 1
    addi    t2, x0, 2
    nop
    nop
    nop
    nop
    sll     t3, t1, t2  # 1 << 2 = 4
    ret

SRL_Inst:
    addi    t1, x0, 8
    addi    t2, x0, 3
    nop
    nop
    nop
    nop
    srl     t3, t1, t2  # 8 >> 3 = 1
    ret

SRA_Inst:
    addi    t1, x0, -8
    addi    t2, x0, 3
    nop
    nop
    nop
    nop
    sll     t3, t1, t2  # -8 >>> 3 = -1
    ret

FMIN_S_Inst:
    li      t1, 0x3F800000  # number 1 in 32-bit floating-point format
    li      t2, 0x40000000  # number 2 in 32-bit floating-point format
    nop
    nop
    nop
    nop
    fmv.w.x ft1, t1
    fmv.w.x ft2, t2
    nop
    nop
    nop
    nop
    fmin.s  ft3, ft1, ft2     # min(1, 2) -> 1
    ret

FMAX_S_Inst:
    li      t1, 0x3F800000  # number 1 in 32-bit floating-point format
    li      t2, 0x40000000  # number 2 in 32-bit floating-point format
    nop
    nop
    nop
    nop
    fmv.w.x ft1, t1
    fmv.w.x ft2, t2
    nop
    nop
    nop
    nop
    fmax.s  ft3, ft1, ft2     # max(1, 2) -> 2
    ret

FP_Test:
    lw      t1, 0(t0)       # number A
    lw      t2, 4(t0)       # number B
    lw      t3, 8(t0)       # addition expected result
    lw      t4, 12(t0)      # subtraction expected result
    lw      t5, 16(t0)      # multiplication expected result
    lw      t6, 20(t0)      # division expected result
    fmv.w.x ft1, t1
    fmv.w.x ft2, t2
    nop
    nop
    nop
    fadd.s  ft3, ft1, ft2
    fsub.s  ft4, ft1, ft2
    fmul.s  ft5, ft1, ft2
    fdiv.s  ft6, ft1, ft2
    nop
    fmv.x.w s1, ft3
    fmv.x.w s2, ft4
    fmv.x.w s3, ft5
    fmv.x.w s4, ft6
    nop
    sub     s0, s1, t3
    nop
    nop
    nop
    nop
    sltiu   s0, s0, 1       # equivalent to SET IF EQUAL ZERO (SEQZ)
    sub     s0, s2, t4
    nop
    nop
    nop
    nop
    sltiu   s0, s0, 1
    sub     s0, s3, t5
    nop
    nop
    nop
    nop
    sltiu   s0, s0, 1
    sub     s0, s4, t6
    nop
    nop
    nop
    nop
    sltiu   s0, s0, 1

    addi    t0, t0, 24
    j       FP_Test         # Intentional infinite loop here