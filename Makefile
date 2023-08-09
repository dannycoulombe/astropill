build_rom:
	mkdir -p build
	cl65 src/main.s --verbose --target nes -o build/main.nes -O
	rm src/*.o

run: build_rom
	fceux build/main.nes