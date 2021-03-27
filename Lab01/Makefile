# Zlinkowanie
out/lab01: out/lab01.o Makefile
# stworzenie folderu out, flaga -p aby nie rzucił błędu
	mkdir -p out 	
	ld -m elf_i386 out/lab01.o -o out/lab01
#Przetworzenie kodu na plik binarny
out/lab01.o: lab01.S Makefile
	mkdir -p out 
	nasm -f elf32 lab01.S -o out/lab01.o
# posprzątanie repozytorium z wyników kompilacji
clean:
	rm -fv out