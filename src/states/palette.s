.scope Palette
  .proc init
    LDA PPUSTATUS
    LDA #$3F
    STA PPUADDR
    LDA #$00
    STA PPUADDR

    LDX #$00
    palette_load_loop:
      LDA title_palette,X
      STA PPUDATA
      INX
      CPX #16
      BNE palette_load_loop

    RTI
  .endproc
.endscope
