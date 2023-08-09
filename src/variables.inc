; Registers
PPUCTRL     = $2000                 ; VPHB SINN: NMI enable (V), PPU master/slave (P), sprite height (H), background tile select (B),
PPUMASK     = $2001                 ; BGRs bMmG: color emphasis (BGR), sprite enable (s),
PPUSTATUS   = $2002                 ; READONLY: VSO- ----: vblank (V), sprite 0 hit (S), sprite overflow (O); read resets write pair for $2005/$2006

; Object Attribute Memory
; Stores attributes and positions of sprites (objects).
; Each sprite occupies 4 bytes of memory in the OAM and are accessed by index
OAMADDR     = $2003                 ; aaaa aaaa: OAM read/write address
OAMDATA     = $2004                 ; dddd dddd: OAM utils read/write

PPUSCROLL   = $2005                 ; xxxx xxxx: fine scroll position (two writes: X scroll, Y scroll)
PPUADDR     = $2006                 ; aaaa aaaa: PPU read/write address (two writes: most significant byte, least significant byte)
PPUDATA     = $2007                 ; dddd dddd: PPU utils read/write

; Direct Memory Access
OAMDMA      = $4014                 ; aaaa aaaa: OAM DMA high address

;; Example code to perform a DMA transfer using $4014
;LDA #$XX         ; Load the starting address of the data in CPU memory
;STA $4014        ; Start the DMA transfer
;
;; Wait for the DMA transfer to complete
;LDA $4014
;AND #$80         ; Check bit 7 of $4014
;BNE *-3          ; If bit 7 is set, loop back and check again
;; 256 bytes DMA transfer completed, continue with other operations



; Tints
DARK        = $00
NEUTRAL     = $10
LIGHT       = $20
VERY_LIGHT  = $30

; Colors
BLACK       = $1D
WHITE       = $30
GRAY        = $00
BLUE        = $01
INDIGO      = $02
VIOLET      = $03
MAGENTA     = $04
RED         = $05
SALMON      = $06
ORANGE      = $07
YELLOW      = $08
OLIVE       = $09
GREEN       = $0A
TEAL        = $0B
CYAN        = $0C

; VRAM Addresses
NAMETABLE_A = $2000
ATTRTABLE_A = $23C0
NAMETABLE_B = $2400
ATTRTABLE_B = $27C0
NAMETABLE_C = $2800
ATTRTABLE_C = $2BC0
NAMETABLE_D = $2C00
ATTRTABLE_D = $2FC0
BG_COLOR    = $3F00
BG_PAL0     = $3F01
BG_PAL1     = $3F05
BG_PAL2     = $3F09
BG_PAL3     = $3F0D
SPR_PAL0    = $3F11
SPR_PAL1    = $3F15
SPR_PAL2    = $3F19
SPR_PAL3    = $3F1D


;; APU defines
APU_PULSE1CTRL  = $4000             ; Pulse #1 Control Register (W)
APU_PULSE1RAMP  = $4001             ; Pulse #1 Ramp Control Register (W)
APU_PULSE1FTUNE = $4002             ; Pulse #1 Fine Tune (FT) Register (W)
APU_PULSE1CTUNE = $4003             ; Pulse #1 Coarse Tune (CT) Register (W)
APU_PULSE2CTRL  = $4004             ; Pulse #2 Control Register (W)
APU_PULSE2RAMP  = $4005             ; Pulse #2 Ramp Control Register (W)
APU_PULSE2FTUNE = $4006             ; Pulse #2 Fine Tune Register (W)
APU_PULSE2STUNE = $4007             ; Pulse #2 Coarse Tune Register (W)
APU_TRICTRL1    = $4008             ; Triangle Control Register #1 (W)
APU_TRICTRL2    = $4009             ; Triangle Control Register #2 (?)
APU_TRIFREQ1    = $400A             ; Triangle Frequency Register #1 (W)
APU_TRIFREQ2    = $400B             ; Triangle Frequency Register #2 (W)
APU_NOISECTRL   = $400C             ; Noise Control Register #1 (W)
;;APU_ = $400D  ; Unused (???)
APU_NOISEFREQ1  = $400E             ; Noise Frequency Register #1 (W)
APU_NOISEFREQ2  = $400F             ; Noise Frequency Register #2 (W)
APU_MODCTRL     = $4010             ; Delta Modulation Channel Register (W)
APU_MODDA       = $4011             ; Delta Modulation D/A Register (W)
APU_MODADDR     = $4012             ; Delta Modulation Address Register (W)
APU_MODLEN      = $4013             ; Delta Modulation Data Length Register (W)
APU_SPR_DMA     = $4014             ; Sprite DMA Register (W)
APU_CHANCTRL    = $4015             ; Sound/Vertical Clock Signal Register (R)
APU_PAD1        = $4016             ; Joypad #1 (RW)
APU_PAD2        = $4017             ; Joypad #2/SOFTCLK (R)
APU_FRAMECTR    = $4017             ; Frame Counter (W)
