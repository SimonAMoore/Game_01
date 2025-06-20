.sprites
{
    .start
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

    .end
    TABLE_ALIGNED "sprites"
}

.sprites_16
{
    .start
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

    ; Log-A                 ; Log-B                 ; Log-C

    ; 0000:0000:0000:0000   ; 0000:0000:0000:0000   ; 0000:0000:0000:0000   ; 00:00:00:00   equd &0d000000
    ; 0000:0000:0000:0000   ; 0000:0000:0000:0000   ; 0000:0000:0000:0000   ; 00:00:00:00   equd &0f0f0f0f
    ; 0000:0000:0000:0000   ; 0000:0000:0000:0000   ; 0000:0000:0000:0000   ; 00:00:00:00   equd &0f000000
    ; 0000:0011:1111:1011   ; 1101:1111:1111:0111   ; 1101:1111:3330:0000   ; 0d:0f:ee:00   equd &2f1f1f9f
    ; 0000:1111:1131:1111   ; 3111:1111:1111:1111   ; 1111:3113:3333:0000   ; 0f:9f:ff:00   equd &ee000000
    ; 0000:1133:1111:1111   ; 1111:1111:1331:1111   ; 1111:1113:1113:0000   ; 0f:1f:1f:00   equd &0f1f1fff
    ; 0001:1111:1111:1111   ; 1111:1311:1111:1131   ; 1111:1113:1113:3000   ; 0f:1f:1f:88   equd &00000000
    ; 0001:1111:1111:1133   ; 1111:1111:1111:1111   ; 1111:1131:1111:3000   ; 0f:2f:0f:88   equd &88880000
    ; 0001:1331:1113:1111   ; 1131:1111:1111:1111   ; 1111:1131:1311:3000   ; 0f:2f:4f:88   equd &0f0f3f0f
    ; 0001:1111:1113:1111   ; 1111:1111:1133:3111   ; 1133:1333:1313:3000   ; 3f:7f:5f:88   equd &0000000f
    ; 0000:1111:1110:1311   ; 1111:1111:1111:1111   ; 1111:1113:1113:0000   ; 0f:1f:1f:00   equd &1f1f7f2f
    ; 0000:0010:1111:1111   ; 1111:3331:1111:1111   ; 1111:1113:1133:0000   ; 0f:1f:3f:00   equd &00000007
    ; 0000:0111:1110:1111   ; 1110:1111:1110:1111   ; 1111:0111:1330:0000   ; 0f:07:6e:00   equd &3f1f5f4f
    ; 0000:0000:0000:0000   ; 0000:0000:0000:0000   ; 0000:0000:0000:0000   ; 00:00:00:00   equd &0000006e
    ; 0000:0000:0000:0000   ; 0000:0000:0000:0000   ; 0000:0000:0000:0000   ; 00:00:00:00   equd &00008888
    ; 0000:0000:0000:0000   ; 0000:0000:0000:0000   ; 0000:0000:0000:0000   ; 00:00:00:00   equd &00000000

    ; Log-C
    equd &0d000000
    equd &0f0f0f0f
    equd &0f000000
    equd &2f1f1f9f
    equd &ee000000
    equd &0f1f1fff
    equd &00000000
    equd &88880000
    equd &0f0f3f0f
    equd &0000000f
    equd &1f1f7f2f
    equd &00000007
    equd &3f1f5f4f
    equd &0000006e
    equd &00008888
    equd &00000000

    .end
    TABLE_ALIGNED "sprites_16"
}

.test_sprites
{
    ldy #&07

.loop_1
    lda sprites + 0, y
    sta &2c00, y
    lda sprites + 8, y
    sta &2c08, y
    
    lda sprites + 16, y
    sta &2c20, y
    lda sprites + 24, y
    sta &2c28, y

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
    lda #&04
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
    lda #&36 : sta TEMP_ADDR_1_HI
    lda #&00 : sta TEMP_ADDR_1_LO
    lda #&01 : jsr test_sprites_16
    rts
}
