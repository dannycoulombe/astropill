.scope APU
  .proc enable
    LDA #$0F
    STA APU_CHANCTRL
    RTS
  .endproc

  .proc playSong
    ldy #<music_data_astropill_intro
    ldy #>music_data_astropill_intro

    lda #1 ; NTSC
    jsr famistudio_init
    lda #0
    jsr famistudio_music_play

    RTS
  .endproc

  .proc test
    lda #%00000001
    sta $4015 ;enable Square 1

    ;square 1
    lda #%10111111 ;Duty 10, Length Counter Disabled, Saw Envelopes disabled, Volume F
    sta $4000

    lda #$C9    ;0C9 is a C# in NTSC mode
    sta $4002   ;low 8 bits of period
    lda #$00
    sta $4003   ;high 3 bits of period
    RTS
  .endproc
.endscope
