format ELF64 executable 3
segment readable executable

_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, message
    mov rdx, message_len
    syscall

    mov rax, 60
    mov rdi, 0
    syscall

segment readable
    message: db "Hello world", 10
    message_len = $ - message
