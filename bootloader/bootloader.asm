ORG 0x7c00
BITS 16

jmp 0x0000:start

start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7c00
    sti
    cld

    mov ax, 0x003
    int 0x10

    mov si, message

print:
    lodsb
    cmp al, 0
    je .done

    mov ah, 0x0e
    int 0x10

    jmp print

.done: 
    cli
    hlt
    jmp .done

message: db 'Welcome to GoOS!', 13, 10, 0

times  510-($-$$) db 0
dw 0xAA55
