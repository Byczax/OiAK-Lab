# Laboratorium 4

## Polecenie

Napisać program w języku asemblera w architekturze 32 bit.
Program powinien we wskazanym pliku BMP za pomocą techniki steganografii ukryć wiadomość tekstową podaną przez użytkownika.
Powinien także umożliwić użytkownikowi odczyt ukrytej wiadomości z pliku BMP.
Potrzebne są więc dwa tryby działania.

## Założenia

1. Dane ukrywamy na najmłodszych bitach pikseli. Proszę zbadać ile najmłodszych bitów pikseli można wykorzystać, żeby zmiany nie zmieniły znacząco obrazu (empirycznie)

2. Proszę pamiętać że pliki BMP mogą mieć różną liczbę bitów na piksel.

3. Do wczytywania i zapisywania plików, tudzież wczytywania parametrów z linii poleceń można (ale nie trzeba) użyć kodu w C. Natomiast główny algorytm steganograficzny musi być zrobiony w asemblerze.

4. Proszę pamiętać, że pliki BMP mają strukturę i metadane (nagłówki), do operowania na plikach BMP można używać kodu w C

Najważniejsza część programu to algorytm steganograficzny, czyli ukrywanie/odzyskanie informacji z bajtów pikseli i właśnie ta część musi być w asemblerze

można używać gotowych bibliotek C do operowania na plikach BMP

## Implementacja

Pobranie od użytkownika wraz z uruchomieniem programu parametrów:

- flagę: `-d`=decrypt lub `-e`=encrypt
- Nazwę pliku graficznego (`.bmp`)
- Nazwę pliku tekstowego (`.txt`)

## Błędne ścieżki (Popełnione błędy)

- za dużo referencji `add`, `cmp`, `mov`

- za pomocą `gcc` kompilujemy składnię AT&T

## Wnioski

- C jest łatwiejsze

### Czego się nauczyłem

- Podstaw Steganografii

- Lepiej pisać w C
  - rozmieszczenie funkcji
  - Specjalnych typów
  - Parsowanie argumentów
  - Wyświetlanie menu z instrukcją obsługi

## Literatura

<https://en.wikipedia.org/wiki/Steganography>

<https://en.wikipedia.org/wiki/RGBA_color_model>

<https://www.geeksforgeeks.org/data-type-file-c/>

<https://en.wikipedia.org/wiki/Command-line_argument_parsing>

<https://explainshell.com/>
