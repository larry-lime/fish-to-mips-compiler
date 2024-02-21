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
	li	$2, 0x2
	la	$3, a
	sw	$2, 0($3)
	li	$2, 0x2
	la	$3, b
	sw	$2, 0($3)
	li	$2, 0x1
	la	$3, c
	sw	$2, 0($3)
	li	$2, 0x0
	la	$3, x
	sw	$2, 0($3)
	la	$2, a
	lw	$2, 0($2)
	la	$3, T21
	sw	$2, 0($3)
	li	$2, 0x1
	la	$3, T21
	lw	$3, 0($3)
	seq	$2, $3, $2
	beq	$2, $0, L1
	la	$2, b
	lw	$2, 0($2)
	la	$3, T20
	sw	$2, 0($3)
	li	$2, 0x1
	la	$3, T20
	lw	$3, 0($3)
	seq	$2, $3, $2
	beq	$2, $0, L12
	la	$2, c
	lw	$2, 0($2)
	la	$3, T19
	sw	$2, 0($3)
	li	$2, 0x1
	la	$3, T19
	lw	$3, 0($3)
	seq	$2, $3, $2
	beq	$2, $0, L17
	li	$2, 0x1
	la	$3, x
	sw	$2, 0($3)
	j L18
L17:
	li	$2, 0x2
	la	$3, x
	sw	$2, 0($3)
L18:
	li	$2, 0x0
	jr	$31
	j L13
L12:
	la	$2, c
	lw	$2, 0($2)
	la	$3, T16
	sw	$2, 0($3)
	li	$2, 0x1
	la	$3, T16
	lw	$3, 0($3)
	seq	$2, $3, $2
	beq	$2, $0, L14
	li	$2, 0x3
	la	$3, x
	sw	$2, 0($3)
	j L15
L14:
	li	$2, 0x4
	la	$3, x
	sw	$2, 0($3)
L15:
	li	$2, 0x0
	jr	$31
L13:
	li	$2, 0x0
	jr	$31
	j L2
L1:
	la	$2, b
	lw	$2, 0($2)
	la	$3, T11
	sw	$2, 0($3)
	li	$2, 0x1
	la	$3, T11
	lw	$3, 0($3)
	seq	$2, $3, $2
	beq	$2, $0, L3
	la	$2, c
	lw	$2, 0($2)
	la	$3, T10
	sw	$2, 0($3)
	li	$2, 0x1
	la	$3, T10
	lw	$3, 0($3)
	seq	$2, $3, $2
	beq	$2, $0, L8
	li	$2, 0x5
	la	$3, x
	sw	$2, 0($3)
	j L9
L8:
	li	$2, 0x6
	la	$3, x
	sw	$2, 0($3)
L9:
	li	$2, 0x0
	jr	$31
	j L4
L3:
	la	$2, c
	lw	$2, 0($2)
	la	$3, T7
	sw	$2, 0($3)
	li	$2, 0x1
	la	$3, T7
	lw	$3, 0($3)
	seq	$2, $3, $2
	beq	$2, $0, L5
	li	$2, 0x7
	la	$3, x
	sw	$2, 0($3)
	j L6
L5:
	li	$2, 0x8
	la	$3, x
	sw	$2, 0($3)
L6:
	la	$2, x
	lw	$2, 0($2)
	jr	$31
L4:
	li	$2, 0x0
	jr	$31
L2:
	li	$2, 0x0
	jr	$31


	.data
	.align 0
T10:	.word 0
T11:	.word 0
T16:	.word 0
T19:	.word 0
T20:	.word 0
T21:	.word 0
T7:	.word 0
a:	.word 0
b:	.word 0
c:	.word 0
x:	.word 0

