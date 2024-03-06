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

//Charge un charactère du string "Allo Hi" à la fois dans %al
n_c:
lodsb                  

//Cette étiquette vérifie que le charactère contenu dans %al est une lettre alphabétique.
//Si c'est le cas, on saute à l'étiquette a, sinon on charge le prochain charactère
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
cmp $0, %al
jz r
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

//ERREUR: on doit forcer %edx a 0 pour pouvoir diviser
movl $0x00, %edx

divl %ebx
cmp $0x00, %eax
//ERREUR: on devrait sauter à e_n si le résultat de comparaison est vrai et à e_d si ce n'est pas le cas et pas l'inverse
jz e_n
jmp e_d     
             
//Affiche le numérateur
e_n:
push $num
call printf
//ERREUR: on doit incrémenter le %esp puisqu'on a push un paramettre
addl $4, %esp

jmp bye

e_d:
push $den
call printf
//ERREUR: on doit incrémenter le %esp puisqu'on a push un paramettre (je ne trouve pas de quatrième erreur et le code fonctionne quand même donc j'imagine que c'est celle la)
addl $4, %esp


bye:
popl %ebx
popl %ebp
ret