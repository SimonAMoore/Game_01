include "bbc.asm"
include "zero_page.asm"

ORG     &1900
GUARD   &5000

.start

include "charset.asm"
include "sprites.asm"

.main_entry:
{
    ; Flush all buffers
    lda #&0F : ldx #&00 : jsr OSBYTE

    ; Initialise display
    jsr init_text_mode
    jsr instructions
    jsr init_graphics_mode
    jsr clear_screen
    jsr init_scanline_timer
    jsr init_keyboard
    jsr char_test_screen
    jsr test_sprites

    ; Main loop
.loop
    ; Wait for Scanline_Timer
    lda #&40
.wait_timer
    bit SYS_VIA_R13_IFR
    beq wait_timer
    sta SYS_VIA_R13_IFR

    ;Scanline timer triggered. Set colour 0 to blue
    lda #&03 : sta VIDEO_ULA_PALETTE_REG
    lda #&13 : sta VIDEO_ULA_PALETTE_REG
    lda #&43 : sta VIDEO_ULA_PALETTE_REG
    lda #&53 : sta VIDEO_ULA_PALETTE_REG

    ;Scanline timer triggered. Set colour 3 to magenta
    lda #&A2 : sta VIDEO_ULA_PALETTE_REG
    lda #&B2 : sta VIDEO_ULA_PALETTE_REG
    lda #&E2 : sta VIDEO_ULA_PALETTE_REG
    lda #&F2 : sta VIDEO_ULA_PALETTE_REG

    ; Wait for VSYNC
    lda #&02
.wait_vsync
    bit SYS_VIA_R13_IFR
    beq wait_vsync
    sta SYS_VIA_R13_IFR

    ;VSYNC triggered. Set colour 0 to black
    lda #&07 : sta VIDEO_ULA_PALETTE_REG
    lda #&17 : sta VIDEO_ULA_PALETTE_REG
    lda #&47 : sta VIDEO_ULA_PALETTE_REG
    lda #&57 : sta VIDEO_ULA_PALETTE_REG

    ;VSYNC triggered. Set colour 3 to white
    lda #&A0 : sta VIDEO_ULA_PALETTE_REG
    lda #&B0 : sta VIDEO_ULA_PALETTE_REG
    lda #&E0 : sta VIDEO_ULA_PALETTE_REG
    lda #&F0 : sta VIDEO_ULA_PALETTE_REG

.vertical_blanking
    jsr read_keys
    jsr test_keys

    jmp loop

.exit
    rts
}

include "instructions.asm"
include "graphics.asm"
include "interrupts.asm"
include "keyboard.asm"

.end:

SAVE "main", start, end, main_entry
