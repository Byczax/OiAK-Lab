# Laboratorium 2

## Polecenie

napisać program w języku assemblera w architekturze 32-bitowej na platformę Linux. Program powinien zapytać użytkownika o podanie dwóch liczb rzeczywistych, operacji do wykonania:

- Dodawanie (+)

- Odejmowanie (-)

- Mnożenie (*)

- Dzielenie (/)
 
oraz sposób zaokrąglania wyniku FPU:

- Symetrycznie do parzystej

- Do $+\infty$

- do $-\infty$

- Do zera

Program powinien wypisać na standardowe wyjście wynik danej operacji zaokrąglony w wybrany sposób.

## Założenia

- do wczytywania / wyświetlania można używać funkcji z libc (printf, scanf)

- liczby wpisywane są w sposób dziesiętny, np. 1.23456789

- wynik wyświetlamy też w sposobie dziesiętnym

- sposoby zaokrąglania FPU (wg FPU control word): nearest (even if tie), down, up, to zero

## Implementacja

- Wybór operacji jest wykonywany za pomocą następującego menu:
```nasm
1 - Add
2 - Subtract
3 - Multiply
4 - Divine
select action:
```
- Utworzenie bloku .data, który zawiera zadeklarowane dane statyczne

- Utworzenie bloku .text, który zawiera nasz główny kod

- W programie zostały użyte printf oraz scanf do wczytywania oraz wypisywania wartości, na ich podstawie powstały następujące makra:
```nasm
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
```

- Na początku pobieramy od użytkownika dwie liczby zmiennoprzecinkowe ze znakiem

- Następnie użytkownik wybiera w menu typ działania do wykonania
- Oraz tryb zaokrąglenia

- na koniec program wyświetla wyliczoną wartość

Wszystkie działania zostały wykonane za pomocą wbudowanych funkcji działających na liczbach zmiennoprzecinkowych

## Błędne ścieżki (Popełnione błędy)

- Wczytywanie float za pomocą syscall nie wychodziło przez bardzo długi okres czasu, w pewnym momencie się poddałem i przeszedłem na scanf

- Wypisywanie jednoczesne za pomocą syscall oraz printf było błędem, należy wybrać tylko jeden sposób wypisywania

- Nie wiem dlaczego lecz menu nie może korzystać dwa razy ze zmiennej, dużo czasu poświęciłem na próby "resetu" lecz koniec końców zrobiłem po prostu nową zmienną

- Przy wyboru trybu zaokrąglania zamiast zmiany 10 oraz 11 bity, zmieniałem 1 oraz 2

- Zmienne próbowałem umieścić w sekcji `.bss` lecz okazało się że działają one w sekcji `.data`

- Przez duży okres czasu nie mogłem zlinkować programu za pomocą `ld`, po przejściu na `gcc` wszystko się naprawiło, podczas kompilacji rzuca błędy lecz one nie są groźne oraz nie wpływają na kompilację programu


## Wnioski

### Nauka na błędach

- Zmiana trybu zaokrąglania musi być na zmiennej "aktywnej" (`eax` a nie `ax`)

- na końcu programu MUSI być `add esp, 8`, inaczej program nie działa i nie zaokrągla wartości

### Czego się nauczyłem

- Używanie makr, jedna z piękniejszych części assembly według mnie

- Używanie printf

- Używanie scanf

- Przechowywanie innych wartości niż string (float, int)

Przy tym programie wyprodukowałem duże ilości stresu ponieważ program nie chciał działać przez ~6 godzin, dopiero po przejściu na `gcc` oraz `printf/scanf` wszystko się w miarę ułożyło, wczytanie liczby zmiennoprzecinkowej było mordęgą.

## Literatura
<https://cs.fit.edu/~mmahoney/cse3101/float.html>

<https://www.csee.umbc.edu/courses/undergraduate/CMSC313/spring05/burt_katz/lectures/Lect12/floatingpoint.html>

<https://www.website.masmforum.com/tutorials/fptute/#intro>

<https://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-software-developer-vol-1-manual.pdf>



