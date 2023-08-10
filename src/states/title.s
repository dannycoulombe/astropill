.scope Title
  .proc animateBackground
    LDA #$20                  ; Load high-byte of BG_COLOR into accumulator
    STA PPUADDR
    LDA #$B4
    STA PPUADDR

    ; Check the value at the current address and compares it to its tile index
    LDA PPUDATA
    LDA PPUDATA
    CMP #$13
    BNE increment
      LDA #$13
      STA PPUDATA
      JMP end_switch
    increment:
      LDA #$14
      STA PPUDATA
    end_switch:

    RTS
  .endproc
.endscope
