; nasm boot.asm -f bin -o boot
; qemu-system-x86_64 boot.bin
[bits 16]                       ; x86 processors start with real mode so all programmes are limited to 16 bit operations
[ORG 0x7c00]                    ; MBR starts at 0x0000:0x7c00 memory location

jmp $                           ; This is a simple infinate loop that will hang the bootloader

times 510 - ($ - $$) db 0       ; because bootable boot sector requires 512 bytes of memory, fill the rest with 0
dw 0xaa55                       ; This is the magic number that tells bios its bottable 510 = 0x55 and 511 = 0xaa, its backwords due to x86 processors being little indy
