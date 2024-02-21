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
	li	$2, 0x1
	la	$3, x
	sw	$2, 0($3)
	li	$2, 0x2
	la	$3, y
	sw	$2, 0($3)
	la	$2, x
	lw	$2, 0($2)
	la	$3, T3
	sw	$2, 0($3)
	la	$2, y
	lw	$2, 0($2)
	la	$3, T3
	lw	$3, 0($3)
	sne	$2, $3, $2
	beq	$2, $0, L1
	li	$2, 0x5
	jr	$31
	j L2
L1:
	li	$2, 0xA
	jr	$31
L2:


	.data
	.align 0
T3:	.word 0
x:	.word 0
y:	.word 0

