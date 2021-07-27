.globl _start # flaga globalna
# stałe używane w programie
.equ SYSEXIT32, 1
.equ SYSCALL32, 0x80
.equ SYSWRITE, 4
.equ SYSREAD, 3
.equ STDOUT, 1
.equ STDIN, 0
.equ BYTES, 1024
# =============================================================
.section .data
	hex_info: .long 0x10 # informacja że działamy na hexadecymalnych wartościach
	size: .long 200 # maksymalna ilość znaków
	changeable_size: .long 0
	size_count: .long 0

	instruction1: .ascii "Write first value: \0" # powiadomienie dla użytkownika
	instruction1_length = .-instruction1 # długość powiadomienia

	instruction2: .ascii "Write second value: \0" # powiadomienie dla użytkownika
	instruction2_length = .-instruction2 # długość powiadomienia
	
	result_info: .ascii "Result: \0" # powiadomienie dla użytkownika
	mul_result_length = .-result_info # długość powiadomienia

	end_enter: .ascii "\n\0" # powiadomienie dla użytkownika
	end_enter_length = .-end_enter # długość powiadomienia
# =============================================================
.section .bss

.lcomm number1, BYTES
.lcomm number2, BYTES
.lcomm counter, BYTES
.lcomm number1_value, 4
.lcomm number1_length, 4
.lcomm number2_length, 4
.lcomm number2_length2, 4
.lcomm result, 2048
.lcomm final_result, 2048
.lcomm carry, 1
.lcomm final_carry, 1

# ==============================================================
.section .text

# wypisanie instrukcji i wczytanie wartości od użytkownika
.macro display text, text_length
movl $SYSWRITE, %eax
movl $STDOUT, %ebx
movl \text, %ecx
movl \text_length, %edx
int $SYSCALL32
.endm

# wczytaj od użytkownika wartość
.macro read_from_user parameter
	movl $SYSREAD, %eax
	movl $STDIN, %ebx
	movl \parameter, %ecx
	movl $BYTES, %edx
	int $SYSCALL32
	decl %eax
	decl %eax
.endm

# zakończenie programu
_exit:
	movl $SYSEXIT32, %eax
	movl $0, %ebx
	int $SYSCALL32
ret

# początek programu
_start:
	movl size, %eax # wczytaj
	movl %eax, changeable_size # wczytanie maksymalnej wartości
	movl $0, %eax # zerowanie rejestru

	display $instruction1, $instruction1_length
	read_from_user $number1

	movl %eax, number1_length # wczytanie do zmiennej długość wpisanej wartosci

	display $instruction2, $instruction2_length
	read_from_user $number2

	movl %eax, number2_length # wczytanie do zmiennej długość wpisanej wartosci
	
	movl $0, %edx
	movl number2_length, %edx
	movl %edx, number2_length2
	movl $0, %edx

prepare_result:
	cmpl $0, number1_length
	jl resulting_3
	movl $0, %edi
	movl size, %edi
	decl %edi

reset_result:
	movb $0, result(,%edi,1)
	decl %edi
	cmpl $0, %edi
	je reseted_result
	jmp reset_result

reseted_result:
	movl size, %edi
	movl $0, %ecx

	movb $0xA, result(,%edi,1)
	incl %edi

	movb $0xD, result(,%edi,1)
	decl %edi

	decl %edi
	movl size, %ecx
	subl changeable_size, %ecx
	decl changeable_size

loop:
	cmpl $0, %ecx
	je begin
	movb $0, result(,%edi,1)
	decl %edi
	decl %ecx
	jmp loop
	
begin:
	movl $0, %ecx
	movl $0, %edx
	movl $0, number1_value
	
	movl number1_length, %edx # wczytaj długość pierwszego numeru
	cmpl $0, %edx
	jl number1_end
	
	movl $0, %ebx # zeruj ebx
	
	decl number1_length	# dekrementuj długość aby wczytać kolejną wartość
	movb number1(,%edx,1), %bl

	pushl $hex_info
	pushl %ebx
	call char_to_int
	addl $8, %esp
	movl %eax, number1_value
	jmp cont

number1_end:
	movl $0, %eax
	movl %eax, number1_value
	
cont:
	movl number2_length2, %edx
	movl %edx, number2_length
  
