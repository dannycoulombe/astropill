build_rom:
	mkdir -p build
	ca65 src/main.s -g -o src/main.o
	ld65 -C src/main.cfg -o build/main.nes src/main.o --mapfile src/main.map --dbgfile src/main.dbg
	#cl65 src/main.s --verbose --target nes -o build/main.nes -O
	rm src/*.o
	rm src/*.map
	rm src/*.dbg

run: build_rom
	fceux build/main.nes