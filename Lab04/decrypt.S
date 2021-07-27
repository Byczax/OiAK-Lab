.section .text
.global dec_char
dec_char:
        pushl   %ebp
        pushl   %edi
        pushl   %esi
        pushl   %ebx
        subl    $4, %esp
        movl    24(%esp), %eax
        movzbl  2(%eax), %ebx
        movzbl  1(%eax), %ecx
        movzbl  (%eax), %edx
        movzbl  3(%eax), %eax
        andl    $3, %ebx
        andl    $3, %ecx
        andl    $3, %eax
        andl    $3, %edx
        cmpb    $1, %al
        je      Jump10
        cmpb    $2, %al
        je      Jump11
        cmpb    $3, %al
        movl    $214, %esi
        movl    $16, %eax
        movl    $230, %edi
        cmove   %esi, %eax
        movl    $32, %esi
        movl    $246, %ebp
        cmove   %edi, %esi
        movl    $48, %edi
        cmovne  %edi, %ebp
        movl    $198, %edi
        movl    %ebp, (%esp)
        movl    $0, %ebp
        cmove   %edi, %ebp
Jump2:
        cmpb    $1, %bl
        je      Jump3
        movl    %esi, %eax
        cmpb    $2, %bl
        je      Jump3
        movl    (%esp), %eax
        cmpb    $3, %bl
        cmovne  %ebp, %eax
Jump3:
        cmpb    $1, %cl
        je      Jump21
        cmpb    $2, %cl
        je      Jump22
        leal    12(%eax), %ebx
        cmpb    $3, %cl
        cmove   %ebx, %eax
Jump5:
        cmpb    $1, %dl
        je      Jump23
        cmpb    $2, %dl
        je      Jump24
        cmpb    $3, %dl
        leal    3(%eax), %ecx
        cmove   %ecx, %eax
        addl    $4, %esp
        popl    %ebx
        popl    %esi
        popl    %edi
        popl    %ebp
        ret
Jump11:
        movl    $144, %eax
        movl    $160, %esi
        movl    $128, %ebp
        movl    $176, (%esp)
        jmp     Jump2
Jump10:
        movl    $80, %eax
        movl    $96, %esi
        movl    $64, %ebp
        movl    $112, (%esp)
        jmp     Jump2
Jump23:
        addl    $4, %esp
        addl    $1, %eax
        popl    %ebx
        popl    %esi
        popl    %edi
        popl    %ebp
        ret
Jump21:
        addl    $4, %eax
        jmp     Jump5
Jump24:
        addl    $4, %esp
        addl    $2, %eax
        popl    %ebx
        popl    %esi
        popl    %edi
        popl    %ebp
        ret
Jump22:
        addl    $8, %eax
        jmp     Jump5
