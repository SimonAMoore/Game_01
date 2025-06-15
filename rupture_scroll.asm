; 6845 CRTC Rupture settings for region R0 [Line 0 - 11]
; Screen address: &5000 - fixed address
;
; 12 character lines
; 96 scanlines
; no-vsync
;
.rupture_R0
{
    ; Set vsync position to off screen
    lda #&07
    sta CRTC_REG
    lda #&13
    sta CRTC_DATA

    ; Set number of character lines
    lda #&04
    sta CRTC_REG
    lda #&1A
    sta CRTC_DATA

    lda #&06
    sta CRTC_REG
    lda #&0C
    sta CRTC_DATA

    ; Set screen start address
    lda #&0c
    sta CRTC_REG
    lda #&0a
    sta CRTC_DATA
    lda #&0d
    sta CRTC_REG
    lda #&00
    sta CRTC_DATA

.exit
    rts
}

; 6845 CRTC Rupture settings for region R1 [Line 12 - 23]
; Screen address: &6a00 + scroll offset
;
; 12 character lines
; 96 scanlines
; 
; last rupture section - vsync
; vertical blanking
;
; 15 character lines
; 120 scanlines
;
.rupture_R1
{
    ; Set number of character lines
    lda #&04
    sta CRTC_REG
    lda #&0B
    sta CRTC_DATA

    ; Set screen start address
    lda #&0c
    sta CRTC_REG
    lda #&0d
    sta CRTC_DATA
    lda #&0d
    sta CRTC_REG
    ldx &00
    lda &1800, x
    sta CRTC_DATA

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
