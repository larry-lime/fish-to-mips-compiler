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
	li	$2, 0xF
	la	$3, T1
	sw	$2, 0($3)
	li	$2, 0x0
	la	$3, T1
	lw	$3, 0($3)
	sgt	$2, $2, $0
	sgt	$3, $3, $0
	or	$2, $2, $3
	jr	$31


	.data
	.align 0
T1:	.word 0
