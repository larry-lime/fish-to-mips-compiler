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
	li	$2, 0xFFFFFFFF
	la	$3, T2
	sw	$2, 0($3)
	li	$2, 0x186A0
	la	$3, T2
	lw	$3, 0($3)
	mul	$2, $2, $3
	la	$3, T1
	sw	$2, 0($3)
	li	$2, 0x249F0
	la	$3, T1
	lw	$3, 0($3)
	add	$2, $2, $3
	jr	$31


	.data
	.align 0
T1:	.word 0
T2:	.word 0

