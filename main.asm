include "bbc.asm"
include "zero_page.asm"

ORG     &1800

.start

.init_sine_table
{
    FOR n, 0, 255
      equb INT((SIN(n * 2 * PI / 256) + 1) * 32.25)
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
    ;jsr init_text_mode
    ;jsr instructions
    ;jsr clear_screen
    jsr test_screen
    jsr init_graphics_mode
    ;jsr test_chars
    ;jsr test_sprites
    ;jsr draw_car_a
    ;jsr background_draw_home
    ;jsr background_draw_grass
    jsr init_scanline_timer
    ;jsr init_keyboard
    ;jsr rupture_init

    ; Main loop
.main_loop
    ; Wait for Scanline_Timer
    ;{
    ;    lda #&40
    ;.wait
    ;    bit SYS_VIA_R13_IFR
    ;    beq wait
    ;    sta SYS_VIA_R13_IFR
    ;}

    ; Set timer latch to 2 character lines
    ;lda #LO(1022) : sta SYS_VIA_R6_T1L_L
    ;lda #HI(1022) : sta SYS_VIA_R7_T1L_H

    ; Wait for Scanline_Timer
    {
        lda #&40
    .wait
        bit SYS_VIA_R13_IFR
        beq wait
        sta SYS_VIA_R13_IFR
    }

    ; Set background colour
    ULA_SET_PALETTE 0, COL_RED
    ULA_SET_PALETTE 3, COL_WHITE

    ; Set rupture screen 1
    ;jsr rupture_R1

    ; Wait for VSYNC
    lda #&02
.wait_vsync
    bit SYS_VIA_R13_IFR
    beq wait_vsync
    sta SYS_VIA_R13_IFR

    ; Set background colour
    ULA_SET_PALETTE 0, COL_WHITE
    ULA_SET_PALETTE 3, COL_BLACK

    ; Set rupture screen 0
    ;jsr rupture_R0

.vertical_blanking
    ;jsr read_keys
    ;jsr test_keys

    ; Reset T1 counter
    lda #&40
    sta SYS_VIA_R13_IFR

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
print "=============================================="
print "Start: ", ~start, "    End: ", ~end, "    Execute: ", ~main_entry
print "=============================================="
print "                        .init_text_mode: ", ~init_text_mode
print "                          .instructions: ", ~instructions
print "                          .clear_screen: ", ~clear_screen
print "                    .init_graphics_mode: ", ~init_graphics_mode
print "                            .test_chars: ", ~test_chars
print "                          .test_sprites: ", ~test_sprites
print "                            .draw_car_a: ", ~draw_car_a
print "                  .background_draw_home: ", ~background_draw_home
print "                 .background_draw_grass: ", ~background_draw_grass
print "                   .init_scanline_timer: ", ~init_scanline_timer
print "                         .init_keyboard: ", ~init_keyboard
print "                          .rupture_init: ", ~rupture_init
print "=============================================="
