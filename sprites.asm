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

    ; Home Block 0
    equd &0b380f0e
    equd &2161c30f
    equd &0f0b0b0e
    equd &0f0f0b61

    ; Home Block 1
    equd &0f0b0e03
    equd &0f070e14
    equd &0f43870e
    equd &48683c83

    ; Home Block 2
    equd &0d380f0e
    equd &00b0940f
    equd &0f0d380f
    equd &0050c30f

    ; Home Block 3
    equd &21410261
    equd &41026121
    equd &0f29430f
    equd &0f0d780f

    ; Home Block 4
    equd &380f0f03
    equd &0f0b0f0d
    equd &0f0f0b0e
    equd &0b610f0e

    ; Home Block 5
    equd &0f0b610f
    equd &070f0d38
    equd &48680c28
    equd &680c2848

    ; Home Block 6
    equd &03216121
    equd &00103041
    equd &0e0b610f
    equd &0040380f

    ; Home Block 7
    equd &00000000
    equd &00000000
    equd &00000000
    equd &00000000

    ; Home Block 8
    equd &070d380f
    equd &00e1e10f
    equd &0c284848
    equd &00004060
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
    
    lda sprites + 32, y
    sta &7040, y
    lda sprites + 40, y
    sta &7048, y
    
    lda sprites + 48, y
    sta &7060, y
    lda sprites + 56, y
    sta &7068, y
    
    lda sprites + 64, y
    sta &7080, y
    lda sprites + 72, y
    sta &7088, y
    
    lda sprites + 80, y
    sta &70a0, y
    lda sprites + 88, y
    sta &70a8, y
    
    lda sprites + 96, y
    sta &70c0, y
    lda sprites + 104, y
    sta &70c8, y
    
    lda sprites + 112, y
    sta &70e0, y
    lda sprites + 120, y
    sta &70e8, y

    lda sprites + 128, y
    sta &7100, y
    lda sprites + 136, y
    sta &7108, y
    
    lda sprites + 144, y
    sta &7120, y
    lda sprites + 152, y
    sta &7128, y
    
    lda sprites + 160, y
    sta &7140, y
    lda sprites + 168, y
    sta &7148, y

    dey
    bmi skip_1
    jmp loop_1
.skip_1

.exit
    rts
}
