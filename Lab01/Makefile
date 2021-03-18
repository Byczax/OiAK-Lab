out/lab01: out/lab01.o Makefile
	mkdir -p out 
	ld -m elf_i386 out/lab01.o -o out/lab01

out/lab01.o: lab01.S Makefile
	mkdir -p out 
	nasm -f elf32 lab01.S -o out/lab01.o

clean:
	rm -fv out