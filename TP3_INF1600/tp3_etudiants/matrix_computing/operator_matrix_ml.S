.data
.globl	_ZNK6MatrixmlERKS_
.type	_ZNK6MatrixmlERKS_, @function
.text
_ZNK6MatrixmlERKS_:
pushl %ebp
movl  %esp, %ebp
pushl %ebx

# TODO: a comparaison to detect if the matrix is multiplicatable or not
movl 12(%ebp), %eax
movl 16(%ebp), %ebx

movl 4(%ebx), %edx
movl 8(%eax), %ecx

cmp %edx,%ecx
jne not_multiplicatable 

# TODO: creates the new object
pushl 8(%ebx) 
pushl 4(%eax)
pushl 8(%ebp) 
call _ZN6MatrixC2Eii 
addl $12, %esp

movl 8(%ebp), %edi
movl 12(%ebp), %edx
xor %ecx, %ecx
pushl 8(%edx)
movl 8(%ebx), %eax
subl $1, %eax
pushl %eax
movl 4(%edx), %eax
subl $1, %eax
pushl %eax
loop_i:
    movl 4(%esp), %ecx
    loop_j:
        pushl %ecx
        pushl 4(%esp)
        pushl 12(%edi)
        call findAddrElem
        addl $12, %esp
        pushl %eax
        movl $0, (%eax)
        movl 12(%esp), %ecx

        loop_k:
            subl $1, %ecx
            pushl %ecx
            pushl 8(%esp)
            pushl 12(%edx)
            call findAddrElem
            addl $12, %esp
            flds (%eax)
            pushl 8(%esp)
            pushl %ecx
            pushl 12(%ebx)
            call findAddrElem
            addl $12, %esp
            flds (%eax)
            fmulp
            movl (%esp), %eax
            flds (%eax)
            faddp
            fstps (%eax)
            cmpl $0, %ecx
            jne loop_k

        addl $8, %esp
        popl %ecx
        movl %ecx,%eax
        subl $1, %ecx
        pushl %ecx
        subl $4, %esp
        cmpl $0, %eax
        jne loop_j

    movl 8(%ebx), %eax
    subl $1, %eax
    movl %eax, 4(%esp)
    movl 4(%esp), %eax
    popl %ecx
    movl %ecx,%eax
    subl $1, %ecx
    pushl %ecx
    cmpl $0, %eax
    jne loop_i
    movl 8(%ebp), %eax
    jmp end

not_multiplicatable:
# TODO: call correct error function with correct parameters
pushl 4(%ebx)
pushl 12(%ebp)
call _ZNK6Matrix23notMultiplicatableErrorEi
addl $8, %esp

end:
popl %ebx
leave
ret