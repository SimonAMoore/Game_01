.init_text_mode
{
    ; Set graphics to Mode 7 with VDU 22,7
    lda #&16 : jsr OSWRCH
    lda #&07 : jsr OSWRCH

    ; Disable cursor via Video ULA Control Register
    lda #&9A : ldx #&0B : jsr OSBYTE

.exit
    rts
}

.instructions
{
    ldx #&00
    ldy instructions_text
.loop
    lda instructions_text + 1, x
    jsr OSWRCH
    inx
    dey
    bne loop

    ldx start_text
.loop2
    lda start_text + 1, y
    jsr OSWRCH
    iny
    dex
    bne loop2

.wait_for_key_press
    lda #&81 : ldy #&00 : ldx #&FF : jsr OSBYTE
    tya
    bmi wait_for_key_press

.exit
    rts

.instructions_text
    equb 223
    equb &0D, &0A
    equb 129, 157, 131, 141, 31, 16, 1, "GAME_01", &0D, &0A
    equb 129, 157, 131, 141, 31, 16, 2, "GAME_01"
    equb 31, 12, 4, 134, 141, "Instructions"
    equb 31, 12, 5, 134, 141, "Instructions"
    equb 31, 9, 7, "Keys:"
    equb 31, 14, 9, "Z - left"
    equb 31, 14, 10, "X - right"
    equb 31, 14, 11, ". - backwards"
    equb 31, 14, 12, "; - forwards"
    equb 31, 8, 14, 130, "Q - Turn off all sound"
    equb 31, 8, 15, 130, "S - Sound effects only"
    equb 31, 8, 16, 130, "T - Music and sound"
    equb 31, 11, 19, 131, "(C) fotosim 2025"

.start_text
    equb 39
    equb 31, 2, 22, 134, 136, "Press SPACE BAR or (fire) to start"
}