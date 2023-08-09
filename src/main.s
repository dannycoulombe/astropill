; Load NES headers
.segment "HEADER"
  .byte $4E, $45, $53, $1A            ; iNES header identifier
  .byte 2                             ; 2x 16KB PRG-ROM Banks
  .byte 1                             ; 1x  8KB CHR-ROM
  .byte $00                           ; mapper 0 (NROM)
  .byte $00                           ; System: NES

.segment "ZEROPAGE"
.segment "STARTUP"
.segment "CODE"

  ; Define variables
  .include "variables.inc"

  ; Prepare utils
  .include "utils/ppu.s"

  ; Prepare states
  .include "states/palette.s"
  .include "states/background.s"
;  .include "states/sprite.s"
  .include "states/controller.s"

  .proc nmi
;    JSR PPU::vBlankWait
;    JSR Controller::init
    RTI
  .endproc

  .proc reset
    SEI
    CLD                             ; Clear Decimal Mode (2A03 does not support BCD)

    ; Turn off NMI and rendering
    JSR PPU::disableNMI

    ; PPU warm up
    LDA PPUSTATUS
    JSR PPU::vBlankWait
    JSR PPU::vBlankWait

    ; Clear memory (do not scope the following since JSR stores its state in $100-$1FF)
    LDX #0
    ClearRAM:
      STA $000,x
      STA $100,x
      STA $200,x
      STA $300,x
      STA $400,x
      STA $500,x
      STA $600,x
      STA $700,x
      INX
      BNE ClearRAM

    ; Activate DMA (direct memory access) by setting low and high byte
    ActivateDMA:
      LDA #$00
      STA OAMADDR                     ; set the low byte (00) of the RAM address
      LDA #$02
      STA OAMDMA                      ; set the high byte (02) of the RAM address, start the transfer

    JSR Background::init
    JSR Palette::init
;    JSR Sprite::init

    CLI

    ;Turn on NMI and rendering
    JSR PPU::resetScrolling
    JSR PPU::enableNMI

    ; Loop indefinitely
    Forever:
      JMP Forever
  .endproc

  .proc irq
    RTI
  .endproc

  ; Load data
  title_palette: .incbin "palettes/title.pal"
  title_nametable: .incbin "nametables/title.nam"

.segment "VECTORS"
  .addr nmi, reset, irq

.segment "CHARS"
  .incbin "bin/astropill.chr"
