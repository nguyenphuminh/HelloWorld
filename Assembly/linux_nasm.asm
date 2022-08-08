BITS 64

segment .text
global _start

_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, message
    mov rdx, message_len
    syscall

    mov rax, 60
    mov rdi, 0
    syscall

segment .rodata
    message: db "Hello world", 10
    message_len: equ $ - message
