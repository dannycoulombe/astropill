.scope Background
  .proc init
    JSR loadDefault
    JSR loadNametable
    RTS
  .endproc

  .proc loadDefault
    LDA #>BG_COLOR                  ; Load high-byte of BG_COLOR into accumulator
    STA PPUADDR
    LDA #<BG_COLOR
    STA PPUADDR
    LDA #BLACK
    STA PPUDATA                     ; black backround color
    RTS
  .endproc

  .proc loadNametable
    LDA PPUSTATUS                   ; read PPU status to reset the high/low latch
    LDA #$20
    STA PPUADDR                     ; write the high byte of $2000 address
    LDA #$00
    STA PPUADDR                     ; write the low byte of $2000 address

    LDA #<title_nametable
    STA $0000
    LDA #>title_nametable
    STA $0001
    LDX #$00
    LDY #$00
    nametable_loop:
      LDA ($00), Y
      STA PPUDATA
      INY
      CPY #$00
      BNE nametable_loop
      INC $0001
      INX
      CPX #$04
      BNE nametable_loop
    RTS
  .endproc
.endscope
