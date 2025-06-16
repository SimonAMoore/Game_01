; Initialise 6845 registers for vertical rupture
.rupture_init
{
    ; Wait for vsync
    {
        lda #&02
    .wait
        bit SYS_VIA_R13_IFR
        beq wait
        sta SYS_VIA_R13_IFR
    }

    ; Set vsync position
    lda #&07 : sta CRTC_REG
    lda #&13 : sta CRTC_DATA

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

    ; Reset T1 interrupt flag
    lda #&40 : sta SYS_VIA_R13_IFR

    ; Reset rupture counter
    lda #&00
    sta RUPTURE_COUNTER

.exit
    rts
}

; 6845 CRTC Rupture settings for region R0 [Lines 0 - 11]
; Screen address: &5000 - fixed address
;
; 12 character lines
; 96 scanlines
; no-vsync
;
.rupture_R0
{
    ; Set number of character lines
    ; for current region
    lda #&04 : sta CRTC_REG
    lda #&1A : sta CRTC_DATA

    lda #&06 : sta CRTC_REG
    lda #&0C : sta CRTC_DATA

    ; Set screen start address
    ; for next region
    lda #&0c : sta CRTC_REG
    lda #&0a : sta CRTC_DATA

    lda #&0d : sta CRTC_REG
    lda #&00 : sta CRTC_DATA

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
    ; Set number of character lines
    lda #&04 : sta CRTC_REG
    lda #&0B : sta CRTC_DATA

    ; Set screen start address
    lda #&0c : sta CRTC_REG
    lda #&0d : sta CRTC_DATA

    ldx &00
    lda #&0d : sta CRTC_REG
    lda &1800, x : sta CRTC_DATA

    ; Increase rupture counter
    inc RUPTURE_COUNTER

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
