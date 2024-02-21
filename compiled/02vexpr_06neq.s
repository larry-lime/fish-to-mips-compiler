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
	li	$2, 0xC
	la	$3, x
	sw	$2, 0($3)
	li	$2, 0x4
	la	$3, y
	sw	$2, 0($3)
	la	$2, x
	lw	$2, 0($2)
	la	$3, T1
	sw	$2, 0($3)
	la	$2, y
	lw	$2, 0($2)
	la	$3, T1
	lw	$3, 0($3)
	sne	$2, $3, $2
	jr	$31


	.data
	.align 0
T1:	.word 0
x:	.word 0
y:	.word 0

