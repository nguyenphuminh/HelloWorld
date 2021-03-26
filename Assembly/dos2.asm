hello3-DOS.asm - single-segment, 16-bit "hello world" program
;
; Use DOS 2.0's service 40 to output a length-delimited string.
;
; assemble with "nasm -f bin -o hi.com hello3-DOS.asm"

    org  0x100          ; .com files always start 256 bytes into the segment

; int 21h needs...
    mov  dx, msg        ; message's address in dx
    mov  cx, len
    mov  bx, 1          ; Device/handle: standard out (screen)
    mov  ah, 0x40       ; ah=0x40 - "Write File or Device"
    int  0x21           ; call dos services

    mov  ah, 0x4c       ; "terminate program" sub-function
    int  0x21           ; call dos services

msg     db 'New hello, World!', 0x0d, 0x0a   ; message
len     equ $ - msg     ;msg length