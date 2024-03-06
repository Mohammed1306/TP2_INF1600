/*
Q2.3.2:
Si on veut considérer les majuscules, il faut non seulement réarranger la vérification du charactère alphabétique pour que ça vérifie
en plus les charachtères allant de 0x41 à 0x5A, mais aussi considérer un décalage de 32 dans l'addition au moment d'additionner une
lettre majuscule.
*/
 .data
string1:
.asciz  "chien" 
lenght1:
.int 5
string2:
.asciz  "niche"
lenght2:
.int 5

.text
.globl anagramme
main:
anagramme: 

push %ebp
mov %esp,%ebp
push %ebx

mask:
xor %eax, %eax          
xor %ecx, %ecx
xor %ebx, %ebx

movl lenght1, %eax
movl lenght2, %ebx
cmp %eax, %ebx
jz setup1
jmp r

r:
movl $1, %eax
jmp bye

setup1:
xor %ecx, %ecx
movl $string1, %esi 

n_c:
lodsb

d:
cmp $0, %al
jz setup2
cmp $0x61, %al
jb fin2
cmp $0x7A, %al 
jbe a

a:       
addl %eax, %ecx
jmp n_c

setup2:
xor %ebx, %ebx
movl $string2, %esi 

n_c2:
lodsb

d_2:
cmp $0, %al
jz div1
cmp $0x61, %al
jb fin2
cmp $0x7A, %al 
jbe a_2

a_2:       
addl %eax, %ebx
jmp n_c2



div1:
movl $0, %edx
movl %ecx, %eax
divl lenght1
movl %eax, %ecx

div2:
movl $0, %edx
movl %ebx, %eax
divl lenght1
movl %eax, %ebx

cmp %ebx, %ecx
jz fin1
jmp fin2

fin1:
movl $0, %eax
jmp bye

fin2:
movl $255, %eax

bye:
popl %ebx
popl %ebp

ret
push %eax
