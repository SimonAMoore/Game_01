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

    ; Log-A
    equd &00000000      ; 0000:0000:0000:0000   ; 00:00:00:00
    equd &10100000      ; 0000:0000:0000:0000   ; 00:00:00:00  
    equd &30000000      ; 0000:0000:0000:0000   ; 00:00:00:00  
    equd &f0f0f3f0      ; 0000:0011:1111:1011   ; 00:03:0f:0b 
    equd &f0000000      ; 0000:1111:1131:1111   ; 00:0f:2f:0f   
    equd &f0f0f0f2      ; 0000:1133:1111:1111   ; 00:3f:0f:0f       
    equd &b0000000      ; 0001:1111:1111:1111   ; 01:0f:0f:0f   
    equd &f3f0f0f0      ; 0001:1111:1111:1133   ; 01:0f:0f:3f   
    equd &00001010      ; 0001:1331:1113:1111   ; 01:6f:1f:0f   
    equd &00000000      ; 0001:1111:1113:1111   ; 01:0f:1f:0f   
    equd &20f0f0f6      ; 0000:1111:1110:1311   ; 00:0f:0e:4f   
    equd &00000070      ; 0000:0010:1111:1111   ; 00:02:0f:0f  
    equd &f0e0f1f1      ; 0000:0111:1110:1111   ; 00:07:0e:0f   
    equd &000000e0      ; 0000:0000:0000:0000   ; 00:00:00:00   
    equd &f0f4f0f0      ; 0000:0000:0000:0000   ; 00:00:00:00  
    equd &000000f0      ; 0000:0000:0000:0000   ; 00:00:00:00   

    ; Log-B
    equd &d0000000      ; 0000:0000:0000:0000   ; 00:00:00:00
    equd &f0f0f0f8      ; 0000:0000:0000:0000   ; 00:00:00:00
    equd &f0000000      ; 0000:0000:0000:0000   ; 00:00:00:00
    equd &f0f4f0f0      ; 1101:1111:1111:0111   ; 0d:0f:0f:07
    equd &f0000000      ; 3111:1111:1111:1111   ; 8f:0f:0f:0f
    equd &f0f0f6f0      ; 1111:1111:1331:1111   ; 0f:0f:6f:0f
    equd &70000000      ; 1111:1311:1111:1131   ; 0f:4f:0f:2f
    equd &f0f2f0f0      ; 1111:1111:1111:1111   ; 0f:0f:0f:0f
    equd &f0f0f0f2      ; 1131:1111:1111:1111   ; 2f:0f:0f:0f
    equd &000000e0      ; 1111:1111:1133:3111   ; 0f:0f:3f:8f
    equd &fef0f0f0      ; 1111:1111:1111:1111   ; 0f:0f:0f:0f
    equd &000000f0      ; 1111:3331:1111:1111   ; 0f:ef:0f:0f
    equd &f0f0f3f0      ; 1110:1111:1110:1111   ; 0e:0f:0e:0f
    equd &000000e0      ; 0000:0000:0000:0000   ; 00:00:00:00
    equd &f0f0f8f0      ; 0000:0000:0000:0000   ; 00:00:00:00
    equd &000000f0      ; 0000:0000:0000:0000   ; 00:00:00:00

    ; Log-C
    equd &d0000000      ; 00:00:00:00
    equd &f0f0f0f0      ; 00:00:00:00
    equd &f0000000      ; 00:00:00:00
    equd &f2f1f1f9      ; 0d:0f:ee:00
    equd &ee000000      ; 0f:9f:ff:00
    equd &f0f1f1ff      ; 0f:1f:1f:00
    equd &00000000      ; 0f:1f:1f:88
    equd &88880000      ; 0f:2f:0f:88
    equd &f0f0f3f0      ; 0f:2f:4f:88
    equd &000000f0      ; 3f:7f:5f:88
    equd &f1f1f7f2      ; 0f:1f:1f:00
    equd &00000070      ; 0f:1f:3f:00
    equd &f3f1f5f4      ; 0f:07:6e:00
    equd &000000e6      ; 00:00:00:00
    equd &00008888      ; 00:00:00:00
    equd &00000000      ; 00:00:00:00

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

.draw_log
{
    lda #&36 : sta TEMP_ADDR_1_HI
    lda #&00 : sta TEMP_ADDR_1_LO
    lda #&01 : jsr test_sprites_16
    lda #&36 : sta TEMP_ADDR_1_HI
    lda #&10 : sta TEMP_ADDR_1_LO
    lda #&02 : jsr test_sprites_16
    lda #&36 : sta TEMP_ADDR_1_HI
    lda #&20 : sta TEMP_ADDR_1_LO
    lda #&03 : jsr test_sprites_16
    lda #&3a : sta TEMP_ADDR_1_HI
    lda #&00 : sta TEMP_ADDR_1_LO
    lda #&01 : jsr test_sprites_16
    lda #&3a : sta TEMP_ADDR_1_HI
    lda #&10 : sta TEMP_ADDR_1_LO
    lda #&02 : jsr test_sprites_16
    lda #&3a : sta TEMP_ADDR_1_HI
    lda #&20 : sta TEMP_ADDR_1_LO
    lda #&03 : jsr test_sprites_16
    rts
}
