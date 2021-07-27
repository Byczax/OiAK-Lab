# zbudowanie kodu do pliku binarnego
build: 
	mkdir -p out
	as --32 decrypt.S -g -o out/decrypt.o
	as --32 encrypt.S -g -o out/encrypt.o
# ld out/encrypt.o -m elf_i386 -o out/encrypt
# ld out/decrypt.o -m elf_i386 -o out/decrypt
# gcc -c -m32 lab04.c
# gcc  -o out/lab04 -g out/lab04.o
	gcc -o out/lab04 -m32 -g lab04.c
	

# posprzątanie repozytorium z wyników kompilacji
clean:
	rm -fv out