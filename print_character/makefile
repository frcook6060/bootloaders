compile: boot.asm
	nasm boot.asm -f bin -o boot.bin

run: compile
	qemu-system-x86_64 boot.bin
	