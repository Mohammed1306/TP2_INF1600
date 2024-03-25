.data
.globl	_ZNK12SquareMatrix11determinantEv
.type	_ZNK12SquareMatrix11determinantEv, @function
.text
_ZNK12SquareMatrix11determinantEv:
pushl %ebp
movl  %esp, %ebp
pushl %ebx

# TODO: Compare to know if it is the correct matrix size
movl 8(%ebp), %ebx  
cmpl $2, 8(%ebx) # this->col
jne not_correct_size_matrix
cmpl $2, 4(%ebx) # this->col
jne not_correct_size_matrix

# TODO: Compute the resultant determinant
pushl $0
pushl $0
pushl 12(%ebx)
call findAddrElem
addl $12, %esp
pushl %eax

pushl $0
pushl $1
pushl 12(%ebx)
call findAddrElem
addl $12, %esp
pushl %eax

movl %ebx, %edx
addl $16, %edx

movl 4(%esp), %eax
flds (%eax)
movl (%esp), %eax
addl $4, %eax
flds (%eax)
fmulp

fstps (%edx)
movl (%esp), %eax
flds (%eax)
movl 4(%esp), %eax
addl $4, %eax
flds (%eax)
fmulp
flds (%edx)
fsubp 
fstps (%edx)
addl $4, %esp
flds 16(%ebx)
jmp end

not_correct_size_matrix:
# TODO: call correct error function
pushl 12(%ebp)
call _ZNK12SquareMatrix25notCorrectSizeMatrixErrorEv
addl $4, %esp

end:
popl %ebx
leave
ret