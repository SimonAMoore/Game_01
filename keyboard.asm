.keyboard_init
{
    lda #&7F : sta SYS_VIA_R3_DDRA          ; Set SYS_VIA_PORT_A Bit 7 as input, bits 0-6 as outputs
    lda #&0F : sta SYS_VIA_R2_DDRB          ; Enable addressable latch
    lda #&03 : sta SYS_VIA_R0_ORB_IRB       ; Set bit 3 of addressable latch to 0
.exit
    rts
}

.read_keys
{
    ldy #&00
.loop
    lda #&7F
    and key_table, y        ; Reset bit 7 of key table
    beq exit                ; End of table so exit
    sta SYS_VIA_R15_ORA_IRA ; Send keycode to SYS_VIA_PORT_A
    lda SYS_VIA_R15_ORA_IRA ; Read keycode back from SYS_VIA_PORT_A
    sta key_table, y        ; Store result back in key table
    iny                     ; Increase counter
    bpl loop

.exit
    rts
}

.test_keys
{
    ldx #&00
    stx &5100 : stx &5300 : stx &5500 : stx &5700
    stx &5900 : stx &5B00 : stx &5D00 : stx &5F00
    dex

    lda key_table + 0               ; Get key '0' status
    bpl skip1
    stx &5100
.skip1
    lda key_table + 1               ; Get key '1' status
    bpl skip2
    stx &5300
.skip2
    lda key_table + 2               ; Get key '1' status
    bpl skip3
    stx &5500
.skip3
    lda key_table + 3               ; Get key '1' status
    bpl skip4
    stx &5700
.skip4
    lda key_table + 4               ; Get key '0' status
    bpl skip5
    stx &5900
.skip5
    lda key_table + 5               ; Get key '1' status
    bpl skip6
    stx &5B00
.skip6
    lda key_table + 6               ; Get key '1' status
    bpl skip7
    stx &5D00
.skip7
    lda key_table + 7               ; Get key '1' status
    bpl skip8
    stx &5F00
.skip8

.exit
    rts
}

.key_table
    equb 98                 ; Space
    equb 97                 ; Z
    equb 66                 ; X
    equb 103                ; .
    equb 87                 ; ;
    equb 16                 ; Q
    equb 81                 ; S
    equb 35                 ; T
    equb 0                  ; END OF KEY TABLE             