# Accronyms
`nmi` Non-Maskable Interrupt  
`irq` IRQ (Interrupt Request)

# 6502
- Stack is always located in the first 1K of memory on systems using a 6502 CPU (to be more precise: in the range 100h...1FFh)

## PPUMASK
The PPUMASK register is an 8-bit register, and each bit within the register controls a specific aspect of the PPU's behavior. Here is a breakdown of the individual bits and their functions:

- Bit 7: `Grayscale`: (0: normal color; 1: All palette entries with 0x30, effectively producing a monochrome display; note that colour emphasis STILL works when this is on!))
- Bit 6: `Disable background clipping in leftmost 8 pixels of screen`
- Bit 5: `Disable sprite clipping in leftmost 8 pixels of screen`
- Bit 4: `Enable background rendering`
- Bit 3: `Enable sprite rendering`
- Bit 2: `Intensify reds`: (and darken other colors)
- Bit 1: `Intensify greens`: (and darken other colors)
- Bit 0: `Intensify blues`: (and darken other colors)

## VBlank
After drawing the screen once, the electron beam must return to the top left corner, ready to
start the next frame. The time it takes to do this is known as the Vertical Blank period (V-
Blank).