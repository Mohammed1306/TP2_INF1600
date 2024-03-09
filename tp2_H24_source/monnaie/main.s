.data
caisse:
.int 25, 10, 5, 1 
#TODO initialiser les strings pour l'affichage des billets
billets25:
.asciz "Le nombre de billet de 25$: %x \n"
billets10:
.asciz "Le nombre de billet de 10$: %x \n"
billets5:
.asciz "Le nombre de billet de 5$: %x \n"
billets1:
.asciz "Le nombre de billet de 1$: %x \n"
montant:
.int 67


.text
.globl main
main : 
push %ebp
mov %esp,%ebp
push %ebx
#TODO: Répondre a la question

mask:
xor %eax, %eax          
xor %ecx, %ecx
xor %ebx, %ebx

movl $caisse, %ebx
pushl $billets25

nombre25:
movl montant, %eax
movl $0, %edx
divl (%ebx)
pushl %eax
pushl $billets25
call printf
addl $8, %esp

nombre10:
movl montant, %eax
movl $0, %edx
divl (%ebx)
movl %edx, %eax
movl $0, %edx
divl 4(%ebx)
pushl %eax
pushl $billets10
call printf
addl $8, %esp

nombre5:
movl montant, %eax
movl $0, %edx
divl (%ebx)
movl %edx, %eax
movl $0, %edx
divl 4(%ebx)
movl %edx, %eax
movl $0, %edx
divl 8(%ebx)
pushl %eax
pushl $billets5
call printf
addl $8, %esp

nombre1:
movl montant, %eax
movl $0, %edx
divl (%ebx)
movl %edx, %eax
movl $0, %edx
divl 4(%ebx)
movl %edx, %eax
movl $0, %edx
divl 8(%ebx)
movl %edx, %eax
movl $0, %edx
divl 12(%ebx)
pushl %eax
pushl $billets1
call printf
addl $8, %esp

end:
popl %ebx
popl %ebp
ret



