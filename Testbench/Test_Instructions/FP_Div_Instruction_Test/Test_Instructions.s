main:
    nop
    li t1, 0x414570A4               # t1 = 12.34
    li t2, 0x3F9DF3B6               # t2 = 1.234
    nop
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
    nop
    fdiv.s ft3, ft1, ft2            # ft3 = ft1 / ft2 = 12.34 / 1.234 = 10.0 (0x41200000)
    nop
    nop
    nop
    nop
    nop