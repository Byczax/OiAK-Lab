# Zlinkowanie
out/lab02: out/lab02.o Makefile
# stworzenie folderu out, flaga -p aby nie rzucił błędu
	mkdir -p out 	
# ld -m elf_i386 out/lab02.o -o out/lab02 
	gcc out/lab02.o -g -m32 -o out/lab02 
#Przetworzenie kodu na plik binarny
out/lab02.o: lab02.S Makefile
	mkdir -p out 
	nasm -f elf32 lab02.S -o out/lab02.o
# posprzątanie repozytorium z wyników kompilacji
clean:
	rm -fv out