global _start; eksport symbolu aby był widoczny dla linkera
; Stworzenie stałych reprezntująych wywołania systemowe
SYSEXIT: equ 1;
EXIT_SUCCESS: equ 0;
SYSREAD: equ 3;
SYSWRITE: equ 4;
SYSOPEN: equ 5;
STDIN: equ 0;
STDOUT: equ 1;
READLEN: equ 1024;

        section .bss
msg: resb READLEN
msg_len: resd 1

        section .text
_start: 
        ; wypisanie instrukcji co należy zrobić
        mov eax, SYSWRITE
        mov ebx, STDOUT
        mov ecx, instruction
        mov edx, instruction_len
        int 0x80 
        ; wczytanie wejścia od użytkownika
        mov eax, SYSREAD
        mov ebx, STDIN
        mov ecx, msg
        mov edx, READLEN
        int 0x80

        mov [msg_len], eax
        mov ecx, [msg_len]
        

        rot13:
        ; sprawdzenie czy jest koniec ciągu znaków
        cmp ecx, 0
        jz end
        ; wczytanie kolejnego znaku
        mov bl, [eax]
        ; sprawdzenie czy wczytana wartość jest literą
        cmp bl, 'A'
        jb next
        cmp bl, 'Z'
        jbe rotting
        cmp bl, 'a'
        jb next
        cmp bl, 'z'
        jbe rotting

        rotting:
        ; sprawdzenie czy wyszło poza zakres z
        add bl, 13
        cmp bl, 'z'
        jbe fixed
        ; sprawdzenie czy wszyło poza zakres Z
        cmp bl, 'Z'
        jbe fixed
        ; gdy wyszedł poza zakres
        sub bl, 26
        jmp fixed
        jmp next
        
        fixed:
        mov  bl, [eax]

        next:
        dec ecx
        inc eax
        jmp rot13
        end:
        
        ; wypisanie wejścia od użytkownika
        mov eax, SYSWRITE
        mov ebx, STDOUT
        mov ecx, msg
        mov edx, msg_len
        int 0x80 
        ; koniec programu
        mov eax, SYSEXIT
        mov ebx, EXIT_SUCCESS
        int 0x80

        section .data
instruction: db "Write sentece to encrypt: "
instruction_len: equ $ - instruction
answer: db ""


