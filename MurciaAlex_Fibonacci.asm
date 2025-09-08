.data

    msg_cant_fib: .asciiz "Ingrese cuántos números de la serie Fibonacci desea generar: "
    msg_serie: .asciiz "\nLa serie es: "
    msg_suma: .asciiz "\nLa suma de los números de la serie es: "
    space: .ascii " "

.text
.globl main_fib

main_fib:
    li $v0, 4
    la $a0, msg_cant_fib
    syscall
    
    li $v0, 5
    syscall
    move $t0, $v0
    
    li $t1, 0
    li $t2, 1
    li $t3, 0
    li $t4, 0
    li $s0, 0
    
    li $v0, 4
    la $a0, msg_serie
    syscall
    
loop_fib:
    beq $t4, $t0, print_fib_results
    
    li $v0, 1
    move $a0, $t1
    syscall
    
    li $v0, 4
    la $a0, space
    syscall
    
    add $s0, $t1, $t2
    
    move $t1, $t2
    move $t2, $s0
    
    addi $t4, $t4, 1
    j loop_fib
    
print_fib_results:
    li $v0, 4
    la $a0, msg_suma
    syscall
    
    li $v0, 1
    move $a0, $t3
    syscall
    
    li $v0, 10
    syscall
