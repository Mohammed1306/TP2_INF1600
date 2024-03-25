.data
.globl	_ZNK6MatrixmlERKS_
.type	_ZNK6MatrixmlERKS_, @function
.text
_ZNK6MatrixmlERKS_:
pushl %ebp
movl  %esp, %ebp
pushl %ebx

# TODO: a comparaison to detect if the matrix is multiplicatable or not
movl 12(%ebp), %eax # this 
movl 16(%ebp), %ebx # other

movl 4(%ebx), %edx#charge le nombre de lignes de m2
movl 8(%eax), %ecx ##charge le nb de colonne de m1

cmp %edx,%ecx
jne not_multiplicatable 

# TODO: creates the new object
pushl 8(%eax) # this->col ##a valeur de l'attribut _lines de l'objet actuel est placée sur la pile pour être utilisée ultérieurement dans le programme.
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


push %edi #i
push %esi #k
push %ecx #j

movl $0, %edi           # Initialisation de l'indice i
loop_i:
    movl $0, %esi       # Initialisation de l'indice j
    loop_j:
        movl $0, %ecx   # Initialisation de l'indice k
        loop_k:
            movl 12(%ebp), %eax # this
            pushl %edi          # i
            pushl %esi          # k
            pushl 12(%eax)      # this->_elements
            call findAddrElem
            addl $12, %esp
            flds (%eax)# *(k + other->_elements) + j

            movl 16(%ebp), %eax # other 
            pushl %esi          # k
            pushl %ecx          # j
            pushl 12(%eax)      # other->_elements
            call findAddrElem
            addl $12, %esp
            flds (%eax)# *(i + this->_elements) + k


            fmulp               # st[0] = this->_elements[i][k] *other._elements[k][j]
            fstps (%edx)        # Stocke le résultat dans newMatrix->_elements[i][j]
            faddp               # Ajoute le résultat précédent à la somme

            incl %ebx           # Incrémentation de k
            cmpl 4(%esp), %ebx  # Comparaison de k avec le nombre de colonnes
            jl loop_k           # Si k < nombre de colonnes, retourner à la boucle loop_k

        incl %esi               # Incrémentation de j
        cmpl 8(%esp), %esi     # Comparaison de j avec le nombre de colonnes de other
        jl loop_j               # Si j < nombre de colonnes, retourner à la boucle loop_j

    incl %ecx                   # Incrémentation de i
    cmpl 4(%eax), %ecx          # Comparaison de i avec le nombre de lignes
    jl loop_i                   # Si i < nombre de lignes, retourner à la boucle loop_i  

addl $8, %esp
movl 8(%ebp), %eax
jmp end


not_multiplicatable:
# TODO: call correct error function with correct parameters
movl 16(%ebp), %ebx
pushl 4(%ebx)
pushl 12(%ebp)
call _ZNK6Matrix23notMultiplicatableErrorEi
addl $4, %esp


end:
popl %ebx
leave
ret