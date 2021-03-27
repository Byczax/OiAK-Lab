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
msg: resb READLEN; stworzenie bazy do przechowania wartości wprowadzonej przez użytwkonika
msg_len: resd 1; deklaracja zmiennej przechowującej długość wartości wprowadzonej przez użytkownika

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

        mov [msg_len], eax; system wzraca ilość przeczytanych znaków do eax
        mov ecx, [msg_len]; wczytanie ilości przeczytanych znakóœ do ecx
        mov ebx, 0; wyczyszczenie rejestru ebx
        mov eax, msg; wpisanie na rejest eax wartości wprowadzonej przez użytkownika

        rot13:
        ; sprawdzenie czy jest koniec ciągu znaków
        cmp ecx, 0; sprawdź czy zero
        jz end; jeżeli tak to koniec programu
        ; wczytanie kolejnego znaku
        mov bl, [eax] ; przeniesienie znaku z wskaźnika eax do bl
        ; sprawdzenie czy wczytana wartość jest literą
        cmp bl, 'A';sprawdzenie czy znak jest mniejszy niż A
        jb next; jeżeli tak to pomiń
        cmp bl, 'Z'; sprawdzenie czy znak jest mniejszy lub równy Z
        jbe rotting_big; jeżeli tak to wykonaj ROT13
        cmp bl, 'a'; sprawdzenie czy znak jest mniejszy od a
        jb next; jeżeli tak to pomiń
        cmp bl, 'z'; sprawdzenie czy znak jest mniejszy lub równy z
        jbe rotting_small; jeżeli tak, wykonaj ROT13
        jmp next

        rotting_small:
        ; sprawdzenie czy wyszło poza zakres z
        add bl, 13; dodaj do znaku wartość 13
        cmp bl, 'z'; sprawdzenie czy wartość jest mniejsza lub równa Z
        jbe fixed; jeżeli tak to zatwierdź symbol
        jmp fix; skocz do poprawiania wartości 
        ; sprawdzenie czy wszyło poza zakres Z
        rotting_big:
        add bl, 13; dodaj do znaku wartość 13
        cmp bl, 'Z'; sprawdzenie czy wartość jest mniejsza lub równa z
        jbe fixed; jeżeli tak to zatwierdź symbol
        ; gdy wyszedł poza zakres
        fix:
        sub bl, 26; gdy wartość wyszła poza zakres, odejmij 26
        jmp fixed; zatwierdź wartość
        
        fixed:
        mov  [eax], bl; nadpisz wartość wskazywaną przez eax

        next:
        dec ecx; zmiejsz ecx o 1
        inc eax; zwiększ eax o 1
        jmp rot13; wykonaj ponownie
        end:

        ; wypisanie wejścia od użytkownika
        mov eax, SYSWRITE
        mov ebx, STDOUT
        mov ecx, msg
        mov edx, [msg_len]
        int 0x80 
        ; koniec programu
        mov eax, SYSEXIT
        mov ebx, EXIT_SUCCESS
        int 0x80

        section .data
instruction: db "Write sentece to encrypt: "; polecenie wypisywane na początku
instruction_len: equ $ - instruction; długość polecenia