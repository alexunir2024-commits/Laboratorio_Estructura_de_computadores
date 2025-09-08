.data
    msg_cant: .asciiz "Ingrese los elementos a comparar (3 ó 5): "
    msg_ingrese: .asciiz "\nIngrese el número: "
    msg_may: .asciiz "\nEl número mayor es: "
    msg_error_cant: .ascii "\nElrror: Ingrese un número entre 3 y 5.\n"
    array: .space 20
    newline: .asciiz "\n"
    
.text
.globl main

main:
    li $v0, 4
    la $a0, msg_cant
    syscall
    
    li $v0, 5
    syscall
    move $t0, $v0
    
    blt $t0, 3, error_cant
    bgt $t0, 5, error_cant
    
    li $t1, 0
    la $t2, array

read_loop:
    beq $t1, $t0, find_max
    
    li $v0, 4
    la $a0, msg_ingrese
    syscall
    
    li $v0, 1
    addi $a0, $t1, 1
    syscall
    
    li $v0, 4
    la $a0, newline
    syscall
    
    li $v0, 5
    syscall
    sw $v0, 0($t2)
    
    addi $t1, $t1, 1
    addi $t2, $t2, 4
    j read_loop
    
find_max:
    la $t2, array
    lw $t3, 0($t2)
    
    li $t1, 1
    
compare_loop:
    beq $t1, $t0, print_max
    
    addi $t2, $t2, 4
    lw $t4, 0($t2)
    
    bgt $t4, $t3, update_max
    
    addi $t1, $t1, 1
    j compare_loop
    
update_max:
    move $t3, $t4
    addi $t1, $t1, 1
    j compare_loop

print_max:
    li $v0, 4
    la $a0, msg_may
    syscall
    
    li $v0, 1
    move $a0, $t3
    syscall
    
    j end_prog
    
error_cant:
    li $v0, 4
    la $a0, msg_error_cant
    syscall
    j main
    
end_prog:
    li $v0, 10
    syscall
    
