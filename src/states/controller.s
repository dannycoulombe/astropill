.scope Controller
  .proc init
    JSR latch

    LDA APU_PAD1
    LDA APU_PAD1
    LDA APU_PAD1
    LDA APU_PAD1
    LDA APU_PAD1
    LDA APU_PAD1

    ReadLeft:
      LDA APU_PAD1                       ; player 1 - B
      AND #%00000001                  ; only look at bit 0
      BEQ ReadLeftDone                ; branch to ReadBDone if button is NOT pressed (0)
      ; add instructions here to do something when button IS pressed (1)
      LDA $0203                       ; load sprite X position
      SEC                             ; make sure carry flag is set
      SBC #$02                        ; A = A - 1
      STA $0203                       ; save sprite X position
    ReadLeftDone:                       ; handling this button is done

    ReadRight:
      LDA APU_PAD1                       ; player 1 - A
      AND #%00000001                  ; only look at bit 0
      BEQ ReadRightDone               ; branch to ReadADone if button is NOT pressed (0)
      ; add instructions here to do something when button IS pressed (1)
      LDA $0203                       ; load sprite X position
      CLC                             ; make sure the carry flag is clear
      ADC #$02                        ; A = A + 1
      STA $0203                       ; save sprite X position
    ReadRightDone:                      ; handling this button is done

    RTS
  .endproc

  .proc latch
    LDA #$01
    STA APU_PAD1
    LDA #$00
    STA APU_PAD1                    ; tell both the controllers to latch buttons
    RTS
  .endproc
.endscope
