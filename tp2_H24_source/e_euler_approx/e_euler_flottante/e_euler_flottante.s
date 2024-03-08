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

xor %ebx,%ebx 

//# ajouter 1 pour n=0 (1/0!=1)
flds e
flds one
faddp
fstps e
//ajouter 1 a n 
flds factorial
flds one
faddp
fstps factorial
// ajouter 1 a n!
flds factorial_value
flds one
faddp
fstps factorial_value

Verifier_iteration_zero:
    mov iteration,%eax
    cmp $0, %eax
    je fin

denominateure:

    flds factorial
    flds factorial_value
    fmulp
    fstps factorial_value
    flds factorial
    flds one
    faddp
    fstps factorial

    // Division
    flds factorial_value
    flds one
    fdivp
    fstps reset
    
    // Mise à jour de iteration
    sub $1,%eax
    mov %eax, iteration
    jmp Sommation



Sommation: 
    flds reset
    flds e
    faddp
    fstps e
    
    jmp Verifier_iteration_zero 

fin:
    
    flds e
    pop %ebx
    pop %ebp
    ret


