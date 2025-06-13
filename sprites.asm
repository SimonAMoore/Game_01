.sprites
{
    ; Level Indicator
    equd &03011100
    equd &00011212
    equd &0E8CCC00
    equd &00840E0E

    ; Lives Indicator
    equd &30341500
    equd &00040416
    equd &E0E1C500
    equd &000101C3
}

.sprites_16
{
    ; Car-A
    equd &07070700
    equd &13f07710
    equd &0c0c0c00
    equd &1bf3ff00
    equd &07070000
    equd &f8f0ff10
    equd &0c0c0000
    equd &f7eecc00
    equd &1077f057
    equd &00070707
    equd &00fff35f
    equd &000c0c0c
    equd &10fff0f8
    equd &00000707
    equd &00cceef7
    equd &00000c0c
}

.test_sprites
{
    ldy #&07

.loop_1
    lda sprites + 0, y
    sta &7000, y
    lda sprites + 8, y
    sta &7008, y
    
    lda sprites + 16, y
    sta &7020, y
    lda sprites + 24, y
    sta &7028, y

    dey
    bmi skip_1
    jmp loop_1
.skip_1

.exit
    rts
}

.test_sprites_16
{
    ; Draw sprite 'A' at screen address in TEMP_ADDR_1

    ; Multiply A by 64 (A << 6)
    asl a : asl a : asl a : asl a : asl a : asl a
    clc
    adc #LO(sprites_16)
    sta TEMP_ADDR_2_LO
    lda #&00
    adc #HI(sprites_16)
    sta TEMP_ADDR_2_HI

    ldy #&1f
.loop_1
    lda (TEMP_ADDR_2), y
    sta (TEMP_ADDR_1), y
    dey
    bpl loop_1

    clc
    lda #&02
    adc TEMP_ADDR_1_HI
    sta TEMP_ADDR_1_HI
    lda #&20
    adc TEMP_ADDR_2_LO
    sta TEMP_ADDR_2_LO
    lda #&00
    adc TEMP_ADDR_2_HI
    sta TEMP_ADDR_2_HI

    ldy #&1f
.loop_2
    lda (TEMP_ADDR_2), y
    sta (TEMP_ADDR_1), y
    dey
    bpl loop_2

.exit
    rts
}

.draw_car_a
{
    lda #&71 : sta TEMP_ADDR_1_HI
    lda #&00 : sta TEMP_ADDR_1_LO
    jsr test_sprites_16
    lda #&73 : sta TEMP_ADDR_1_HI
    lda #&08 : sta TEMP_ADDR_1_LO
    jmp test_sprites_16
}
