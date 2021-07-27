# Laboratorium 3

## Polecenie

roszę napisać program w języku asemblera w architekturze 32 bit. Program powinien zapytać użytkownika o dwie całkowite liczby. Użytkownik wpisuje liczby w notacji heksadecymalnej (szesnastkowo). Program powinien wypisać na standardowe wyjście wynik mnożenia tych dwóch liczb.
Uwagi:
- liczby są podawane z klawiatury, a więc jako tekst, trzeba je sobie przekonwertować do obliczeń
- podane liczby mogą być bardzo duże, w szczególności możemy się umówić na limit 200 znaków (np CF00A1 - to jest 6 znaków)
- należy wykorzystać odpowiedni algorytm mnożenia dużych liczb (np. mnożenie przez części)

## Wymagania

- Dowolny Linux x86/x64:
  - Wypalamy nasz wybrany system na nośnik zewnętrzny
  - instalujemy zgodnie z instrukcjami pojawiającymi się na ekranie.
  
- Dowolny shell

## Budowanie

Należy wpisać w konsoli `make` .

## Użycie
**UWAGA!** Aby uruchomić plik, należy go oznaczyć że jest plikiem wykonywalnym za pomocą komendy `chmod +x <plik>`

1. Należy wpisać w konsoli `./out/lab03` znajdując się w katalogu z plikiem wykonywalnym.
2. Należy wpisać dwie wartości po kolei, na których chcemy wykonać działanie.
3. Otrzymamy w konsoli wynik wybranych działań.
