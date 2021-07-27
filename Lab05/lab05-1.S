
.section .text
.global assembly_filter # set global flag

assembly_filter:

    # read input
    pushl %ebp

    movl %esp, %ebp

    pushl %ebx
    pushl %edi
    pushl %esi

    movl 8(%ebp), %ebx
    movl 12(%ebp), %ecx
    movl 16(%ebp), %edx
    movl 20(%ebp), %eax
    movl 24(%ebp), %edi
    decl 12(%ebp)

save_pixel_copy:
    movb (%ebx), %cl
    movb %cl, (%edi)

    incl %ebx
    incl %edi

    decl %eax

    cmpl $0, %eax

    jne save_pixel_copy


save_outer_pixels:
    movl 20(%ebp), %edx

    movb (%ebx), %cl
    movb %cl, (%edi)

    incl %ebx
    incl %edi

    movb (%ebx), %cl
    movb %cl, (%edi)
    
    incl %ebx
    incl %edi

    movb (%ebx), %cl
    movb %cl, (%edi)

    incl %ebx
    incl %edi
    
    subl $3, %edx

    movl 16(%ebp), %esi

    shll %esi

    addl 16(%ebp), %esi

    subl $6, %esi


save_inner_pixels:
    movl $0, %ecx
    movl $0, %eax

    movb (%ebx), %cl

    addl %ecx, %eax

    subl $3, %ebx

    movb (%ebx), %cl

    addl %ecx, %eax

    subl 20(%ebp), %ebx

    movb (%ebx), %cl

    addl %ecx, %eax
    addl $3, %ebx

    movb (%ebx), %cl

    addl %ecx, %eax
    addl $3, %ebx

    movb (%ebx), %cl

    addl %ecx, %eax
    addl 20(%ebp), %ebx

    movb (%ebx), %cl

    addl %ecx, %eax
    addl 20(%ebp), %ebx

    movb (%ebx), %cl

    addl %ecx, %eax

    subl $3, %ebx

    movb (%ebx), %cl

    addl %ecx, %eax

    subl $3, %ebx

    movb (%ebx), %cl

    addl %ecx, %eax

    subl 20(%ebp), %ebx

    addl $3, %ebx

    movl $9, %ecx

    div %cl

    movb %al, (%edi)

    incl %ebx
    incl %edi

    decl %esi
    decl %edx

    cmpl $0, %esi

    jne save_inner_pixels


fill_out:
    cmpl $0, %edx

    je end_row

    movb (%ebx), %cl
    movb %cl, (%edi)

    incl %ebx
    incl %edi

    decl %edx

    jmp fill_out


end_row:
    decl 12(%ebp)

    cmpl $1, 12(%ebp)

    jne save_outer_pixels

    movl 20(%ebp), %edx


save_end_copy:
    movb (%ebx), %cl
    movb %cl, (%edi)

    incl %ebx
    incl %edi

    decl %edx

    cmpl $0, %edx
    
    jne save_end_copy

# free variables
end:
    popl %edi # lolipopl
    popl %esi
    popl %ebx
    popl %ebp
ret
