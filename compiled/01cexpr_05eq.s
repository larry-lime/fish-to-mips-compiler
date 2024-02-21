	.text
	.align	2
	.globl printInt
	.globl fish_main
	.globl main

main:
	move $s8, $31
	jal fish_main
	move $31, $s8
	move $a0, $2
	j printInt

printInt:
	add $t0, $v0, $zero
	li $v0, 1
	syscall
	add $v0, $t0, $zero
	jr $ra

fish_main:
	li	$2, 0x4
	la	$3, T7
	sw	$2, 0($3)
	li	$2, 0x1
	la	$3, T8
	sw	$2, 0($3)
	li	$2, 0x2
	la	$3, T8
	lw	$3, 0($3)
	seq	$2, $3, $2
	la	$3, T7
	lw	$3, 0($3)
	mul	$2, $2, $3
	la	$3, T4
	sw	$2, 0($3)
	li	$2, 0x2
	la	$3, T5
	sw	$2, 0($3)
	li	$2, 0x2
	la	$3, T6
	sw	$2, 0($3)
	li	$2, 0x2
	la	$3, T6
	lw	$3, 0($3)
	seq	$2, $3, $2
	la	$3, T5
	lw	$3, 0($3)
	mul	$2, $2, $3
	la	$3, T4
	lw	$3, 0($3)
	add	$2, $2, $3
	la	$3, T1
	sw	$2, 0($3)
	li	$2, 0x1
	la	$3, T2
	sw	$2, 0($3)
	li	$2, 0x3
	la	$3, T3
	sw	$2, 0($3)
	li	$2, 0x2
	la	$3, T3
	lw	$3, 0($3)
	seq	$2, $3, $2
	la	$3, T2
	lw	$3, 0($3)
	mul	$2, $2, $3
	la	$3, T1
	lw	$3, 0($3)
	add	$2, $2, $3
	jr	$31


	.data
	.align 0
T1:	.word 0
T2:	.word 0
T3:	.word 0
T4:	.word 0
T5:	.word 0
T6:	.word 0
T7:	.word 0
T8:	.word 0

