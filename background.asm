.background_data
{
    .start
    equb &04, &04, &01, &02, &02, &00, &04, &04, &01, &02, &02, &00, &04, &04, &01, &02, &02, &00, &04, &04, &01, &02, &02, &00, &04, &04, &01, &02, &02, &00, &04, &04
    equb &04, &04, &05, &07, &07, &03, &04, &04, &05, &07, &07, &03, &04, &04, &05, &07, &07, &03, &04, &04, &05, &07, &07, &03, &04, &04, &05, &07, &07, &03, &04, &04
    equb &02, &02, &08, &07, &07, &06, &02, &02, &08, &07, &07, &06, &02, &02, &08, &07, &07, &06, &02, &02, &08, &07, &07, &06, &02, &02, &08, &07, &07, &06, &02, &02
    equb &09, &0a, &09, &0a, &09, &0a, &09, &0a, &09, &0a, &09, &0a, &09, &0a, &09, &0a, &09, &0a, &09, &0a, &09, &0a, &09, &0a, &09, &0a, &09, &0a, &09, &0a, &09, &0a
    equb &0b, &0c, &0b, &0c, &0b, &0c, &0b, &0c, &0b, &0c, &0b, &0c, &0b, &0c, &0b, &0c, &0b, &0c, &0b, &0c, &0b, &0c, &0b, &0c, &0b, &0c, &0b, &0c, &0b, &0c, &0b, &0c    
    .end
    TABLE_ALIGNED "background_data"
}

.background_sprite_data
{
    .start
    ; Home Block 0
    equd &0d380f0e
    equd &2161c30f
    equd &0f0d0b0e
    equd &0f0e0b61

    ; Home Block 1
    equd &0f0b0e07
    equd &0f070e14
    equd &0f43870e
    equd &48683c87

    ; Home Block 2
    equd &0d380f0e
    equd &00b0940f
    equd &0f0d380f
    equd &0050c20f

    ; Home Block 3
    equd &21410361
    equd &41036121
    equd &0f29430f
    equd &0f0d780f

    ; Home Block 4
    equd &380f0f07
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
    equd &00004068

    ; Grass 16x16 Block 9
    equd &7d2f0f04
    equd &3e1f0f2f
    equd &3e1f0f0c
    equd &9f0f0f4f

    ; Grass 16x16 Block A
    equd &8f0f0b08
    equd &a7f5a70f
    equd &eb4f0f08
    equd &0f0f0f4f

    ; Grass 16x16 Block B
    equd &eb4f0f1f
    equd &4f0f1f4f
    equd &0f0f1f3e
    equd &098fc79f

    ; Grass 16x16 Block C
    equd &07970f8f
    equd &030f8fc7
    equd &8fc78f0f
    equd &000f0f0f
    .end
    TABLE_ALIGNED "background_sprite_data"
}

.background_y_addr_offset
{
    .start
    ; MSB of screen address for each line of screen 0-23.
    equb &2C, &2E, &30, &32, &34, &3C, &44, &4C, &34, &3C, &44, &4C
    equb &54, &56, &58, &60, &68, &6C, &68, &6c, &70, &78, &54, &56
    .end
    TABLE_ALIGNED "background_y_addr_offset"
}

.background_scroll_table
{
    .start
    equb &00, &00, &00, &00, &01, &00, &01, &00, &01, &00, &01, &00
    equb &00, &00, &00, &00, &01, &01, &00, &00, &00, &00, &00, &00
    .end
    TABLE_ALIGNED "background_scroll_table"
}
.background_draw_home
{
    ; Store screen address of line &01 in TEMP_ADDR_3
    ldy #&01
    lda background_y_addr_offset, y
    sta TEMP_ADDR_3_HI
    lda #&00
    sta TEMP_ADDR_3_LO

    ldx #95                             ; Total number of sprites to draw
.loop_1
    lda background_data, x              ; Load the sprite index to draw next
    jsr background_draw_sprite          ; Draw sprite on display
    dex
    bpl loop_1

.exit
    rts
}

.background_draw_grass
{
    ; Get screen address for line &0c, store in TEMP_ADDR_3
    ldy #&0c
    lda background_y_addr_offset, y
    sta TEMP_ADDR_3_HI
    lda #&00
    sta TEMP_ADDR_3_LO

    ldx #&3F
.loop_1
    lda background_data + 96, X
    jsr background_draw_sprite
    dex
    bpl loop_1

.exit
    rts
}

.background_draw_sprite
{
; Draw background sprite with index in Accumulator at x position in X Register
; Screen address in TEMP_3_ADDR

    ; Multiply accumulator by 16 (A << 4) to get offset into sprite data
    asl a
    asl a
    asl a
    asl a

    ; Get background sprite data address
    ; Add offset to sprite data address
    clc
    adc #LO(background_sprite_data)
    sta TEMP_ADDR_2_LO
    lda #HI(background_sprite_data)
    adc #&00
    sta TEMP_ADDR_2_HI

    ; Calculate Screen Address offset (X * 16)
    stx TEMP_1_LO
    ldy #&00
    sty TEMP_1_HI
    clc
    rol TEMP_1_LO
    rol TEMP_1_HI
    rol TEMP_1_LO
    rol TEMP_1_HI
    rol TEMP_1_LO
    rol TEMP_1_HI
    rol TEMP_1_LO
    rol TEMP_1_HI

    ; Add offset to screen address in TEMP_ADDR_3
    clc
    lda TEMP_1_LO
    adc TEMP_ADDR_3_LO
    sta TEMP_ADDR_1_LO
    lda TEMP_1_HI
    adc TEMP_ADDR_3_HI
    sta TEMP_ADDR_1_HI

    ; Plot sprite
    ldy #&0f
.loop_1
    lda (TEMP_ADDR_2), y
    sta (TEMP_ADDR_1), y
    dey
    bpl loop_1

.exit
    rts
}