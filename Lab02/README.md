# Laboratorium 2

## Polecenie

Program w języku assemblera w architekturze 32-bitowej na platformę Linux. Program powinien zapytać użytkownika o podanie dwóch liczb rzeczywistych, operacji do wykonanie (+ - * /) oraz sposobu zaokrąglania wyniku FPU.
Program powinien wypisać na standardowe wyjście wynik danej operacji zaokrąglony w wybrany sposób.

* do wczytywania / wyświetlania można używać funkcji z libc (printf, scanf)
* liczby wpisywane są w sposób dziesiętny, np. 1.23456789
* wynik wyświetlamy też w sposobie dziesiętnym
* sposoby zaokrąglania FPU (wg FPU control word): nearest (even if tie), down, up, to zero

## Wymagania

- Dowolny Linux x86/x64:
  - Wypalamy nasz wybrany system na nośnik zewnętrzny
  - instalujemy zgodnie z instrukcjami pojawiającymi się na ekranie.
  
- NASM: W zależności od dystrybucji wykorzystujemy:
    - Debian: `sudo apt-get install nasm` \
    ( na starszych wersjach zamiast `sudo` należy użyć `su` )
    - RedHat: `sudo yum install nasm`
    - Arch: `sudo pacman -S nasm`
  
- Dowolny shell

## Budowanie

Należy wpisać w konsoli `make` .

## Użycie
**UWAGA!** Aby uruchomić plik, należy go oznaczyć że jest plikiem wykonywalnym za pomocą komendy `chmod +x <plik>`

1. Należy wpisać w konsoli `./out/lab02` znajdując się w katalogu z plikiem wykonywalnym.
2. Należy wpisać dwie wartości po kolei, na których chcemy wykonać działanie.
3. Otrzymamy w konsoli wynik wybranych działań.
