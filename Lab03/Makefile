# Zlinkowanie
out/lab03: out/lab03.o Makefile
	ld out/lab03.o -m elf_i386 -o out/lab03 
#Przetworzenie kodu na plik binarny
out/lab03.o: lab03.S Makefile
# stworzenie folderu out, flaga -p aby nie rzucił błędu
	mkdir -p out 
	as --32 lab03.S -g -o out/lab03.o
# posprzątanie repozytorium z wyników kompilacji
clean:
	rm -fv out