.data
    msg_cant_menor: .asciiz "Ingrese la cantidad de números a comparar(3 ó 5)"
    msg_ingrese_menor: .asciiz "\nIngrese el número: "
    msg_menor: .asciiz "\nEl número menor es; "
    msg_error_cant_menor: .asciiz "\nError. Ingrese el número entre 3 y 5.\n"
    array_menor: .space 20
    newline_menor: .ascii "\n"
    
.text
.globl main_menor

main_menor:
    li $v0, 4
    la $a0, msg_cant_menor
    syscall
    
    li $v0, 5
    syscall
    move $t0, $v0
    
    blt $t0, 3, error_cant_menor
    bgt $t0, 5, error_cant_menor
    
read_loop_menor:
    beq $t1, $t0, find_min
    
    li $v0, 4
    la $a0, msg_ingrese_menor
    syscall
    
    li $v0, 1
    addi $a0, $t1, 1
    syscall
    
    li $v0, 4
    la $a0, newline_menor
    syscall
    
    li $v0, 5
    syscall
    sw $v0, 0($t2)
    
    addi $t1, $t1, 1
    addi $t2, $t2, 4
    j read_loop_menor
    
find_min:
    la $t2, array_menor
    lw $t3, 0($t2)
    
    li $t1, 1
    
compare_loop_menor:
    beq $t1, $t0, print_min
    
    addi $t2, $t2, 4
    lw $t4, 0($t2)
    
    blt $t4, $t3, update_min
    
    addi $t1, $t1, 1
    j compare_loop_menor
    
update_min:
    move $t3, $t4
    addi $t1, $t1, 1
    j compare_loop_menor
    
print_min:
    li $v0, 4
    la $a0, msg_menor
    syscall
    
    li $v0, 1
    move $a0, $t3
    syscall
    
    j end_prog_menor
    
error_cant_menor:
    li $v0, 4
    la $a0, msg_error_cant_menor
    syscall
    j main_menor
    
end_prog_menor:
    li $v0, 10
    syscall