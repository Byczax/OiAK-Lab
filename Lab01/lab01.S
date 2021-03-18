global _start; eksport symbolu aby był widoczny dla linkera
; Stworzenie stałych reprezntująych wywołania systemowe
SYSEXIT: equ 1;
EXIT_SUCCESS: equ 0;
SYSREAD: equ 3;
SYSWRITE: equ 4;
SYSOPEN: equ 5;
STDIN: equ 0;
STDOUT: equ 1;

        section .bss


        section .text
_start: 
        mov eax, SYSREAD
        mov ebx, STDIN

        

        mov eax, SYSWRITE
        mov ebx, STDOUT
        mov ecx, msg
        mov edx, msg_len
        int 0x80 

        mov eax, SYSEXIT
        mov ebx, EXIT_SUCCESS
        int 0x80

        section .data
message:    
        
msg:
msg_len: msg_len equ $ - msg
answer: db ""


