org 0x7C00
bits 16

%define ENDL 0x0D,0x0A

start:
    jmp main

;
; puts - a function which would print the string in the bootloader
;

puts:
    push si
    push ax

.loop:
    lodsb
    or al,al
    je .done
    mov ah,0x0e
    int 0x10
    jmp .loop

.done:
    pop ax
    pop si
    ret

puts_num:
    mov al,1

.loop:
    push ax

    add al,'0'
    mov ah,0x0e
    int 0x10

    pop ax

    inc al
    cmp al,6
    jne .loop

    ret

main:
    ; setting up data segments
    mov ax,0
    mov ds,ax
    mov es,ax

    ; setting up stack segment
    mov ss,ax
    mov sp,0x7C00

    ; printing "Hello, World!\n"
    ; mov si,10
    ; call puts

    call puts_num

.halt:
    hlt
    jmp .halt

str: db 'Hello, World!',ENDL,0

times 510-($-$$) db 0
dw 0AA55h
