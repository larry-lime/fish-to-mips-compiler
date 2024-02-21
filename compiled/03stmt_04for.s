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
	li	$2, 0x0
	la	$3, x
	sw	$2, 0($3)
	li	$2, 0xA
	la	$3, i
	sw	$2, 0($3)
	j L1
L2:
	la	$2, x
	lw	$2, 0($2)
	la	$3, T5
	sw	$2, 0($3)
	la	$2, i
	lw	$2, 0($2)
	la	$3, T5
	lw	$3, 0($3)
	add	$2, $2, $3
	la	$3, x
	sw	$2, 0($3)
	la	$2, i
	lw	$2, 0($2)
	la	$3, T4
	sw	$2, 0($3)
	li	$2, 0x1
	la	$3, T4
	lw	$3, 0($3)
	sub	$2, $3, $2
	la	$3, i
	sw	$2, 0($3)
L1:
	la	$2, i
	lw	$2, 0($2)
	la	$3, T3
	sw	$2, 0($3)
	li	$2, 0x0
	la	$3, T3
	lw	$3, 0($3)
	sgt	$2, $3, $2
	bne	$2, $0, L2
	la	$2, x
	lw	$2, 0($2)
	jr	$31


	.data
	.align 0
T3:	.word 0
T4:	.word 0
T5:	.word 0
i:	.word 0
x:	.word 0