continue:
	movl $0, %eax
	movl number2_length, %edx
	cmpl $0, %edx
	jl number2_end
	decl number2_length	
	movb number2(,%edx,1), %bl
	pushl $hex_info
	pushl %ebx
	call char_to_int
	addl $8, %esp
	jmp multiplication

number2_end:
	cmpl $0, number1_length
	jge multiplication
	cmpl $0, number2_length
	jge multiplication
	cmpl $0, carry
	jg multiplication
	jmp resulting

multiplication:
	movl $0, %ecx
	imull number1_value, %eax
	addl carry, %eax # dodaj carry
	movb $0, carry # zeruj carry

compare:
	cmpl hex_info, %eax
	jb save_result
	subl hex_info, %eax # wynik większy niż hex_info, odejmij hex_info
	incl %ecx
	jmp compare

char_to_int:
	pushl %ebp
	movl %esp, %ebp
	movl $0, %ebx
	movl 8(%ebp), %ebx

	# odejmij '0' od znaku
	subb $0x30, %bl

	# jeśli wartość mniejsza od 10, idź na koniec
	cmpb $10, %bl
	jb char_to_int_end

	# duże litery
	subb $0x7, %bl
	cmpb $0x10, %bl
	jb char_to_int_end

	# małe litery
	subb $0x20, %bl

char_to_int_end:
	movl %ebx, %eax
	movl %ebp, %esp
	popl %ebp
	ret

int_to_char:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %eax
	addb $0x30, %al
	# dla wartości <= '9'
	cmpb $0x39, %al
	jbe int_to_char_end
	addb $7, %al

int_to_char_end:
	movl %ebp, %esp
	popl %ebp
	ret

final_result_add:
	pushl %ebp
	movl %esp, %ebp
	movl $0, %edx
	movl size, %edx
	decl %edx

final_result_add_1:
	movl $0, %ebx
	movb result(,%edx,1), %bl
	movb final_result(,%edx,1), %al
	addl %ebx, %eax
	addl final_carry, %eax
	movl $0, final_carry
	cmpl hex_info, %eax
	jl final_result_add_2
	movl $0, %ecx
	subl hex_info, %eax
	incl %ecx
	movl %ecx, final_carry
	
final_result_add_2:
	cmpl $0, number1_length
	jl final_result_add_3
	movb %al, final_result(,%edx,1)
	decl %edx
	cmpl $0, %edx
	jge final_result_add_1
	jmp final_result_add_end

final_result_add_3:
	pushl %eax
	call int_to_char
	addl $4, %esp
	movb %al, final_result(,%edx,1)
	decl %edx
	cmpl $0, %edx
	jge final_result_add_1

final_result_add_end:
	movl %ebp, %esp
	popl %ebp
	ret

initially_zeros:
	movl $0, %eax
	movl $0, %ecx
	movl size, %eax
	movl %eax, size_count
	addl $2, size_count
	movl $0, %eax

initial_removing_zeros:
	movl $0, %edx
	decl size_count
	movb final_result(,%edx,1), %al
	incl %edx
	cmpl $'0', %eax
	je remove_zeros
ret
	
remove_zeros:
	movl $0, %eax
	movb final_result(,%edx,1), %al
	decl %edx
	movb %al, final_result(,%edx,1)
	addl $2, %edx
	cmpl size_count, %edx
	jle remove_zeros

redundant_delete:
	decl %edx
	movl $0, final_result(,%edx,1)
	jmp initial_removing_zeros

save_result:
	movl %ecx, carry
	movb %al, result(,%edi,1) # zapisz wynik
	decl %edi # dekrementacja rejestru z wynikiem
	
	movl $0, %ecx
	movl number2_length, %ecx
	addl $1, %ecx
	cmpl $0, %ecx 
	jg continue # jeżeli wartość instnieje to kontynuuj
	movl $0, %ecx
	movl carry, %ecx
	cmpl $0, %ecx
	jne continue

resulting:
	decl %edi
	cmpl $0, %edi
	jl resulting_2
	movb $0, result(,%edi,1) # zapisz wynik
	jmp resulting

resulting_2:
	call final_result_add
	jmp prepare_result

resulting_3:
# wyświetlenie końcowego wyniku
	call initially_zeros
	display $result_info, $mul_result_length
	display $final_result, $BYTES
	display $end_enter, $end_enter_length
# zakończenie programu
call _exit
