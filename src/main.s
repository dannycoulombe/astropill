; Load NES headers
.segment "HEADER"
  .byte $4E, $45, $53, $1A            ; iNES header identifier
  .byte $02                           ; amount of PRG ROM in 16K units
  .byte $01                           ; amount of CHR ROM in 8K units
  .byte $00                           ; mapper and mirroing
  .byte $00, $00, $00, $00
  .byte $00, $00, $00, $00, $00

.segment "ZEROPAGE"
  VAR:  .RES 1                              ; reserves 1 byte of memory for a variable named VAR

.segment "STARTUP"

.segment "RAM"

.segment "OAM"
  oam: .res 256        ; sprite OAM data to be uploaded by DMA

.segment "CODE"

  ; Define variables
  .include "variables.inc"

  ; Prepare utils
  .include "utils/apu.s"
  .include "utils/ppu.s"

  ; Prepare states
  .include "states/palette.s"
  .include "states/background.s"
;  .include "states/sprite.s"
  .include "states/controller.s"

  ; Load drivers
  .include "drvs/famistudio.s"

  .proc reset
    SEI

    ; Turn off NMI and rendering
    JSR PPU::disableNMI
    CLD                             ; Clear Decimal Mode (2A03 does not support BCD)
    ldx #$FF
    txs       ; initialize stack

    ; PPU warm up
    LDA PPUSTATUS
    JSR PPU::vBlankWait

    ; Clear memory
    LDX #0
    ClearRAM:
      STA $0000,x
      STA $0100,x
      STA $0200,x
      STA $0300,x
      STA $0400,x
      STA $0500,x
      STA $0600,x
      STA $0700,x
      INX
      BNE ClearRAM

    JSR PPU::vBlankWait

    ; Activate DMA (direct memory access) by setting low and high byte
    ActivateDMA:
      LDA #$00
      STA OAMADDR                     ; set the low byte (00) of the RAM address
      LDA #$02
      STA OAMDMA                      ; set the high byte (02) of the RAM address, start the transfer
    NOP

    LDA PPUSTATUS
    LDA #$3F
    STA PPUADDR
    LDA #$00
    STA PPUADDR

;    JSR Palette::init
;    JSR Sprite::init

    ;Turn on NMI and rendering
    JSR Background::init
    JSR PPU::resetScrolling
    JSR PPU::enableNMI
    JSR APU::playSong
    CLI

    @draw_done:
      jsr famistudio_update ; TODO: Call in NMI.
      LDX #0
      LDY #0
      @outer_loop_nop:
      @inner_loop_nop:
        NOP
        INY
        CPY #255
        BNE @inner_loop_nop
        INX
        CPX #12
        BNE @outer_loop_nop

      JMP @draw_done ; Dont allow update if we already have an update pending.

    ; Loop indefinitely
    Forever:
      JMP Forever
  .endproc

  .proc nmi
;    JSR PPU::vBlankWait
;    JSR Controller::init
    RTI
  .endproc

  .proc irq
    RTI
  .endproc

  ; Load data
  title_palette: .incbin "pals/title.pal"
  title_nametable: .incbin "nams/title.nam"

.segment "DPCM"

.segment "SONGS"
  song_title: .include "songs/title.s"

.segment "VECTORS"
  .addr nmi, reset, irq

.segment "CHARS"
  .incbin "bin/astropill.chr"
