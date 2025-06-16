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

    ; T1 Timer values set in bbc.asm
    lda #LO(SYS_VIA_T1_SET_TIME) : sta SYS_VIA_R4_T1C_L
    lda #HI(SYS_VIA_T1_SET_TIME) : sta SYS_VIA_R5_T1C_H
    lda #LO(SYS_VIA_T1_LATCH_TIME) : sta SYS_VIA_R6_T1L_L
    lda #HI(SYS_VIA_T1_LATCH_TIME) : sta SYS_VIA_R7_T1L_H

.exit
    rts
}