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
