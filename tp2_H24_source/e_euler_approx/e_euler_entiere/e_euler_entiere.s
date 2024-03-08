.data
un:
.int 1
iteration:
.int 0
n:
.int 1
valeur_e:
.int 0
denominateur:
.int 1

.text
.globl e_euler_entiere

e_euler_entiere:
    push %ebp
    mov %esp, %ebp
    push %ebx

    xor %eax, %eax
    xor %ebx, %ebx
    xor %ecx, %ecx
    xor %edx, %edx

    movl 8(%ebp), %ebx
    movl %ebx, iteration 

    //# ajouter 1 pour n=0 (1/0!=1)
    mov valeur_e,%ecx
    add un, %ecx
    mov %ecx,valeur_e

Verifier_iteration_zero:
    mov iteration,%ebx
    cmp $0, %ebx
    je fin

denominateure:
//3.2.2 Après le 12e itération, la valeur du dénominateur devient incorrecte 
//( la valeur du denominateur(n!) attendu lorsque nombre d'itration=13 est 6227020800, cependant la valeur du denominatuer dans le registre %eax est 1932053504)
    mov n, %eax
    mov denominateur, %ecx
    mul %ecx
    mov %eax, denominateur
    mov n, %eax
    add un, %eax
    mov %eax, n

    // Division
    mov un , %eax
    mov denominateur, %ecx
    div %ecx
    
    // Mise à jour de iteration
    mov iteration, %ebx
    sub un, %ebx
    mov %ebx, iteration

    jmp Sommation



Sommation: 
    add %eax, valeur_e
    jmp Verifier_iteration_zero 

fin:
    
    mov valeur_e, %eax
    subl $8, %ebp
    pop %ebx
    pop %ebp
    ret

