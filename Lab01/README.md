# Laboratorium 1

## Polecenie

Program szyfruje podane zdanie za pomocą ROT13.

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

1. Należy wpisać w konsoli `./out/lab01` znajdując się w katalogu z plikiem wykonywalnym.
2. Należy wpisać zdanie, które chcemy zaszyfrować.
3. Otrzymamy w konsoli nasze zaszyfrowane zdanie.

Aby przetestować automatycznie działanie naszego programu można użyć pliku `test.sh`, w którym znajduje się przygotowana komenda.
