; Initialise 6845 registers for vertical rupture
.rupture_init
{
    ; Disable all interrupts and events 
    sei
    lda #&7f                ; 01111111b
    sta USER_VIA_R14_IER
    sta SYS_VIA_R14_IER

    ; Enable VSync and System Timer 1
    lda #&c2                ; 11000010b
    sta SYS_VIA_R14_IER

    ; Reset rupture counter
    lda #&00
    sta RUPTURE_COUNTER

    ; Reset frame counter
    lda #&00
    sta FRAME_COUNTER

    ; Initialise screen address table for R12 & R13 for each line 0-23
    ldy #23
.loop_1
    clc
    ldx #&00
    stx TEMP_X
    lda background_y_addr_offset, y
    ror a
    ror TEMP_X
    ror a
    ror TEMP_X
    ror a
    ror TEMP_X
    sta RUPTURE_ADDR_HI_TABLE, y
    ldx TEMP_X
    stx RUPTURE_ADDR_LO_TABLE, y
    dey
    bpl loop_1

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
        
.loop_2
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
    bne loop_2
.skip

    ; Set T1 Timer. Start just before end of last line
    ; Repeat every 8 scanlines
    lda #LO(SYS_VIA_T1_SET_TIME) : sta SYS_VIA_R4_T1C_L
    lda #HI(SYS_VIA_T1_SET_TIME) : sta SYS_VIA_R5_T1C_H
    lda #LO(SYS_VIA_T1_LATCH_TIME) : sta SYS_VIA_R6_T1L_L
    lda #HI(SYS_VIA_T1_LATCH_TIME) : sta SYS_VIA_R7_T1L_H

    ; Set vsync position
    lda #&07 : sta CRTC_REG
    lda #&08 : sta CRTC_DATA

    ; Set total and visible character lines
    lda #&04 : sta CRTC_REG
    lda #&26 : sta CRTC_DATA

    lda #&06 : sta CRTC_REG
    lda #&0C : sta CRTC_DATA

    ; Set screen start address
    lda #&0c : sta CRTC_REG
    lda #SCR_HI : sta CRTC_DATA

    lda #&0d : sta CRTC_REG
    lda #SCR_LO : sta CRTC_DATA

.exit
    rts
}

; 6845 CRTC Rupture settings for region R0
.rupture_R0
{
    ; Increase rupture counter
    inc RUPTURE_COUNTER

    ; Get rupture counter
    lda RUPTURE_COUNTER

    ; Set palette for current character line
    tax
    sec
    sbc #&01
    beq skip_0_COL_BLUE
    cmp #&0d
    bcs skip_0_COL_BLUE
    ULA_SET_PALETTE 0, COL_BLUE
    bcc skip_0_COL_BLACK
.skip_0_COL_BLUE
    ULA_SET_PALETTE 0, COL_BLACK
.skip_0_COL_BLACK

    ; Set screen start address for next region
    lda #&0d : sta CRTC_REG

    ; Check scroll flag
    lda background_scroll_table, x
    bne skip_no_scroll
    lda RUPTURE_ADDR_LO_TABLE, x
    sta CRTC_DATA
    jmp skip_scroll
.skip_no_scroll

    lda FRAME_COUNTER
    and #&3f
    adc RUPTURE_ADDR_LO_TABLE, x
    sta CRTC_DATA
.skip_scroll

    lda #&0c : sta CRTC_REG
    lda RUPTURE_ADDR_HI_TABLE, x
    sta CRTC_DATA

    ; Set number of character lines - 1
    ; for current region
    lda #&04 : sta CRTC_REG
    lda #&00 : sta CRTC_DATA

    ; Set number of visible character lines
    lda #&06 : sta CRTC_REG
    lda #&01 : sta CRTC_DATA

.exit
    rts
}

; 6845 CRTC Rupture settings for region R1
.rupture_R1
{
    ; Set screen start address for next region
    lda #&0d : sta CRTC_REG
    lda #SCR_LO : sta CRTC_DATA

    lda #&0c : sta CRTC_REG
    lda #SCR_HI : sta CRTC_DATA

    ; Reset rupture counter
    lda #&00
    sta RUPTURE_COUNTER

    ; Increase frame counter
    inc FRAME_COUNTER

    ; Set number of character lines
    lda #&04 : sta CRTC_REG
    lda #&0f : sta CRTC_DATA

.exit
    rts
}
