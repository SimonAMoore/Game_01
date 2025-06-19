.sound_test
{
    ldy #&ff : sty SYS_VIA_R3_DDRA      ; Set PORTA bits 0-7 as outputs
    sta SYS_VIA_R15_ORA_IRA             ; Ouput A on SYS VIA PORT A
    iny                                 ; Y = 0
    sty SYS_VIA_R0_ORB_IRB              ; Enable SN76489

.loop_1
    ldy #&02
    dey
    bne loop_1

    ldy #&08
    sty SYS_VIA_R0_ORB_IRB
    ldy #&04

.loop_2
    dey
    bne loop_2

.exit
    rts
}