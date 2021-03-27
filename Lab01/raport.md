# Laboratorium 1

## Polecenie

Napisać program w języku assemblera w architekturze 32-bitowej na platformę Linux. Program powinien zapytać użytkownika o podanie zdania, wczytać je ze standardowego wejścia, a następnie wyświetlić na standardowe wyjście to samo zdanie zaszyfrowane za pomocą ROT13 (https://pl.wikipedia.org/wiki/ROT13)Przykład:

    $ ./rot13
    Podaj zdanie: Ala ma kota
    ROT13: Nyn zn xbgn

### Założenia:

* Maksymalna wielkość bufora na zdanie wpisane przez użytkownika to 100 znaków
* ROT13 powinien poprawnie zamieniać wielkie litery na wielkie a małe na małe
* Wszystko co nie jest literą alfabetu łacińskiego pozostaje bez zmian, np żółć  pozostaje takie samo po zaszyfrowaniu ROT13

### Implementacja

* Deklaracja stałych używanych potem do łatwiejszego zrozumienia kodu
* Utworzenie bloku .data, który zawiera zadeklarowane dane statyczne
* Utworzenie bloku .bss, który zawiera statycznie zadeklarowane zmienne, którym nie przydzielono jeszcze wartości
* Utworzenie bloku .text, który zawiera nasz główny kod

* Na początku wypisujemy informację co należy zrobić, następnie wczytujemy wartość od użytkownika za pomocą syscall\
**Przykładowy blok syscall**
```nasm
mov eax, SYSWRITE; wybieramy syscall o numerze syswrite
mov ebx, STDOUT; informujemy gdzie chcemy wypisać (file descryptor, w naszym przypadku konsola)
mov ecx, instruction; podajemy wartość do wypisania
mov edx, instruction_len; podajemy długość wartości do wypisania
int 0x80 ; wykonanie syscalla
```
* Po odczytaniu wartości od użytkownika odczytujemy długość wprowadzonego ciągu znaków i przygotowujemy się do iteracji po ciągu znaków.
```nasm
mov [msg_len], eax; system wzraca ilość przeczytanych znaków do eax
mov ecx, [msg_len]; wczytanie ilości przeczytanych znakóœ do ecx
mov ebx, 0; wyczyszczenie rejestru ebx
mov eax, msg; wpisanie na rejestr eax wartości wprowadzonej przez użytkownika
```
* Gdy jesteśmy przygotowani do iteracji to zaczynamy sprawdzać każdy znak:
  * Czy znak zawiera się w przedziale dużych liter
  * Czy znak zawiera się w przedziale małych liter
* Gdy żaden z punktów nie zostanie spełniony wtedy znak jest pomijany, w przeciwnym wypadku wykonujemy algorytm ROT13:
  * Dodanie do wartości znaku liczby 13
  * Sprawdzenie czy wartość znaku wyszła poza zakres małych/dużych liter
  * jeżeli tak wtedy przywracamy wartość znaku do przedziału poprzez odjęcie wartości 26
* Gdy znak przeszedł przez powyższe procedury to zostaje nadpisana wartość znaku w rejestrze eax wartością znaku zaszyfrowanego
* Gdy wszystkie znaki przejdą procedurę, pętla zostanie przerwana
* Wypisanie zaszyfrowanego ciągu znaku użytkownikowi

### Błędne ścieżki (Popełnione błędy)

* Zamiast wskaźników na wartości, napisałem wartości, przez to na początku program nie działał, następnie wypisywał błędne znaki pod koniec ponieważ wychodził poza zakres
* Pogubiłem się w sprawdzaniu znaków, przez co duże litery nie działały, rozwiązałem to poprzez podział na osobne sprawdzanie małych oraz dużych liter
* Nie dałem `jmp next` gdy wartość była większa niż małe z

### Wnioski

#### Nauka na błędach
* Warto komentować każdą linijkę kodu ponieważ można się pogubić
* Kod dzielimy na bloki wykonywalne
* Warto sprawdzić warunki brzegowe, najlepiej wszystkie jeżeli jest taka możliwość
#### Czego się nauczyłem

Wszystko było nowe ponieważ po raz pierwszy piszę w assembly oraz na systemie operacyjnym Linux.
Jeżeli mam wymienić najciekawsze nowości to:

* Jak działa syscall (wczytywanie oraz wypisywanie wartości)
* Testowanie programu za pomocą komendy w bashu (oraz konwersja komendy w formę pliku)
* Manipulacja wartościami w rejestrach

Najtrudniejszym elementem dla mnie było zrozumienie syscall, w szczególności sysread, nie wiedziałem gdzie znajdzie się wczytana wartość.

Drobnym problemem było znalezienie w którym miejscu w programie wychodzimy poza zakres.

### Literatura
Stąd brałem wartości do syscall: <https://syscalls.w3challs.com/?arch=x86>


