[bits 16]
[org 0x7c00]

mov al, 65
call print_char

jmp $

print_char:
    pusha       ; Safty
    mov ah, 0x0e ; Tells bios that we need to print one character on screen
    mov bh, 0x00 ; Page No
    mov bl, 0x07 ; Light Grey

    int 0x10 ; Call video interrupt
    popa        ; Safty
    ret

times 510 - ($ - $$) db 0
dw 0xaa55