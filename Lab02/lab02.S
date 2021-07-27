extern printf, scanf; wczytanie zewnętrznych funkcji
global main; eksport symbolu aby był widoczny dla linkera

;=================================================================================
; Stałe prezentujące wywołania systemowe
SYSEXIT: equ 1;
EXIT_SUCCESS: equ 0;

;=================================================================================
; Sekcja zawierająca wszystkie dane potrzebne w programie
SECTION .data

        instruction1: db "Write first value: ", 0; string
        instruction2: db "Write second value: ", 0; string

        format_float_in: db "%f", 0; informacja że wczytujemy float
        format_float_out: db "%f", 10, 0; informacja że wypisujemy float

        float1: times 4 db 0; wczytanie 4 bajtów na float
        float2: times 4 db 0; wczytanie 4 bajtów na float

        operation_option1: db "1 - Add", 10, 0; string z enterem
        operation_option2: db "2 - Subtract", 10, 0; string z enterem
        operation_option3: db "3 - Multiply", 10, 0; string z enterem
        operation_option4: db "4 - Divine", 10, 0; string z enterem

        select_action: db "select action: ", 0; string

        select: db 0; zmienna na integer wyboru

        format_integer_in: db "%d", 0; informacja że wczytujemy integer
        format_integer_in_2: db "%d", 0; informacja że wczytujemy integer

        selected_round: db 0; zmienna na byte zmieniający tryb zaokrąglania

        error: db "ERROR, Wrong choice, ending program.", 10, 0;string z enterem

        round_option1: db "1 - Round to nearest (even)", 10, 0; String z enterem
        round_option2: db "2 - Round up, towards positive infinity", 10, 0; String z enterem
        round_option3: db "3 - Round down, towards negative infinity", 10, 0; String z enterem
        round_option4: db "4 - Round toward zero", 10, 0; String z enterem

        rounding_nearest: dw 100111111111B
        rounding_up:      dw 101111111111B
        rounding_down:    dw 110111111111B
        rounding_zero:    dw 111111111111B

        selected_option1: db "selected option 1", 10, 0;String z enterem
        selected_option2: db "selected option 2", 10, 0;String z enterem
        selected_option3: db "selected option 3", 10, 0;String z enterem
        selected_option4: db "selected option 4", 10, 0;String z enterem

;=================================================================================
; Sekcja zawierająca kod wykonywalny
SECTION .text

; wyświetl zawartość
%macro display 1
        add esp, 4; usuń stare parametry
        push %1; wartość którą chcemy wypisać
        call printf; wywołanie wypisania wartości
%endmacro

; wczytaj wartość od użytkownika
%macro read_input 2
        add esp, 4; usuń stare parametry
        push %1; zmienna do której wczytamy wartość
        push %2; format w jakim mamy wczytać wartość
        call scanf; wywołanie wczytania wartości od użytkownika
%endmacro

; menu wyboru
%macro select_menu 2
        option %1, 1; wywołanie macro wypisującego podaną wartość
        option %1, 2; wywołanie macro wypisującego podaną wartość
        option %1, 3; wywołanie macro wypisującego podaną wartość
        option %1, 4; wywołanie macro wypisującego podaną wartość
        display select_action; wywołanie macro wypisującego podaną wartość

        read_input select, %2; wywołanie macro wczytującego wartość od użytkownika
        mov ecx, select; wczytaj wartość select aby określić wybór użytkownika
        mov bl, [ecx]; odczytaj wartość integer aby ją prównać
        cmp bl, 1; jeżeli wybór 1
        jbe %1_selected1; skocz do wyboru 1
        cmp bl, 2; jeżeli wybór 2
        jbe %1_selected2; skocz do wyboru 2
        cmp bl, 3; jeżeli wybór 3
        jbe %1_selected3; skocz do wyboru 3
        cmp bl, 4; jeżeli wybór 4
        jbe %1_selected4; skocz do wyboru 4
        display error; wypisanie że zły wybór
        call _exit; gdy wprowadzono coś innego to zakończ program
%endmacro

; uproszenie do zapisu w menu wyboru
%macro option 2
        display %1_option%2
%endmacro
;=================================================================================
; Funkcja kończonca program
_exit:
    mov eax, SYSEXIT
    mov ebx, EXIT_SUCCESS
    int 0x80
    ret

;=================================================================================
; Główny blok programu
main:
;---------------- Pobranie wartości od użytkownika --------------
        ; Wupisanie informacji aby podać pierwszą liczbę
        push ebx; Zapisz rejestr
        push ecx; Początki wypisywania
        push instruction1; instrukcja którą chcemy wypisać
        call printf; wywołanie wypisania

        read_input float1, format_float_in; wywołanie macro wczytującego wartość od użytkownika

        display instruction2; wywołanie macro wypisującego podaną wartość

        read_input float2, format_float_in; wywołanie macro wczytującego wartość od użytkownika

        fld dword [float1]; wczytaj float1 aby później wykonać na nim operacje

;---------------- Pobranie działania od użytkownia --------------
        select_menu operation, format_integer_in
        
        operation_selected1:
                display selected_option1; wywołanie macro wypisującego podaną wartość
                fadd dword [float2]; dodanie float2 do float1 [float1+float2]
        jmp round; skok do końca programu

        operation_selected2:
                display selected_option2; wywołanie macro wypisującego podaną wartość
                fsub dword [float2]; odjęcie float2 od float1 [float1-float2]
        jmp round; skok do końca programu

        operation_selected3:
                display selected_option3; wywołanie macro wypisującego podaną wartość
                fmul dword [float2]; pomnożenie float1 przez float 2 [float1*float2]
        jmp round; skok do końca programu

        operation_selected4:
                display selected_option4; wywołanie macro wypisującego podaną wartość
                fdiv dword [float2]; podzielenie float1 przez float 2 [float1/float2]
        jmp round; skok do końca programu

;---------------- Pobranie zaokrąglania od użytkownika --------------
        round:
        select_menu round, format_integer_in_2

        round_selected1:
                display selected_option1; wywołanie macro wypisującego podaną wartość
                or eax, rounding_nearest; ustaw zaokrąglanie domyślne
                jmp end
        round_selected2:
                display selected_option2; wywołanie macro wypisującego podaną wartość
                or eax, rounding_up; ustaw zaokrąglanie w górę do nieskończoności
                jmp end
        round_selected3:
                display selected_option3; wywołanie macro wypisującego podaną wartość
                or eax, rounding_down; ustaw zaorkąglanie w dół do nieskończoności
                jmp end
        round_selected4:
                display selected_option4; wywołanie macro wypisującego podaną wartość
                or eax, rounding_zero; ustaw zaokrąglanie do zera
                jmp end
;---------------------- końcowe wykonania --------------------------------
        end:
        fldcw [eax]; wywołaj wybrane zaokrąglenie
        frndint; zaorkąglij do liczby całkowitej z wybranym trybem zaokrąglania
        fstp qword [esp]; wczytaj policzoną wartość
        push format_float_out; wartość którą chcemy wypisać
        call printf; wywołanie wypisania wartości
        add esp, 8; usunięcie parametrów
        call _exit; wywołanie zakończenia programu
;=================================================================================