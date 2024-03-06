.data
strings:
.asciz "Allo Hi"
num:
.asciz "Allo"
den:
.asciz "Hi"
.text
.globl main


main : 
push %ebp
mov %esp,%ebp
push %ebx

mask:
xor %eax, %eax          
xor %ecx, %ecx
xor %ebx, %ebx

setup:
movl $strings, %esi     

//Garde le premier charactère du string "Allo Hi" dans %al
n_c:
lodsb                  

//Cette étiquette vérifie que le charactère contenu dans %al est une lettre alphabétique.
//Si c'est le cas, on saute à l'étiquette a
d:              
cmp $0x20, %al
je n_c2
cmp $0x41, %al
jb n_c2
cmp $0x5A, %al
jb a
cmp $0x61, %al
jb n_c2
cmp $0x7A, %al 
jbe a

a:       
addl %eax, %ecx
jmp n_c

n_c2:
lodsb

d2:
//
cmp $0x00, %al
jz r
//ERREUR: pour pouvoir comparer si le charactère est un espace on doit le comparer avec 0x20
cmp $0x20, %al
je n_c2
cmp $0x41, %al
jb n_c2
cmp $0x5A, %al
jb a_2
cmp $0x61, %al
jb n_c2
cmp $0x7A, %al 
jbe a_2

a_2:
addl %eax, %ebx
jmp n_c2

//Prend le résultat de l'addition de toutes les lettres du premier mot et les stocke dans %eax pour pouvoir faire la division
r:
movl %ecx, %eax

//on doit forcer edx a 0
movl $0x00, %edx

div %ebx
//ERRUR: le résultat doit être comparé à 1 pour savoir si l'un est plus grand que l'autre
cmp $0x00, %eax
//ERREUR: on devrait sauter à e_n si le résultat de comparaison est vrai et à e_d si ce n'est pas le cas et pas l'inverse
//ERREUR: on devrait sauter si le résultat est supérieur à 1 et non égal
jz e_n
jmp e_d              
             
//Affiche le numérateur
e_n:
push $num
call printf

jmp bye

e_d:
push $den
call printf


bye:
popl %ebx
popl %ebp
ret