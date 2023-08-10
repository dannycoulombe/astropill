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
    lda PPUCTRL ; Load current value of PPUCTRL register
    and #%11111110 ; Clear the NMI enable bit (bit 0)
    sta PPUCTRL ; Store the updated value back to PPUCTRL register
    RTS
  .endproc

  .proc enableNMI
    lda PPUCTRL ; Load current value of PPUCTRL register
    ora #%10000000 ; Set the NMI enable bit (bit 0)
    sta PPUCTRL ; Store the updated value back to PPUCTRL register
    RTS
  .endproc

  .proc enableBackground
    LDA #%00001000                  ; background and sprites enable, no clipping on left
    STA PPUMASK
    RTS
  .endproc

  .proc renderDisplayBuffer
    RTS
  .endproc
.endscope
