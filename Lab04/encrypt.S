.section .text
.global enc_char
enc_char:
        pushl   %ebp
        pushl   %edi
        pushl   %esi
        pushl   %ebx
        subl    $16, %esp
        movl    36(%esp), %ecx
        movl    40(%esp), %eax
        movsbl  %cl, %edx
        andl    $1, %ecx
        leal    48(%ecx), %esi
        movl    %edx, %ecx
        movl    %edx, %ebp
        shrl    $2, %ecx
        movl    %esi, (%esp)
        movl    %edx, %esi
        shrl    $5, %ebp
        andl    $1, %ecx
        shrl    %esi
        andl    $1, %ebp
        leal    48(%ecx), %edi
        movl    %edx, %ecx
        andl    $1, %esi
        shrl    $4, %ecx
        movl    %edi, 4(%esp)
        movl    %edx, %edi
        andl    $1, %ecx
        shrl    $3, %edi
        leal    48(%ecx), %ebx
        movl    %edx, %ecx
        andl    $1, %edi
        movl    %ebx, 8(%esp)
        movzbl  2(%eax), %ebx
        shrl    $6, %ecx
        andl    $1, %ecx
        andl    $-4, %ebx
        addl    $48, %ecx
        movb    %bl, 13(%esp)
        movzbl  1(%eax), %ebx
        andl    $-4, %ebx
        movb    %bl, 14(%esp)
        movzbl  (%eax), %ebx
        andl    $-4, %ebx
        movb    %bl, 15(%esp)
        movzbl  3(%eax), %ebx
        andl    $-50529028, (%eax)
        andl    $-4, %ebx
        testl   %edx, %edx
        jns     Jump16
        leal    3(%ebx), %edx
        addl    $2, %ebx
        cmpl    $48, %ecx
        cmovne  %edx, %ebx
        movb    %bl, 3(%eax)
Jump3:
        testl   %ebp, %ebp
        je      Jump17
Jump5:
        movzbl  13(%esp), %ebx
        cmpl    $48, 8(%esp)
        leal    3(%ebx), %edx
        leal    2(%ebx), %ecx
        cmovne  %edx, %ecx
        movb    %cl, 2(%eax)
Jump6:
        testl   %edi, %edi
        je      Jump18
Jump8:
        movzbl  14(%esp), %edi
        cmpl    $48, 4(%esp)
        leal    3(%edi), %ecx
        leal    2(%edi), %edx
        cmovne  %ecx, %edx
        movb    %dl, 1(%eax)
Jump9:
        testl   %esi, %esi
        je      Jump19
Jump11:
        movzbl  15(%esp), %esi
        cmpl    $48, (%esp)
        leal    3(%esi), %ecx
        leal    2(%esi), %edx
        cmovne  %ecx, %edx
        movb    %dl, (%eax)
Jump1:
        addl    $16, %esp
        popl    %ebx
        popl    %esi
        popl    %edi
        popl    %ebp
        ret
Jump16:
        cmpl    $49, %ecx
        jne     Jump3
        addl    $1, %ebx
        movb    %bl, 3(%eax)
        testl   %ebp, %ebp
        jne     Jump5
Jump17:
        cmpl    $49, 8(%esp)
        jne     Jump6
        movzbl  13(%esp), %edx
        addl    $1, %edx
        movb    %dl, 2(%eax)
        testl   %edi, %edi
        jne     Jump8
Jump18:
        cmpl    $49, 4(%esp)
        jne     Jump9
        movzbl  14(%esp), %edx
        addl    $1, %edx
        movb    %dl, 1(%eax)
        testl   %esi, %esi
        jne     Jump11
Jump19:
        cmpl    $49, (%esp)
        jne     Jump1
        movzbl  15(%esp), %edx
        addl    $1, %edx
        movb    %dl, (%eax)
        addl    $16, %esp
        popl    %ebx
        popl    %esi
        popl    %edi
        popl    %ebp
        ret
