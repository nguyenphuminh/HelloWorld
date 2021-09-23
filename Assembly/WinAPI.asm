section .data
	msg db "Hello Wold"
	len equ $ - msg
	handle db 0
	written db 0

section .text
	global start
	extern _GetStdHandle@4
	extern _ExitProcess@4
	extern _WriteConsoleA@20


start:
 
    push    dword -11
    call    _GetStdHandle@4
    mov     [handle], eax

    push    dword 0
    push    written
    push    len
    push    msg
    push    dword [handle]
    call    _WriteConsoleA@20

    push    dword 0
    call    _ExitProcess@4
