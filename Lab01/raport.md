# Laboratorium 1

## Polecenie

Proszę napisać program w języku assemblera w architekturze 32-bitowej na platformę Linux. Program powinien zapytać użytkownika o podanie zdania, wczytać je ze standardowego wejścia, a następnie wyświetlić na standardowe wyjście to samo zdanie zaszyfrowane za pomocą ROT13 (https://pl.wikipedia.org/wiki/ROT13)Przykład:

    $ ./rot13
    Podaj zdanie: Ala ma kota
    ROT13: Nyn zn xbgn

### Założenia:

* maksymalna wielkość bufora na zdanie wpisane przez użytkownika to 100 znaków
* ROT13 powinien poprawnie zamieniać wielkie litery na wielkie a małe na małe
* Wszystko co nie jest literą alfabetu łacińskiego pozostaje bez zmian, np żółć  pozostaje takie samo po zaszyfrowaniu ROT13

#