.data
.globl	_ZNK6MatrixmlEf
.type	_ZNK6MatrixmlEf, @function
.text
_ZNK6MatrixmlEf:   # name mangling for operator* (ml for *)
pushl %ebp
movl  %esp, %ebp
pushl %ebx
#TODO: creates the new object


movl 12(%ebp), %eax  # this



# Creation of the new object Matrix:
pushl 8(%eax) # this->col
pushl 4(%eax) # this->lines
pushl 8(%ebp) # x86-32 convention as passing the argument of newMatrix as first parameter
call _ZN6MatrixC2Eii # constructor
addl $12, %esp

# Filling of the new object Matrix:
movl 8(%ebp), %ebx # ebx is now the ptr of this new matrix
movl 12(%ebx), %edx # newMatrix->_elements
pushl 8(%ebx) # newMatrix->_colums
movl $-1, %eax
addl 4(%ebx), %eax
pushl %eax # newMatrix->_lines - 1

loop_i:
    movl 4(%esp), %ecx
    loop_j:
        movl (%esp), %ebx # i
        subl $1, %ecx
        movl 12(%ebp), %eax # this
        pushl %ecx # j
        pushl %ebx # i
        pushl 12(%eax) # this->_elements
        call findAddrElem
        addl $12, %esp
          
          
        flds (%eax) # *(i + other->_elements) + j
        flds 16(%ebp) # *(i + this->_elements) + j
        fmulp# st[0] = this->_elements[i][j] * other._elements[i][j]
        
        movl (%esp), %ebx # i
        pushl %ecx # j
        pushl %ebx # i
        pushl %edx # newMatrix->_elements
        call findAddrElem
        addl $12, %esp

        fstps (%eax) # newMatrix->_elements[i][j] = st[0]

    cmpl $0, %ecx
    jg loop_j

popl %eax
subl $1, %eax
pushl %eax
cmpl $0, %eax
jge loop_i