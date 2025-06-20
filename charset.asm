.charset
{
    .start
    ; 0
    equd &66662211
    equd &00113366
    equd &333366cc
    equd &00CC2233

    ; 1
    equd &00001100
    EQUD &00330000
    EQUD &CCCCCCCC
    EQUD &00FFCCCC

    ; 2
    equd &11006633
    EQUD &00777733
    EQUD &ee7733ee
    EQUD &00FF00CC

    ; 3
    equd &11000033
    EQUD &00336600
    EQUD &eecc66ff
    EQUD &00ee3333

    ; 4
    equd &66331100
    EQUD &00000077
    EQUD &6666eeee
    EQUD &006666ff

    ; 5
    equd &00776677
    EQUD &00336600
    EQUD &33ee00ee
    EQUD &00ee3333

    ; 6
    equd &77663311
    EQUD &00336666
    EQUD &ee0000ee
    EQUD &00ee3333

    ; 7
    equd &00006677
    EQUD &00111111
    EQUD &CC6633ff
    EQUD &00888888

    ; 8
    equd &33776633
    EQUD &00334444
    EQUD &CC2222CC
    EQUD &00ee33ff

    ; 9
    equd &33666633
    EQUD &00330000
    EQUD &ff3333ee
    EQUD &00cc6633

    ; A
    equd &66663311
    EQUD &00666677
    EQUD &333366cc
    EQUD &003333ff

    ; B
    equd &77666677
    EQUD &00776666
    EQUD &ff3333ee
    EQUD &00ee3333

    ; C
    equd &66663311
    EQUD &00113366
    EQUD &000033ee
    EQUD &00ee3300

    ; D
    equd &66666677
    EQUD &00776666
    EQUD &333366cc
    EQUD &00cc6633

    ; E
    equd &77666677
    EQUD &00776666
    EQUD &ee0000ff
    EQUD &00ff0000

    ; F
    equd &77666677
    EQUD &00666666
    EQUD &ee0000ff
    EQUD &00000000

    ; G
    equd &66663311
    EQUD &00113366
    EQUD &770000ff
    EQUD &00ff3333

    ; H
    equd &77666666
    EQUD &00666666
    EQUD &ff333333
    EQUD &00333333

    ; I
    equd &00000033
    EQUD &00330000
    EQUD &ccccccff
    EQUD &00ffcccc

    ; J
    equd &00000000
    EQUD &00336600
    EQUD &33333333
    EQUD &00ee3333

    ; K
    equd &77666666
    EQUD &00666677
    EQUD &88cc6633
    EQUD &0077eecc

    ; L
    equd &66666666
    EQUD &00776666
    EQUD &00000000
    EQUD &00ff0000

    ; M
    equd &77777766
    EQUD &00666666
    EQUD &ffff7733
    EQUD &003333bb

    ; N
    equd &77777766
    EQUD &00666666
    EQUD &ffbb3333
    EQUD &003377ff

    ; O
    equd &66666633
    EQUD &00336666
    EQUD &333333ee
    EQUD &00ee3333

    ; P
    equd &66666677
    EQUD &00666677
    EQUD &333333ee
    EQUD &000000ee

    ; Q
    equd &66666633
    EQUD &00336666
    EQUD &333333ee
    EQUD &00bb66ff

    ; R
    equd &66666677
    EQUD &00666677
    EQUD &773333ee
    EQUD &0077eecc

    ; S
    equd &33666633
    EQUD &00336600
    EQUD &ee0066cc
    EQUD &00ee3333

    ; T
    equd &00000033
    EQUD &00000000
    EQUD &ccccccff
    EQUD &00cccccc

    ; U
    equd &66666666
    EQUD &00336666
    EQUD &33333333
    EQUD &00ee3333

    ; V
    equd &77666666
    EQUD &00001133
    EQUD &77333333
    EQUD &0088ccee

    ; W
    equd &77666666
    EQUD &00223377
    EQUD &ffbb3333
    EQUD &002266ff

    ; X
    equd &11337766
    EQUD &00667733
    EQUD &ccee7733
    EQUD &003377ee

    ; Y
    equd &11113333
    EQUD &00000000
    EQUD &ee223333
    EQUD &00cccccc

    ; Z
    equd &11000077
    EQUD &00777733
    EQUD &ccee77ff
    EQUD &00ff0088

    ; 'DASH'
    equd &77000000
    EQUD &00000000
    EQUD &ff000000
    EQUD &00000000

    ; 'SPACE'
    equd &00000000
    EQUD &00000000
    EQUD &00000000
    EQUD &00000000

    ; 'COPYRIGHT'
    equd &aa994433
    EQUD &334499aa
    EQUD &119922cc
    EQUD &cc229911

    ; 'BOX'
    equd &888888ff
    EQUD &ff888888
    EQUD &111111ff
    EQUD &ff111111
    .end
    TABLE_ALIGNED "charset"
}

.write_char_A_at_XY
{

    ; Save Accumulator in temp 16bit variable
    sta TEMP_1_LO

    ; Save x and y registers
    tya : pha : txa : pha

    ; Clear temp_1 MSB
    lda #&00
    sta TEMP_1_HI

    ; Multiply by 16 (A << 4)
    clc
    rol TEMP_1_LO
    rol TEMP_1_HI
    rol TEMP_1_LO
    rol TEMP_1_HI
    rol TEMP_1_LO
    rol TEMP_1_HI
    rol TEMP_1_LO
    rol TEMP_1_HI

    ; Add to charset base address
    clc
    lda TEMP_1_LO
    adc #LO(charset)
    sta TEMP_ADDR_1_LO
    lda TEMP_1_HI
    adc #HI(charset)
    sta TEMP_ADDR_1_HI

    ; Save X in temp 16bit variable
    stx TEMP_1_LO
    lda #&00
    sta TEMP_1_HI

    ; Multiply by 16 (X << 4)
    clc
    rol TEMP_1_LO
    rol TEMP_1_HI
    rol TEMP_1_LO
    rol TEMP_1_HI
    rol TEMP_1_LO
    rol TEMP_1_HI
    rol TEMP_1_LO
    rol TEMP_1_HI

    ; Multiply y by &2 (Factor out &100)
    sty TEMP_Y
    asl TEMP_Y

    ; Add X*16 + Y*2 (*&100) to Screen address
    clc
    lda TEMP_1_LO
    adc #LO(SCREEN_ADDR)
    sta TEMP_ADDR_2_LO
    lda TEMP_1_HI
    adc #HI(SCREEN_ADDR)
    adc TEMP_Y
    sta TEMP_ADDR_2_HI

; Draw character on screen
    ldy #&0f
.loop_1
    lda (TEMP_ADDR_1), y
    sta (TEMP_ADDR_2), y
    dey
    bpl loop_1

.exit
    ; Restore x and y registers
    pla : tax : pla : tay

    rts
}

.test_chars
{
    lda #&27
    ldx #&09
    ldy #&10
    sta TEMP_2
.loop_1
    stx TEMP_3
    lda x_position_data, x
    tax
    lda TEMP_2
    jsr write_char_A_at_XY
    lda TEMP_2
    sec
    sbc #&01
    sta TEMP_2
    bmi exit
    ldx TEMP_3
    dex
    bpl loop_1
    ldx #&09
    dey
    dey
    dey
    dey
    bpl loop_1
.exit
    rts

    .x_position_data
    {
        .start
        equb &02, &05, &08, &0b, &0e, &11, &14, &17, &1a, &1d
        .end
        TABLE_ALIGNED "x_position_data"
    }
}
