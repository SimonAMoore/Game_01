include "bbc.asm"
include "zero_page.asm"

ORG     &1800
GUARD   SCREEN_ADDR

.start

include "charset.asm"
include "sprites.asm"
include "background.asm"
include "instructions.asm"
include "graphics.asm"
include "rupture_scroll.asm"
include "keyboard.asm"
include "sound.asm"


.main_entry:
{
    ; Flush all buffers
    lda #&0f : ldx #&00 : jsr OSBYTE

    ; Initialise
    jsr init_text_mode
    jsr instructions
    jsr clear_screen
    jsr init_graphics_mode
    jsr test_chars
    jsr test_sprites
    jsr draw_car_a
    jsr background_draw_home
    jsr background_draw_grass
    jsr init_keyboard
    jsr rupture_init

    ; Main loop
.main_loop
    ; Loop through rupture sections 0-23
    ; One for each character line. Last one
    ; has the vertical blanking and vsync

.screen_loop
    ; Wait for Scanline_Timer
    {
        lda #&40
    .wait
        bit SYS_VIA_R13_IFR
        beq wait
        sta SYS_VIA_R13_IFR
    }

    ; Palette change required to ensure 6845 R12 and R13
    ; get set inside the correct rupture screen
    ; ULA_SET_PALETTE 0, COL_BLUE
    ; ULA_SET_PALETTE 3, COL_WHITE

    ; Set rupture screen 0
    jsr rupture_R0

    ; Check for last rupture section
    ; If not repeat screen loop
    lda &00
    cmp #24
    bne screen_loop

    ; Set rupture screen 1 with VBlank and VSync
    jsr rupture_R1

    ; Wait for VSYNC
    lda #&02
.wait_vsync
    bit SYS_VIA_R13_IFR
    beq wait_vsync
    sta SYS_VIA_R13_IFR

    ; Set T1 timer to start just before end of vertical blanking
    ; 8 character lines - 2 scanlines - adjustment
    ; Latch T1 timer for every character line
    lda #LO(SYS_VIA_T1_SET_TIME) : sta SYS_VIA_R4_T1C_L
    lda #HI(SYS_VIA_T1_SET_TIME) : sta SYS_VIA_R5_T1C_H
    lda #LO(SYS_VIA_T1_LATCH_TIME) : sta SYS_VIA_R6_T1L_L
    lda #HI(SYS_VIA_T1_LATCH_TIME) : sta SYS_VIA_R7_T1L_H

.vertical_blanking
    ;jsr read_keys
    ;jsr test_keys

    ; Return to start of main loop
    jmp main_loop

.exit
    rts
}

.end:

SAVE "main", start, end, main_entry
print "================================================"
print " Start: ", ~start, "    End: ", ~end, "    Execute: ", ~main_entry
print "================================================"
print "                         .init_text_mode: ", ~init_text_mode
print "                           .instructions: ", ~instructions
print "                           .clear_screen: ", ~clear_screen
print "                     .init_graphics_mode: ", ~init_graphics_mode
print "                             .test_chars: ", ~test_chars
print "                           .test_sprites: ", ~test_sprites
print "                             .draw_car_a: ", ~draw_car_a
print "                   .background_draw_home: ", ~background_draw_home
print "                  .background_draw_grass: ", ~background_draw_grass
print "                          .init_keyboard: ", ~init_keyboard
print "                           .rupture_init: ", ~rupture_init
print "                             .rupture_R0: ", ~rupture_R0
print "                             .rupture_R1: ", ~rupture_R1
print "                             .sound_test: ", ~sound_test
print "================================================"
print "      T1 Timer Setup Time:   ", LEFT$("$0000", 5 - LEN(STR$~(SYS_VIA_T1_SET_TIME))), STR$~(SYS_VIA_T1_SET_TIME), " microseconds ( ", SYS_VIA_T1_SET_TIME, ")"
print "      T1 Timer Latch Time:   ", LEFT$("$0000", 5 - LEN(STR$~(SYS_VIA_T1_LATCH_TIME))), STR$~(SYS_VIA_T1_LATCH_TIME), " microseconds ( ", SYS_VIA_T1_LATCH_TIME, ")"
print "     Display Refresh Rate: ", DISPLAY_REFRESH, "Hz"
print "================================================"
