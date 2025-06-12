.init_scanline_timer
{
    ; Disable all interrupts and events 
    sei
    lda #&7f                ; 01111111b
    sta USER_VIA_R14_IER
    sta SYS_VIA_R14_IER

    ; Enable VSync and System Timer 1
    lda #&C2                ; 11000010b
    sta SYS_VIA_R14_IER

    ; Synchronize to exact VSync and initialise Timer 1
    lda #&02
    {
    .wait_vsync
        nop
        bit SYS_VIA_R13_IFR
        beq wait_vsync
        sta SYS_VIA_R13_IFR
    }

    nop : nop : nop 
    ldy #&08
    ldx #&00
    stx TEMP_1
        
.loop
    ldx #&00
    {
    .wait_vsync
        inx
        bit SYS_VIA_R13_IFR
        beq wait_vsync
        sta SYS_VIA_R13_IFR
    }
    cpx TEMP_1
    stx TEMP_1
    bcc skip
    dey
    bne loop
.skip

    Adjust = 8                                 ; Adjustment for timer to trigger just before horizontal blanking
    H_Refresh = 64                             ; Horizontal refresh period in microseconds
    V_Refresh = 20000 - 32 - 2                 ; Vertical refresh period in microseconds (-2us T1 load, -32us half scanline)
    Scanline = (8 + 13) * 8 - 3                ; Calculate scanline to trigger timer on
    Setup_Time = Scanline * H_Refresh + Adjust ; Initial time needed for timer to sync with vertical refresh

    lda #LO(Setup_Time) : sta SYS_VIA_R4_T1C_L
    lda #HI(Setup_Time) : sta SYS_VIA_R5_T1C_H
    lda #LO(V_Refresh) : sta SYS_VIA_R6_T1L_L
    lda #HI(V_Refresh) : sta SYS_VIA_R7_T1L_H

.exit
    rts
}