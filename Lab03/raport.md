# Laboratorium 3

## Polecenie

roszę napisać program w języku asemblera w architekturze 32 bit. Program powinien zapytać użytkownika o dwie całkowite liczby. Użytkownik wpisuje liczby w notacji heksadecymalnej (szesnastkowo). Program powinien wypisać na standardowe wyjście wynik mnożenia tych dwóch liczb.

## Założenia

- do wczytywania / wyświetlania można używać funkcji z libc (printf, scanf)

- liczby są podawane z klawiatury, a więc jako tekst, trzeba je sobie przekonwertować do obliczeń

- podane liczby mogą być bardzo duże, w szczególności możemy się umówić na limit 200 znaków (np CF00A1 - to jest 6 znaków)

- należy wykorzystać odpowiedni algorytm mnożenia dużych liczb (np. mnożenie przez części)

- kolejność wpisywana przez użytkownika jest naturalna, tzn jeżeli wpiszę F0 to jest to dziesiętnie 240

## Implementacja

- Pobranie od użytkownika dwóch wartości "heksadecymalnych"

- pomnożenie podanych liczb i wyrzucenie wyniku w postaci heksadecymalnej
## Błędne ścieżki (Popełnione błędy)

- Problem z wczytaniem wartości heksadecymalnych (Nie znalazłem rozwiązania więc zastosowałem parsowanie stringa)

- Problem z parsowaniem stringów (Rozwiązane poprzez znalezienie rozwiązania w innej składni)

- wyrzucanie dużej ilości zer przy wypisywaniu wyniku

## Wnioski

- Łatwiej znaleźć rozwiązania zadań akademickich w składni AT&T

- Składania AT&T wymaga mniej narzędzi zewnętrznych

- Przejście pomiędzy składniami nie jest zbyt skomplikowane lecz składnia intela jest czytelniejsza

- Studia są trudne pod względem zarządzania czasu
### Nauka na błędach

- Postarać się rozkładać zdania na dłuższe okresy czasowe

- Składnia AT&T wymaga pustej linii na końcu programu

- Visual Studio Code nie wspiera składni AT&T przez co niektóre funkcjonalności oraz kolorowanie składni jest czasami błędne
### Czego się nauczyłem

- składni AT&T

- parsowania stringów

- pracy na wartościach heksadecymalnych

## Literatura

<https://sourceware.org/binutils/docs/as/Macro.html>

<http://x86asm.net/articles/working-with-big-numbers-using-x86-instructions/#Layout-of-Big-Numbers>

<https://stackoverflow.com/questions/40310666/assembly-multiplication>

<https://www.daniweb.com/programming/software-development/threads/466777/x86-ascii-to-hex>

<https://www.nasm.us/doc/nasmdoci.html>