;===============================================================================

SHEILA = &FE00
OSRDCH = &FFE0
OSWRCH = &FFEE
OSBYTE = &FFF4

;===============================================================================

CRTC_REG  = SHEILA + &00
CRTC_DATA = SHEILA + &01

VIDEO_ULA_CONTROL_REG = SHEILA + &20
VIDEO_ULA_PALETTE_REG = SHEILA + &21

;===============================================================================

SYS_VIA             = SHEILA + &40
USER_VIA            = SHEILA + &60

SYS_VIA_R0_ORB_IRB  = SYS_VIA + &00
SYS_VIA_R1_ORA_IRA  = SYS_VIA + &01
SYS_VIA_R2_DDRB     = SYS_VIA + &02
SYS_VIA_R3_DDRA     = SYS_VIA + &03
SYS_VIA_R4_T1C_L    = SYS_VIA + &04
SYS_VIA_R5_T1C_H    = SYS_VIA + &05
SYS_VIA_R6_T1L_L    = SYS_VIA + &06
SYS_VIA_R7_T1L_H    = SYS_VIA + &07
SYS_VIA_R8_T2C_L    = SYS_VIA + &08
SYS_VIA_R9_T2C_H    = SYS_VIA + &09
SYS_VIA_R10_SR      = SYS_VIA + &0A
SYS_VIA_R11_ACR     = SYS_VIA + &0B
SYS_VIA_R12_PCR     = SYS_VIA + &0C
SYS_VIA_R13_IFR     = SYS_VIA + &0D
SYS_VIA_R14_IER     = SYS_VIA + &0E
SYS_VIA_R15_ORA_IRA = SYS_VIA + &0F

USER_VIA_R0_ORB_IRB  = USER_VIA + &00
USER_VIA_R1_ORA_IRA  = USER_VIA + &01
USER_VIA_R2_DDRB     = USER_VIA + &02
USER_VIA_R3_DDRA     = USER_VIA + &03
USER_VIA_R4_T1C_L    = USER_VIA + &04
USER_VIA_R5_T1C_H    = USER_VIA + &05
USER_VIA_R6_T1L_L    = USER_VIA + &06
USER_VIA_R7_T1L_H    = USER_VIA + &07
USER_VIA_R8_T2C_L    = USER_VIA + &08
USER_VIA_R9_T2C_H    = USER_VIA + &09
USER_VIA_R10_SR      = USER_VIA + &0A
USER_VIA_R11_ACR     = USER_VIA + &0B
USER_VIA_R12_PCR     = USER_VIA + &0C
USER_VIA_R13_IFR     = USER_VIA + &0D
USER_VIA_R14_IER     = USER_VIA + &0E
USER_VIA_R15_ORA_IRA = USER_VIA + &0F

;===============================================================================

IRQ_1 = &204
IRQ_2 = &206

;===============================================================================

SCREEN_ADDR = &3000

SCR_LO = LO(SCREEN_ADDR DIV 8)
SCR_HI = HI(SCREEN_ADDR DIV 8)

GRAPHICS_MODE = 1

IF GRAPHICS_MODE = 1 OR GRAPHICS_MODE = 5
    MACRO ULA_SET_PALETTE logical, actual
        IF logical = 0
            lda #&00 + (actual EOR 7) : sta VIDEO_ULA_PALETTE_REG
        ENDIF
        IF logical = 1
            lda #&20 + (actual EOR 7) : sta VIDEO_ULA_PALETTE_REG
        ENDIF
        IF logical = 2
            lda #&80 + (actual EOR 7) : sta VIDEO_ULA_PALETTE_REG
        ENDIF
        IF logical = 3
            lda #&A0 + (actual EOR 7) : sta VIDEO_ULA_PALETTE_REG
        ENDIF
        eor #&10 : sta VIDEO_ULA_PALETTE_REG
        eor #&50 : sta VIDEO_ULA_PALETTE_REG
        eor #&10 : sta VIDEO_ULA_PALETTE_REG
ENDMACRO
ENDIF

IF GRAPHICS_MODE = 2
    MACRO ULA_SET_PALETTE logical, actual
        lda (logical * &100) + (actual EOR 7) : sta VIDEO_ULA_PALETTE_REG
ENDMACRO
ENDIF

COL_BLACK   = 0
COL_RED     = 1
COL_GREEN   = 2
COL_YELLOW  = 3
COL_BLUE    = 4
COL_MAGENTA = 5
COL_CYAN    = 6
COL_WHITE   = 7

;===============================================================================

Line      = 0                                           ; Character line for T1 to trigger just before
Adjust    = 8                                           ; Adjustment for timer to trigger just before horizontal blanking
H_Refresh = 64                                          ; Horizontal refresh period in microseconds
V_Refresh = 20000 - 32                                  ; Vertical refresh period in microseconds (-32us half scanline for non-interlaced mode)
Scanline  = (8 + Line) * 8 - 3                          ; Calculate scanline to trigger timer on (-3 VSync occurs on 2nd scanline of character line)

SYS_VIA_T1_SET_TIME   = Scanline * H_Refresh + Adjust   ; Initial time needed for timer to sync with vertical refresh
SYS_VIA_T1_LATCH_TIME = V_Refresh - 2                   ; T1 Latch Time (-2us for timer load)

DISPLAY_REFRESH = 1000000 / V_Refresh                   ; Calculate display refresh rate (Hz)

;===============================================================================

MACRO TABLE_ALIGNED
    IF HI(start) <> HI(end)
        ERROR "Table ", ~start, ": ", ~end, "crosses page boundary"
    ENDIF
    PRINT "Table ", ~start, ": ", ~end, "aligned within page boundary"
ENDMACRO

;===============================================================================
