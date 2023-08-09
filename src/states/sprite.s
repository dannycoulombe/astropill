.scope Sprite
  .proc init
    LDX #$00                        ; start at 0
    LoadSpritesLoop:
      LDA sprites, x                  ; load utils from address (sprites + x)
      STA $0200, x                    ; store into RAM address ($0200 + x)
      INX                             ; X = X + 1
      CPX #$10                        ; Compare X to hex $10, decimal 16
      BNE LoadSpritesLoop             ; Branch to LoadSpritesLoop if compare was Not Equal to zero
      ; if compare was equal to 16, continue down

      LDA #%10000000   ; enable NMI, sprites from Pattern Table 0
      STA PPUCTRL

      LDA #%00010000   ; enable sprites
      STA PPUMASK
    RTS
  .endproc
.endscope
