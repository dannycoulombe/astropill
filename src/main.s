; Load NES headers
.segment "HEADER"
  .byte $4E, $45, $53, $1A            ; iNES header identifier
  .byte $02                           ; amount of PRG ROM in 16K units
  .byte $01                           ; amount of CHR ROM in 8K units
  .byte $00                           ; mapper and mirroing
  .byte $00, $00, $00, $00
  .byte $00, $00, $00, $00, $00

.segment "ZEROPAGE"
  frame_counter: .res 1

.segment "RAM"
  ;  byte    0 = length of data (0 = no more data)
  ;  byte    1 = high byte of target PPU address
  ;  byte    2 = low byte of target PPU address
  ;  byte    3 = drawing flags:
  ;                bit 0 = set if inc-by-32, clear if inc-by-1
  ;  bytes 4-X = the data to draw (number of bytes determined by the length)
  display_buffer: .res 512

.segment "OAM"
  oam: .res 256        ; sprite OAM data to be uploaded by DMA

.segment "STARTUP"
.segment "CODE"

  ; Define variables
  .include "variables.inc"

  ; Prepare utils
  .include "utils/apu.s"
  .include "utils/ppu.s"
  .include "utils/program.s"

  ; Prepare STAtes
  .include "states/palette.s"
  .include "states/background.s"
  .include "states/controller.s"
  .include "states/title.s"

  ; Load drivers
  .include "drvs/famistudio.s"

  .proc reset
    JSR Program::init

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

    ;Turn on NMI and rendering
    JSR Background::init
    JSR APU::loadSong
    JSR PPU::enableBackground
    JSR PPU::enableNMI
    CLI
    CLC

    ; Loop indefinitely
    Forever:
      JMP Forever
  .endproc

  .proc nmi

    ; NMIs can happen at any given time, so we back up registers (important)
    PHA
    TXA
    PHA
    TYA
    PHA

    JSR PPU::vBlankWait

;    JSR Controller::init
;    INC frame_counter

    JSR APU::progressSong
    JSR Title::animateBackground
    JSR PPU::resetScrolling
    JSR PPU::renderDisplayBuffer

    ; Restore registers
    PLA
    TAY
    PLA
    TAX
    PLA
    RTI

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
