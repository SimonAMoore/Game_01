include "bbc.asm"
include "zero_page.asm"

ORG     &1800

.start

.init_sine_table
{
    FOR n, 0, 255
      equb INT((SIN(n * 2 * PI / 256)+1) * 32.5)
    NEXT
}

ORG     &1900
GUARD   &5000

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
    jsr clear_screen
    ;jsr test_screen
    jsr init_graphics_mode
    jsr test_chars
    jsr test_sprites
    jsr draw_car_a
    jsr background_draw_home
    jsr background_draw_grass
    jsr init_scanline_timer
    jsr init_keyboard

    lda #&00 : sta &00

    ; Wait for vsync
    {
        lda #&02
    .wait
        bit SYS_VIA_R13_IFR
        beq wait
        sta SYS_VIA_R13_IFR
    }

    ; Set Rupture Screen 0
    jsr rupture_R0

    ; Reset total lines so original timing ends
    lda #&04 : sta CRTC_REG
    lda #&26 : sta CRTC_DATA

    ; Reset T1 interrupt flag
    lda #&40
    sta SYS_VIA_R13_IFR

    ; Main loop
.main_loop
    ; Wait for Scanline_Timer
    {
        lda #&40
    .wait
        bit SYS_VIA_R13_IFR
        beq wait
        sta SYS_VIA_R13_IFR
    }

    ; Set rupture screen 1
    jsr rupture_R1
    inc &00

    ; Wait for Scanline_Timer
    {
        lda #&40
    .wait
        bit SYS_VIA_R13_IFR
        beq wait
        sta SYS_VIA_R13_IFR
    }

    ; Set rupture screen 1
    jsr rupture_R0

    ; Wait for VSYNC
    lda #&02
.wait_vsync
    bit SYS_VIA_R13_IFR
    beq wait_vsync
    sta SYS_VIA_R13_IFR

    ; Set rupture screen 0
    jsr rupture_R0

.vertical_blanking
    ;jsr read_keys
    ;jsr test_keys

    ; Return to start of main loop
    jmp main_loop

.exit
    rts
}

include "instructions.asm"
include "graphics.asm"
include "rupture_scroll.asm"
include "interrupts.asm"
include "keyboard.asm"

.end:

SAVE "main", start, end, main_entry
print ~start, ~end, ~main_entry