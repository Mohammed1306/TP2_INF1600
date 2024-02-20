.data
iteration:
.int 3
iteration_FPU:  
.float 3      
factorial_value:
.float 0
factorial:
.float 0
e:
.float 0
reset:
.float 0
one:
.float 1
.text
.globl e_euler_flottante

e_euler_flottante:

push %ebp               
mov %esp,%ebp
push %ebx

## VOTRE CODE ICI 

pop %ebx
pop %ebp
ret
