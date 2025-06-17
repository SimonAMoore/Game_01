; Initialise 6845 registers for vertical rupture
.rupture_init
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

    ; Set T1 Timer. Start just before end of last line
    ; Repeat every 8 scanlines
    lda #LO(SYS_VIA_T1_SET_TIME) : sta SYS_VIA_R4_T1C_L
    lda #HI(SYS_VIA_T1_SET_TIME) : sta SYS_VIA_R5_T1C_H
    lda #LO(H_Refresh * 8 - 2) : sta SYS_VIA_R6_T1L_L
    lda #HI(H_Refresh * 8 - 2) : sta SYS_VIA_R7_T1L_H

    ; Reset rupture counter
    lda #&00
    sta RUPTURE_COUNTER

    ; Reset frame counter
    lda #&00
    sta FRAME_COUNTER

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
    ; Set screen start address for next region
    ;lda #&0c : sta CRTC_REG
    ;lda #SCR_HI : sta CRTC_DATA

    clc
    lda RUPTURE_COUNTER     ; load rupture counter
    adc FRAME_COUNTER       ; add frame counter
    tax                     ; transfer to x index
    lda &1800, x            ; load offset from sine table
    tax
    lda #&0d : sta CRTC_REG
    txa : sta CRTC_DATA

    ; Set number of character lines - 1
    ; for current region
    lda #&04 : sta CRTC_REG
    lda #&00 : sta CRTC_DATA

    ; Set number of visible character lines
    lda #&06 : sta CRTC_REG
    lda #&01 : sta CRTC_DATA

    ; Increase rupture counter
    inc RUPTURE_COUNTER

.exit
    rts
}

; 6845 CRTC Rupture settings for region R1 [Lines 12 - 23]
; Screen address: &6a00 + scroll offset
;
; 12 character lines
; 96 scanlines
; 
; last rupture section - vsync
; vertical blanking
; 15 character lines
; 120 scanlines
;
.rupture_R1
{
    ; Set screen start address for next region
    ;lda #&0c : sta CRTC_REG
    ;lda #SCR_HI : sta CRTC_DATA

    ;lda #&0d : sta CRTC_REG
    ;lda #SCR_LO : sta CRTC_DATA

    ; Reset rupture counter
    lda #&00
    sta RUPTURE_COUNTER

    clc
    lda RUPTURE_COUNTER     ; load rupture counter
    adc FRAME_COUNTER       ; add frame counter
    tax                     ; transfer to x index
    lda &1800, x            ; load offset from sine table
    tax
    lda #&0d : sta CRTC_REG
    txa : sta CRTC_DATA

    ; Increase frame counter
    inc FRAME_COUNTER

    ; Set number of character lines
    lda #&04 : sta CRTC_REG
    lda #&0f : sta CRTC_DATA

.exit
    rts
}

; Total Timing Values:
;
;                       R0      R1    VBlank      Total
; -------------------------------------------------------
;   Character lines:    12      12      15          39
;         Scanlines:    96      96     120         312
; -------------------------------------------------------
