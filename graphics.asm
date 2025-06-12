;6845 register values for custom graphics mode 256 x 192 - 4 Colour (12 KBytes)
.graphics_mode_data
    equb    &7F         ; R0 - Horizontal Total = 127
    equb    &40         ; R1 - Horizontal Displayed = 64
    equb    &5A         ; R2 - Horizontal Sync Position = 90
    equb    &28         ; R3 - HSync Width & VSync Time = 40
    equb    &26         ; R4 - Vertical Total - 1 = 38
    equb    &00         ; R5 - Vertical Adjust = 0
    equb    &18         ; R6 - Vertical Displayed = 24
    equb    &1F         ; R7 - Vertical Sync Position = 31
    equb    &00         ; R8 - Interlace Mode = 0
    equb    &07         ; R9 - Scanlines per character - 1 = 7
    equb    &67         ; R10 - Cursor Start = 103
    equb    &08         ; R11 - Cursor End = 8
    equb    SCR_HI      ; R12 - Screen Address DIV 8 MSB
    equb    SCR_LO      ; R13 - Screen Address DIV 8 LSB

.palette_data
    equb    &07         ; %0000, 0.0 = 7 (Black = 0 EOR 7)
    equb    &17         ; %0001, 0.1 = 7
    equb    &47         ; %0100, 0.2 = 7
    equb    &57         ; %0101, 0.3 = 7
    equb    &25         ; %0010, 1.0 = 5 (Green = 2 EOR 7)
    equb    &35         ; %0011, 1.1 = 5
    equb    &65         ; %0110, 1.2 = 5
    equb    &75         ; %0111, 1.3 = 5
    equb    &84         ; %1000, 2.0 = 4 (Yellow = 3 EOR 7)
    equb    &94         ; %1001, 2.1 = 4
    equb    &C4         ; %1100, 2.2 = 4
    equb    &D4         ; %1101, 2.3 = 4
    equb    &A2         ; %1010, 3.0 = 2 (Magenta = 5 EOR 7)
    equb    &B2         ; %1011, 3.1 = 2
    equb    &E2         ; %1110, 3.2 = 2
    equb    &F2         ; %1111, 3.3 = 2

.init_graphics_mode
{
    ; Initialise 6845 CRTC
    sei
    ldy #&0D
.loop
    lda graphics_mode_data, y
    sty CRTC_REG
    sta CRTC_DATA
    dey
    bpl loop

    ; Initialise video ULA
    lda #&9A : ldx #&18 : jsr OSBYTE

    ; Initialise colour palette
    ldy #&0F
.loop2
    lda palette_data, y
    sta VIDEO_ULA_PALETTE_REG
    dey
    bpl loop2
    cli

.exit
    rts
}

.clear_screen
{
    lda #&00
    tay
.loop
    sta &5000,y
    sta &5100,y
    sta &5200,y
    sta &5300,y
    sta &5400,y
    sta &5500,y
    sta &5600,y
    sta &5700,y
    sta &5800,y
    sta &5900,y
    sta &5A00,y
    sta &5B00,y
    sta &5C00,y
    sta &5D00,y
    sta &5E00,y
    sta &5F00,y
    sta &6000,y
    sta &6100,y
    sta &6200,y
    sta &6300,y
    sta &6400,y
    sta &6500,y
    sta &6600,y
    sta &6700,y
    sta &6800,y
    sta &6900,y
    sta &6A00,y
    sta &6B00,y
    sta &6C00,y
    sta &6D00,y
    sta &6E00,y
    sta &6F00,y
    sta &7000,y
    sta &7100,y
    sta &7200,y
    sta &7300,y
    sta &7400,y
    sta &7500,y
    sta &7600,y
    sta &7700,y
    sta &7800,y
    sta &7900,y
    sta &7A00,y
    sta &7B00,y
    sta &7C00,y
    sta &7D00,y
    sta &7E00,y
    sta &7F00,y 
    iny
    beq exit
    jmp loop
.exit
    rts
}
