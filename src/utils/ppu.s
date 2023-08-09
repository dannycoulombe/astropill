.scope PPU
  .proc vBlankWait
    BIT PPUSTATUS
    BPL vBlankWait
    RTS
  .endproc

  .proc resetScrolling
    LDA #$00                        ; disable any scrolling
    STA PPUSCROLL                   ; first write influences X scroll
    STA PPUSCROLL                   ; second write influences Y scroll
    RTS
  .endproc

  .proc disableNMI
    LDA #0
    STA PPUCTRL
    STA PPUMASK
    STA APU_CHANCTRL
    STA APU_MODCTRL
    lda #$40
    sta APU_PAD2
    RTS
  .endproc

  .proc enableNMI
    LDA #%10001000                  ; enable NMI, sprites from pattern table 0, background from pattern table 1
    STA PPUCTRL
    LDA #%10011110                  ; background and sprites enable, no clipping on left
    STA PPUMASK
    RTS
  .endproc
.endscope
