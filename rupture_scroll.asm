; 6845 CRTC Rupture settings for region R0 [Line 0 - 11]
; Screen address: &5000 - fixed address
;
; 12 character lines
; 96 scanlines
; no-vsync
;
.rupture_R0
{
    ; Set number of character lines
    ; Set screen address
    ; Set vsync position to off screen

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
    ; Set screen address
    ; Set vsync position
        
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
