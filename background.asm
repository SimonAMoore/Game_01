.background_data
{
    ; Home Data
    ; 32 x 4 array of sprite references
    ;
    ;     XX   XX   //   ==   ==   \\   XX   XX   //   ==   ==   \\   XX   XX   //   ==   ==   \\   XX   XX   //   ==   ==   \\   XX   XX   //   ==   ==   \\   XX   XX
    ;     XX   XX   ||             ||   XX   XX   ||             ||   XX   XX   ||             ||   XX   XX   ||             ||   XX   XX   ||             ||   XX   XX
    ;     ==   ==   ,,             ``   ==   ==   ,,             ``   ==   ==   ,,             ``   ==   ==   ,,             ``   ==   ==   ,,             ``   ==   ==  
    ;
    equb &07, &07, &07, &07, &07, &07, &07, &07, &07, &07, &07, &07, &07, &07, &07, &07, &07, &07, &07, &07, &07, &07, &07, &07, &07, &07, &07, &07, &07, &07, &07, &07   
    equb &04, &04, &01, &02, &02, &00, &04, &04, &01, &02, &02, &00, &04, &04, &01, &02, &02, &00, &04, &04, &01, &02, &02, &00, &04, &04, &01, &02, &02, &00, &04, &04
    equb &04, &04, &05, &07, &07, &03, &04, &04, &05, &07, &07, &03, &04, &04, &05, &07, &07, &03, &04, &04, &05, &07, &07, &03, &04, &04, &05, &07, &07, &03, &04, &04
    equb &02, &02, &08, &07, &07, &06, &02, &02, &08, &07, &07, &06, &02, &02, &08, &07, &07, &06, &02, &02, &08, &07, &07, &06, &02, &02, &08, &07, &07, &06, &02, &02
    ; Grass path (offset +96)
    equb &09, &0a, &09, &0a, &09, &0a, &09, &0a, &09, &0a, &09, &0a, &09, &0a, &09, &0a, &09, &0a, &09, &0a, &09, &0a, &09, &0a, &09, &0a, &09, &0a, &09, &0a, &09, &0a
    equb &0b, &0c, &0b, &0c, &0b, &0c, &0b, &0c, &0b, &0c, &0b, &0c, &0b, &0c, &0b, &0c, &0b, &0c, &0b, &0c, &0b, &0c, &0b, &0c, &0b, &0c, &0b, &0c, &0b, &0c, &0b, &0c    
}

.background_sprite_data
{
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
    equd &ed4f0f1f
    equd &0f0f1f4f
    equd &0f0f1f3e
    equd &098fc79f

    ; Grass 16x16 Block C
    equd &07970f8f
    equd &030f8fc7
    equd &8fc78f0f
    equd &000f0f0f
    ; 040c 0808          0100:1100:1000:1000
    ; 0f0f 0b0f          1111:1111:1011:1111
    ; 2f1f 0f4f          1131:1113:1111:1311
    ; 7d3e 8feb          1323:1132:3111:3231

    ; 2f1f 0f4f          1131:1113:1111:1311
    ; 0f0f a70f          1111:1111:2131:1111
    ; 1f0f f50f          1113:1111:2323:1111
    ; 3e9f a70f          1132:3113:2131:1111

    ; 1f3e 8f0f          1113:1132:3111:1111
    ; 0f1f 0f8f          1111:1113:1111:3111
    ; 4f0f 97c7          1311:1111:2113:2311
    ; ed0f 078f          3231:1111:0111:3111

    ; 4f9f c70f          1311:3113:2311:1111
    ; 1fc7 8f0f          1113:2311:3111:1111
    ; 0f8f 0f0f          1111:3111:1111:1111
    ; 0f09 0300          1111:1001:0011:0000
}

.background_draw_home
{
    ldy #&00 : sty TEMP_3       ; y offset for sprite drawing routine
    ldx #&7f                    ; Total number of sprites to draw
.loop_1
    lda background_data, x      ; Load the sprite index to draw next
    jsr background_draw_sprite  ; Draw sprite on display
    dex
    bpl loop_1
.exit
    rts
}

.background_draw_grass_2
{
    ldx #&3F
.loop_1
    lda background_data + 128, X
    jsr background_draw_sprite
    dex
    bpl loop_1
.exit
    rts
}

.background_draw_grass
{
    ldy #&18 : sty TEMP_3               ; y offset for sprite drawing routine
    jsr background_draw_grass_2
    ldy #&2c : sty TEMP_3               ; y offset for sprite drawing routine
    jsr background_draw_grass_2

.exit
    rts
}
.background_draw_sprite
{
; Draw background sprite with index in Accumulator at x position in X Register
; Screen offset in TEMP_3_LO

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

    ; Get screen address
    lda #LO(SCREEN_ADDR)
    sta TEMP_ADDR_1_LO
    lda #HI(SCREEN_ADDR)
    sta TEMP_ADDR_1_HI

    ; Add offset to screen address
    clc
    lda TEMP_1_LO
    adc TEMP_ADDR_1_LO
    sta TEMP_ADDR_1_LO
    lda TEMP_1_HI
    adc TEMP_ADDR_1_HI
    adc TEMP_3
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