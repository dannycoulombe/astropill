.scope Program
  .proc init
    SEI
    CLD                             ; disable decimal mode

    LDX #$40
    STX APU_PAD2                    ; disable APU frame IRQ
    LDX #$FF
;    TXS                             ; Set up stack
    INX                             ; now X = 0
    STX PPUCTRL                     ; disable NMI
    STX PPUMASK                     ; disable rendering
    STX APU_MODCTRL                 ; disable DMC IRQs

    ; The vblank flag is in an unknown state after reset,
    ; so it is cleared here to make sure that PPU::vBlankWait
    ; does not exit immediately.
    BIT PPUSTATUS
    JSR PPU::vBlankWait

    RTS
  .endproc
.endscope
