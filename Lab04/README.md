# Laboratorium 4


## Polecenie

Napisać program w języku asemblera w architekturze 32 bit. 
Program powinien we wskazanym pliku BMP za pomocą techniki steganografii ukryć wiadomość tekstową podaną przez użytkownika. 
Powinien także umożliwić użytkownikowi odczyt ukrytej wiadomości z pliku BMP. 
Potrzebne są więc dwa tryby działania.

1. Dane ukrywamy na najmłodszych bitach pikseli. Proszę zbadać ile najmłodszych bitów pikseli można wykorzystać, żeby zmiany nie zmieniły znacząco obrazu (empirycznie)

2. Proszę pamiętać że pliki BMP mogą mieć różną liczbę bitów na piksel.

3. Do wczytywania i zapisywania plików, tudzież wczytywania parametrów z linii poleceń można (ale nie trzeba) użyć kodu w C. Natomiast główny algorytm steganograficzny musi być zrobiony w asemblerze.

4. Proszę pamiętać, że pliki BMP mają strukturę i metadane (nagłówki), do operowania na plikach BMP można używać kodu w C

Najważniejsza część programu to algorytm steganograficzny, czyli ukrywanie/odzyskanie informacji z bajtów pikseli i właśnie ta część musi być w asemblerze

można używać gotowych bibliotek C do operowania na plikach BMP