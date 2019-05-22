; Macros for the boot sector
%define LOOP_MAX 100
%define LOOP_STR "Hello, World from no operating system :D"
; nasm boot.asm -f bin -o boot
; qemu-system-x86_64 boot.bin
[bits 16]                       ; x86 processors start with real mode so all programmes are limited to 16 bit operations
[ORG 0x7c00]                    ; MBR starts at 0x0000:0x7c00 memory location

mov ax, 0
start_loop:
    mov si, hello_str
    call print_str
    inc ax
    cmp ax, LOOP_MAX
    jl start_loop

jmp $                           ; This is a simple infinate loop that will hang the bootloader


print_char:
    pusha       ; Safty
    mov ah, 0x0e ; Tells bios that we need to print one character on screen
    mov bh, 0x00 ; Page No
    mov bl, 0x07 ; Light Grey

    int 0x10 ; Call video interrupt
    popa        ; Safty
    ret


print_str:
    pusha
    print_str_loop:
        mov al, [si]
        inc si
        or al, al
        jz print_str_exit
        call print_char
        jmp print_str_loop
    print_str_exit:
    popa
    ret

hello_str: db LOOP_STR, 0x0a, 0x0d, 0

times 510 - ($ - $$) db 0       ; because bootable boot sector requires 512 bytes of memory, fill the rest with 0
dw 0xaa55                       ; This is the magic number that tells bios its bottable 510 = 0x55 and 511 = 0xaa, its backwords due to x86 processors being little indy
