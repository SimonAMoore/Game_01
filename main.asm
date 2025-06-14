include "bbc.asm"
include "zero_page.asm"

ORG     &1900
GUARD   &5000

.start

include "charset.asm"
include "sprites.asm"
include "background.asm"

.main_entry:
{
    ; Flush all buffers
    lda #&0F : ldx #&00 : jsr OSBYTE

    ; Initialise
    jsr init_text_mode
    jsr instructions
    jsr init_graphics_mode
    jsr clear_screen
    jsr test_chars
    jsr test_sprites
    jsr draw_car_a
    jsr background_draw_home
    jsr background_draw_grass
    jsr init_scanline_timer
    jsr init_keyboard

    ; Main loop
.main_loop
    ; Wait for Scanline_Timer
    lda #&40
.wait_timer
    bit SYS_VIA_R13_IFR
    beq wait_timer
    sta SYS_VIA_R13_IFR

    ;Scanline timer triggered. Set colour 0 to black
    lda #&07 : sta VIDEO_ULA_PALETTE_REG
    lda #&17 : sta VIDEO_ULA_PALETTE_REG
    lda #&47 : sta VIDEO_ULA_PALETTE_REG
    lda #&57 : sta VIDEO_ULA_PALETTE_REG

    ;Scanline timer triggered. Set colour 1 to magenta
    lda #&22 : sta VIDEO_ULA_PALETTE_REG
    lda #&32 : sta VIDEO_ULA_PALETTE_REG
    lda #&62 : sta VIDEO_ULA_PALETTE_REG
    lda #&72 : sta VIDEO_ULA_PALETTE_REG

    ;Scanline timer triggered. Set colour 2 to yellow
    lda #&84 : sta VIDEO_ULA_PALETTE_REG
    lda #&94 : sta VIDEO_ULA_PALETTE_REG
    lda #&c4 : sta VIDEO_ULA_PALETTE_REG
    lda #&d4 : sta VIDEO_ULA_PALETTE_REG

    ;Scanline timer triggered. Set colour 3 to green
    lda #&A3 : sta VIDEO_ULA_PALETTE_REG
    lda #&B3 : sta VIDEO_ULA_PALETTE_REG
    lda #&E3 : sta VIDEO_ULA_PALETTE_REG
    lda #&F3 : sta VIDEO_ULA_PALETTE_REG

    ; Wait for end of river-bank scanline and then change
    ; palette for white/green car_a sprite
    ldx #&d8
.loop_3
    nop : nop
    dex
    bne loop_3
    ; Change colour 1
    lda #&26 : sta VIDEO_ULA_PALETTE_REG
    lda #&36 : sta VIDEO_ULA_PALETTE_REG
    lda #&66 : sta VIDEO_ULA_PALETTE_REG
    lda #&76 : sta VIDEO_ULA_PALETTE_REG
    ; Change colour 2
    lda #&85 : sta VIDEO_ULA_PALETTE_REG
    lda #&95 : sta VIDEO_ULA_PALETTE_REG
    lda #&c5 : sta VIDEO_ULA_PALETTE_REG
    lda #&d5 : sta VIDEO_ULA_PALETTE_REG
    ; Change colour 3
    lda #&A0 : sta VIDEO_ULA_PALETTE_REG
    lda #&B0 : sta VIDEO_ULA_PALETTE_REG
    lda #&E0 : sta VIDEO_ULA_PALETTE_REG
    lda #&F0 : sta VIDEO_ULA_PALETTE_REG

    ; Wait for end of 4th (Top) road lane scanline and then change
    ; palette for purple/blue/yellow car_a sprite
    ldx #&d2
.loop_4
    nop : nop
    dex
    bne loop_4
    ; Change colour 1
    lda #&22 : sta VIDEO_ULA_PALETTE_REG
    lda #&32 : sta VIDEO_ULA_PALETTE_REG
    lda #&62 : sta VIDEO_ULA_PALETTE_REG
    lda #&72 : sta VIDEO_ULA_PALETTE_REG
    ; Change colour 2
    lda #&84 : sta VIDEO_ULA_PALETTE_REG
    lda #&94 : sta VIDEO_ULA_PALETTE_REG
    lda #&c4 : sta VIDEO_ULA_PALETTE_REG
    lda #&d4 : sta VIDEO_ULA_PALETTE_REG
    ; Change colour 3
    lda #&A3 : sta VIDEO_ULA_PALETTE_REG
    lda #&B3 : sta VIDEO_ULA_PALETTE_REG
    lda #&E3 : sta VIDEO_ULA_PALETTE_REG
    lda #&F3 : sta VIDEO_ULA_PALETTE_REG

    ; Wait for VSYNC
    lda #&02
.wait_vsync
    bit SYS_VIA_R13_IFR
    beq wait_vsync
    sta SYS_VIA_R13_IFR

    ;VSYNC triggered. Set colour 1 to green
    lda #&25 : sta VIDEO_ULA_PALETTE_REG
    lda #&35 : sta VIDEO_ULA_PALETTE_REG
    lda #&65 : sta VIDEO_ULA_PALETTE_REG
    lda #&75 : sta VIDEO_ULA_PALETTE_REG

    ;VSYNC triggered. Set colour 3 to white
    lda #&A0 : sta VIDEO_ULA_PALETTE_REG
    lda #&B0 : sta VIDEO_ULA_PALETTE_REG
    lda #&E0 : sta VIDEO_ULA_PALETTE_REG
    lda #&F0 : sta VIDEO_ULA_PALETTE_REG

.vertical_blanking
    jsr read_keys
    jsr test_keys

    ; Wait for character line 1 end of scanline
    ; then change background to blue
    ldx #&f2
.loop_2
    nop : nop : nop : nop : nop : nop : nop : nop
    nop : nop : nop : nop : nop : nop : nop
    dex
    bne loop_2
    nop : nop : nop
    ; Change colour 0 to blue
    lda #&03 : sta VIDEO_ULA_PALETTE_REG
    lda #&13 : sta VIDEO_ULA_PALETTE_REG
    lda #&43 : sta VIDEO_ULA_PALETTE_REG
    lda #&53 : sta VIDEO_ULA_PALETTE_REG

    ; Return to start of main loop
    jmp main_loop

.exit
    rts
}

include "instructions.asm"
include "graphics.asm"
include "interrupts.asm"
include "keyboard.asm"

.end:

SAVE "main", start, end, main_entry
