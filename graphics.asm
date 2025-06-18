;6845 register values for custom graphics mode 256 x 192 - 4 Colour (12 KBytes)
.graphics_mode_data
{
    .start
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
    .end
    TABLE_ALIGNED "graphics_mode_data"
}

.palette_data
{
    .start
    equb    &03         ; %0000, 0.0 = 3 (Blue = 4 EOR 7)
    equb    &13         ; %0001, 0.1 = 3
    equb    &43         ; %0100, 0.2 = 3
    equb    &53         ; %0101, 0.3 = 3
    equb    &25         ; %0010, 1.0 = 5 (Green = 2 EOR 7)
    equb    &35         ; %0011, 1.1 = 5
    equb    &65         ; %0110, 1.2 = 5
    equb    &75         ; %0111, 1.3 = 5
    equb    &86         ; %1000, 2.0 = 6 (Red = 1 EOR 7)
    equb    &96         ; %1001, 2.1 = 6
    equb    &C6         ; %1100, 2.2 = 6
    equb    &D6         ; %1101, 2.3 = 6
    equb    &A2         ; %1010, 3.0 = 2 (Magenta = 5 EOR 7)
    equb    &B2         ; %1011, 3.1 = 2
    equb    &E2         ; %1110, 3.2 = 2
    equb    &F2         ; %1111, 3.3 = 2
    .end
    TABLE_ALIGNED "palette_data"
}

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
.loop_2
    lda palette_data, y
    sta VIDEO_ULA_PALETTE_REG
    dey
    bpl loop_2
    cli

.exit
    rts
}

.clear_screen
{
    lda #&00
    tay
.loop
    sta SCREEN_ADDR + &0000,y
    sta SCREEN_ADDR + &0100,y
    sta SCREEN_ADDR + &0200,y
    sta SCREEN_ADDR + &0300,y
    sta SCREEN_ADDR + &0400,y
    sta SCREEN_ADDR + &0500,y
    sta SCREEN_ADDR + &0600,y
    sta SCREEN_ADDR + &0700,y
    sta SCREEN_ADDR + &0800,y
    sta SCREEN_ADDR + &0900,y
    sta SCREEN_ADDR + &0a00,y
    sta SCREEN_ADDR + &0b00,y
    sta SCREEN_ADDR + &0c00,y
    sta SCREEN_ADDR + &0d00,y
    sta SCREEN_ADDR + &0e00,y
    sta SCREEN_ADDR + &0f00,y
    sta SCREEN_ADDR + &1000,y
    sta SCREEN_ADDR + &1100,y
    sta SCREEN_ADDR + &1200,y
    sta SCREEN_ADDR + &1300,y
    sta SCREEN_ADDR + &1400,y
    sta SCREEN_ADDR + &1500,y
    sta SCREEN_ADDR + &1600,y
    sta SCREEN_ADDR + &1700,y
    sta SCREEN_ADDR + &1800,y
    sta SCREEN_ADDR + &1900,y
    sta SCREEN_ADDR + &1a00,y
    sta SCREEN_ADDR + &1b00,y
    sta SCREEN_ADDR + &1c00,y
    sta SCREEN_ADDR + &1d00,y
    sta SCREEN_ADDR + &1e00,y
    sta SCREEN_ADDR + &1f00,y
    sta SCREEN_ADDR + &2000,y
    sta SCREEN_ADDR + &2100,y
    sta SCREEN_ADDR + &2200,y
    sta SCREEN_ADDR + &2300,y
    sta SCREEN_ADDR + &2400,y
    sta SCREEN_ADDR + &2500,y
    sta SCREEN_ADDR + &2600,y
    sta SCREEN_ADDR + &2700,y
    sta SCREEN_ADDR + &2800,y
    sta SCREEN_ADDR + &2900,y
    sta SCREEN_ADDR + &2a00,y
    sta SCREEN_ADDR + &2b00,y
    sta SCREEN_ADDR + &2c00,y
    sta SCREEN_ADDR + &2d00,y
    sta SCREEN_ADDR + &2e00,y
    sta SCREEN_ADDR + &2f00,y 
    sta SCREEN_ADDR + &3000,y 
    sta SCREEN_ADDR + &3100,y 
    sta SCREEN_ADDR + &3200,y 
    sta SCREEN_ADDR + &3300,y 
    sta SCREEN_ADDR + &3400,y 
    sta SCREEN_ADDR + &3500,y 
    sta SCREEN_ADDR + &3600,y 
    sta SCREEN_ADDR + &3700,y 
    sta SCREEN_ADDR + &3800,y 
    sta SCREEN_ADDR + &3900,y 
    sta SCREEN_ADDR + &3a00,y 
    sta SCREEN_ADDR + &3b00,y 
    sta SCREEN_ADDR + &3c00,y 
    sta SCREEN_ADDR + &3d00,y 
    sta SCREEN_ADDR + &3e00,y 
    sta SCREEN_ADDR + &3f00,y 
    sta SCREEN_ADDR + &4000,y 
    sta SCREEN_ADDR + &4100,y 
    sta SCREEN_ADDR + &4200,y 
    sta SCREEN_ADDR + &4300,y 
    sta SCREEN_ADDR + &4400,y 
    sta SCREEN_ADDR + &4500,y 
    sta SCREEN_ADDR + &4600,y 
    sta SCREEN_ADDR + &4700,y 
    sta SCREEN_ADDR + &4800,y 
    sta SCREEN_ADDR + &4900,y 
    sta SCREEN_ADDR + &4a00,y 
    sta SCREEN_ADDR + &4b00,y 
    sta SCREEN_ADDR + &4c00,y 
    sta SCREEN_ADDR + &4d00,y 
    sta SCREEN_ADDR + &4e00,y 
    sta SCREEN_ADDR + &4f00,y 
    sta SCREEN_ADDR + &5000,y 
    sta SCREEN_ADDR + &5100,y 
    sta SCREEN_ADDR + &5200,y 
    sta SCREEN_ADDR + &5300,y 
    iny
    beq exit
    jmp loop
.exit
    rts
}

.test_screen
{
    lda #22 : jsr OSWRCH
    lda #1 : jsr OSWRCH

    lda #&30
    ldx #24
.loop_2
    ldy #&20
.loop_1
    jsr OSWRCH
    dey
    bne loop_1
    adc #&01
    dex
    bne loop_2

.exit
    rts
}