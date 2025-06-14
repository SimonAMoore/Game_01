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
    ;jsr init_text_mode
    ;jsr instructions
    jsr init_graphics_mode
    ;jsr clear_screen
    ;jsr test_chars
    ;jsr test_sprites
    ;jsr draw_car_a
    ;jsr background_draw_home
    ;jsr background_draw_grass
    jsr init_scanline_timer
    ;jsr init_keyboard

    ; Main loop
.main_loop
    ; Wait for Scanline_Timer
    lda #&40
.wait_timer
    bit SYS_VIA_R13_IFR
    beq wait_timer
    sta SYS_VIA_R13_IFR
    ULA_SET_PALETTE 0, COL_RED
    ULA_SET_PALETTE 1, COL_RED
    ULA_SET_PALETTE 2, COL_RED
    ULA_SET_PALETTE 3, COL_RED
    jsr rupture_R1

    ; Wait for Scanline_Timer
    lda #&40
.wait_timer2
    bit SYS_VIA_R13_IFR
    beq wait_timer2
    sta SYS_VIA_R13_IFR
    ULA_SET_PALETTE 0, COL_WHITE
    ULA_SET_PALETTE 1, COL_WHITE
    ULA_SET_PALETTE 2, COL_WHITE
    ULA_SET_PALETTE 3, COL_WHITE
    jsr rupture_R0

    jmp main_loop
    ; Scanline timer triggered
    ; Set colour 0 to black
    ;ULA_SET_PALETTE 0, COL_BLACK

    ; Set colour 1 to magenta
    ;ULA_SET_PALETTE 1, COL_MAGENTA

    ; Set colour 2 to yellow
    ;ULA_SET_PALETTE 2, COL_YELLOW

    ; Set colour 3 to green
    ;ULA_SET_PALETTE 3, COL_BLUE

    ; Wait for end of river-bank scanline and then change
    ; palette for white/green car_a sprite
    ;ldx #&d8
;.loop_3
    ;nop : nop
    ;dex
    ;bne loop_3

    ; Change colour 1 to red
    ;ULA_SET_PALETTE 1, COL_RED

    ; Change colour 2 to green
    ;ULA_SET_PALETTE 2, COL_GREEN

    ; Change colour 3 to white
    ;ULA_SET_PALETTE 3, COL_WHITE

    ; Wait for end of 4th (Top) road lane scanline and then change
    ; palette for purple/blue/yellow car_a sprite
    ;ldx #&d2
;.loop_4
    ;nop : nop
    ;dex
    ;bne loop_4

    ; Change colour 1 to magenta
    ;ULA_SET_PALETTE 1, COL_MAGENTA

    ; Change colour 2 to yellow
    ;ULA_SET_PALETTE 2, COL_YELLOW

    ; Change colour 3 to blue
    ;ULA_SET_PALETTE 3, COL_BLUE

    ; Wait for VSYNC
    lda #&02
.wait_vsync
    bit SYS_VIA_R13_IFR
    beq wait_vsync
    sta SYS_VIA_R13_IFR

    ; Set rupture section 0
    jsr rupture_R0

    ; VSYNC triggered.
    ; Set colour 1 to green
    ;ULA_SET_PALETTE 1, COL_GREEN

    ; Set colour 3 to white
    ;ULA_SET_PALETTE 3, COL_WHITE

.vertical_blanking
    ;jsr read_keys
    ;jsr test_keys

    ; Wait for character line 1 end of scanline
    ; then change background to blue
    ;ldx #&f2
;.loop_2
    ;nop : nop : nop : nop : nop : nop : nop : nop
    ;nop : nop : nop : nop : nop : nop : nop
    ;dex
    ;bne loop_2
    ;nop : nop : nop

    ; Change colour 0 to blue
    ;ULA_SET_PALETTE 0, COL_BLUE

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