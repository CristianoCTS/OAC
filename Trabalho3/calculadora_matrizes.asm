.data
#base
teste: .ascii "Programa iniciado"
line_jump: .ascii "\n"
space: .ascii " "
m1: .word 1, 2, 3, 
	  4, 5, 6, 
	  7, 8, 9 
m2: .word 9, 8, 7, 
	  6, 5, 4, 
	  3, 2, 1
mr: .space 36 
lado: .word 3

.text
#testando funçção por função
la a0, teste
li a7, 4
ecall
la a0, m1
la a3, lado
jal print
la a0, m2
la a3, lado
jal print
la a0, m1
la a1, m2
la a2, mr
la a3, lado
jal sum
la a0, mr
jal print
la a0, m1
la a1, m2
la a2, mr
la a3, lado
jal multiply
la a0, mr
jal print
la a0, m1
la a2, mr
la a3, lado
jal transpose
la a0, mr
jal print
li a7, 10
ecall

#funcoes
read_cell:
        # a0: linha/resultado; a1: coluna; t2: endereço do primeiro elemento da matriz;
	lw t0, 0(a3)
	addi a0, a0, -1
	addi a1, a1, -1
	mul t1, a0, t0
	add t1, t1, a1
	slli t1, t1, 2
	add t1, t1, t2
	lw a0, 0(t1)
	li t1, 0
	jalr x0,0(s11)
write_cell:
	# a0: linha; a1: coluna; a2: valor a ser inserido; t2: endereço do primeiro elemento da matriz; 
	lw t0, 0(a3)
	addi a0, a0, -1
	addi a1, a1, -1
	mul t1, a0, t0
	add t1, t1, a1
	slli t1, t1, 2
	add t1, t1, t2
	sw a2, 0(t1)
	li t1, 0
	jalr x0,0(s11)
sum:
	# a0: endereço do primeiro elemento da primeira matriz; a1: endereço do primeiro elemento da segunda matriz; a2: endereço do primeiro elemento da matriz resultado;
	mv a4, a0
	mv a5, a1
	mv a6, a2
	lw t0, 0(a3)
	start_sum:
		li a0, 1
		li a1, 1
		li a2, 0
	operation_sum:
		mv t2, a4
		mv s2, a0
		mv s3, a1
		la s10, read_cell 
		jalr  s11, 0(s10)
		mv t3, a0
		mv a0, s2
		mv a1, s3
		mv t2, a5
		la s10, read_cell 
		jalr  s11, 0(s10)
		add t3, t3, a0
		mv a0, s2
		mv a1, s3
		mv a2, t3
		mv t2, a6
		la s10, write_cell 
		jalr  s11, 0(s10)
		mv a0, s2
		mv a1, s3
		li t2, 0
		li t3, 0
	step_colum_sum:
		bge a1, t0, step_row_sum
		addi a1, a1, 1
		li a2, 0
		j operation_sum
	step_row_sum:
		bge a0, t0, end_sum
		addi a0, a0, 1
		li a1, 1
		li a2, 0
		j operation_sum
	end_sum:
		mv a0, a4
		mv a1, a5
		mv a2, a6
		ret
multiply:
	# a0: endereço do primeiro elemento da primeira matriz; a1: endereço do primeiro elemento da segunda matriz; a2: endereço do primeiro elemento da matriz resultado;
	mv a4, a0
	mv a5, a1
	mv a6, a2
	lw t0, 0(a3)
	start_multiply:
		li a0, 1
		li a1, 1
		li s2, 1
		li s3, 1
		li s4, 1
		li a2, 0
	operation_multiply:
		mv t2, a4
		mv a0, s2
		mv a1, s4
		la s10, read_cell 
		jalr  s11, 0(s10)
		mv t3, a0
		mv t2, a5
		mv a0, s4
		mv a1, s3
		la s10, read_cell 
		jalr  s11, 0(s10)
		mv t4, a0
		mul t3, t3, t4
		add t5, t5, t3
		li t2, 0
		li t3, 0
		li t4, 0
		step_operation_multiply:
			bge s4, t0, step_colum_multiply
			addi s4, s4, 1
			j operation_multiply
	step_colum_multiply:
		mv a0, s2
		mv a1, s3
		mv a2, t5
		mv t2, a6
		la s10, write_cell 
		jalr  s11, 0(s10)
		li t2, 0
		li t3, 0
		li t4, 0
		li t5, 0
		bge s3, t0, step_row_multiply
		addi s3, s3, 1
		li s4, 1
		li a2, 0
		j operation_multiply
	step_row_multiply:
		bge s2, t0, end_multiply
		addi s2, s2, 1
		li s3, 1
		li s4, 1
		li a2, 0
		j operation_multiply
	end_multiply:
		mv a0, a4
		mv a1, a5
		mv a2, a6
		li s2, 0
		li s3, 0
		li s4, 0
		ret
transpose:
	# a0: endereço do primeiro elemento da primeira matriz; a2: endereço do primeiro elemento da matriz resultado;
	mv a4, a0
	mv a5, a1
	mv a6, a2
	lw t0, 0(a3)
	start_transpose:
		li a0, 1
		li a1, 1
		li a2, 0
	operation_transpose:
		mv t2, a4
		mv s2, a0
		mv s3, a1
		la s10, read_cell 
		jalr  s11, 0(s10)
		mv a2, a0
		mv a0, s3
		mv a1, s2
		mv t2, a6
		la s10, write_cell 
		jalr  s11, 0(s10)
		mv a0, s2
		mv a1, s3
		li t2, 0
		li t3, 0
		li t4, 0
		li s2, 0
		li s3, 0
	step_colum_transpose:
		bge a1, t0, step_row_transpose
		addi a1, a1, 1
		li a2, 0
		j operation_transpose
	step_row_transpose:
		bge a0, t0, end_transpose
		addi a0, a0, 1
		li a1, 1
		li a2, 0
		j operation_transpose
	end_transpose:
		mv a0, a4
		mv a1, a5
		mv a2, a6
		ret
print:
	# a0: endereço do primeiro elemento da primeira matriz;
	mv a4, a0
	lw t0, 0(a3)
	start_print:
		li a0, 1
		li a1, 1
	operation_print:
		mv t2, a4
		mv s2, a0
		mv s3, a1
		la s10, read_cell 
		jalr  s11, 0(s10)
		li a7, 1
		ecall
		la a0, space
		li a7, 4
		ecall
		mv a0, s2
		mv a1, s3
		li a7, 0
	step_colum_print:
		
		bge a1, t0, step_row_print
		addi a1, a1, 1
		j operation_print
	step_row_print:
		mv s2, a0
		la a0, line_jump
		li a7, 4
		ecall
		mv a0, s2
		li a7, 0
		bge a0, t0, end_print
		addi a0, a0, 1
		li a1, 1
		j operation_print
	end_print:
		mv a0, a4
		mv s2, a0
		la a0, line_jump
		li a7, 4
		ecall
		mv a0, s2
		ret
