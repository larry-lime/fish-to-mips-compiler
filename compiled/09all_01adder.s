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
	la	$3, x
	sw	$2, 0($3)
	li	$2, 0x3
	la	$3, y
	sw	$2, 0($3)
	la	$2, x
	lw	$2, 0($2)
	la	$3, T52
	sw	$2, 0($3)
	li	$2, 0x0
	la	$3, T52
	lw	$3, 0($3)
	slt	$2, $3, $2
	la	$3, T50
	sw	$2, 0($3)
	la	$2, x
	lw	$2, 0($2)
	la	$3, T51
	sw	$2, 0($3)
	li	$2, 0x3
	la	$3, T51
	lw	$3, 0($3)
	sgt	$2, $3, $2
	la	$3, T50
	lw	$3, 0($3)
	sgt	$2, $2, $0
	sgt	$3, $3, $0
	or	$2, $2, $3
	la	$3, T48
	sw	$2, 0($3)
	la	$2, y
	lw	$2, 0($2)
	la	$3, T49
	sw	$2, 0($3)
	li	$2, 0x0
	la	$3, T49
	lw	$3, 0($3)
	slt	$2, $3, $2
	la	$3, T48
	lw	$3, 0($3)
	sgt	$2, $2, $0
	sgt	$3, $3, $0
	or	$2, $2, $3
	la	$3, T46
	sw	$2, 0($3)
	la	$2, y
	lw	$2, 0($2)
	la	$3, T47
	sw	$2, 0($3)
	li	$2, 0x3
	la	$3, T47
	lw	$3, 0($3)
	sgt	$2, $3, $2
	la	$3, T46
	lw	$3, 0($3)
	sgt	$2, $2, $0
	sgt	$3, $3, $0
	or	$2, $2, $3
	beq	$2, $0, L43
	li	$2, 0xFFFFFFFF
	la	$3, T45
	sw	$2, 0($3)
	li	$2, 0x1
	la	$3, T45
	lw	$3, 0($3)
	mul	$2, $2, $3
	jr	$31
	j L44
L43:
	li	$2, 0x0
L44:
	la	$2, x
	lw	$2, 0($2)
	la	$3, T42
	sw	$2, 0($3)
	li	$2, 0x2
	la	$3, T42
	lw	$3, 0($3)
	sge	$2, $3, $2
	beq	$2, $0, L40
	li	$2, 0x1
	la	$3, x1
	sw	$2, 0($3)
	j L41
L40:
	li	$2, 0x0
	la	$3, x1
	sw	$2, 0($3)
L41:
	la	$2, x
	lw	$2, 0($2)
	la	$3, T38
	sw	$2, 0($3)
	li	$2, 0x2
	la	$3, T39
	sw	$2, 0($3)
	la	$2, x1
	lw	$2, 0($2)
	la	$3, T39
	lw	$3, 0($3)
	mul	$2, $2, $3
	la	$3, T38
	lw	$3, 0($3)
	sub	$2, $3, $2
	la	$3, x0
	sw	$2, 0($3)
	la	$2, y
	lw	$2, 0($2)
	la	$3, T37
	sw	$2, 0($3)
	li	$2, 0x2
	la	$3, T37
	lw	$3, 0($3)
	sge	$2, $3, $2
	beq	$2, $0, L35
	li	$2, 0x1
	la	$3, y1
	sw	$2, 0($3)
	j L36
L35:
	li	$2, 0x0
	la	$3, y1
	sw	$2, 0($3)
L36:
	la	$2, y
	lw	$2, 0($2)
	la	$3, T33
	sw	$2, 0($3)
	li	$2, 0x2
	la	$3, T34
	sw	$2, 0($3)
	la	$2, y1
	lw	$2, 0($2)
	la	$3, T34
	lw	$3, 0($3)
	mul	$2, $2, $3
	la	$3, T33
	lw	$3, 0($3)
	sub	$2, $3, $2
	la	$3, y0
	sw	$2, 0($3)
	la	$2, x0
	lw	$2, 0($2)
	la	$3, T32
	sw	$2, 0($3)
	la	$2, y0
	lw	$2, 0($2)
	la	$3, T32
	lw	$3, 0($3)
	sgt	$2, $2, $0
	sgt	$3, $3, $0
	or	$2, $2, $3
	la	$3, T30
	sw	$2, 0($3)
	la	$2, x0
	lw	$2, 0($2)
	la	$3, T31
	sw	$2, 0($3)
	la	$2, y0
	lw	$2, 0($2)
	la	$3, T31
	lw	$3, 0($3)
	sgt	$2, $2, $0
	sgt	$3, $3, $0
	and	$2, $2, $3
	sgt	$2, $2, $0
	seq	$2, $2, $0
	la	$3, T30
	lw	$3, 0($3)
	sgt	$2, $2, $0
	sgt	$3, $3, $0
	and	$2, $2, $3
	beq	$2, $0, L28
	li	$2, 0x1
	la	$3, s0
	sw	$2, 0($3)
	j L29
L28:
	li	$2, 0x0
	la	$3, s0
	sw	$2, 0($3)
L29:
	la	$2, x0
	lw	$2, 0($2)
	la	$3, T27
	sw	$2, 0($3)
	la	$2, y0
	lw	$2, 0($2)
	la	$3, T27
	lw	$3, 0($3)
	sgt	$2, $2, $0
	sgt	$3, $3, $0
	and	$2, $2, $3
	beq	$2, $0, L25
	li	$2, 0x1
	la	$3, c1
	sw	$2, 0($3)
	j L26
L25:
	li	$2, 0x0
	la	$3, c1
	sw	$2, 0($3)
L26:
	la	$2, x1
	lw	$2, 0($2)
	la	$3, T24
	sw	$2, 0($3)
	la	$2, y1
	lw	$2, 0($2)
	la	$3, T24
	lw	$3, 0($3)
	sgt	$2, $2, $0
	sgt	$3, $3, $0
	and	$2, $2, $3
	la	$3, T23
	sw	$2, 0($3)
	la	$2, c1
	lw	$2, 0($2)
	la	$3, T23
	lw	$3, 0($3)
	sgt	$2, $2, $0
	sgt	$3, $3, $0
	and	$2, $2, $3
	la	$3, T20
	sw	$2, 0($3)
	la	$2, x1
	lw	$2, 0($2)
	la	$3, T22
	sw	$2, 0($3)
	la	$2, y1
	lw	$2, 0($2)
	sgt	$2, $2, $0
	seq	$2, $2, $0
	la	$3, T22
	lw	$3, 0($3)
	sgt	$2, $2, $0
	sgt	$3, $3, $0
	and	$2, $2, $3
	la	$3, T21
	sw	$2, 0($3)
	la	$2, c1
	lw	$2, 0($2)
	sgt	$2, $2, $0
	seq	$2, $2, $0
	la	$3, T21
	lw	$3, 0($3)
	sgt	$2, $2, $0
	sgt	$3, $3, $0
	and	$2, $2, $3
	la	$3, T20
	lw	$3, 0($3)
	sgt	$2, $2, $0
	sgt	$3, $3, $0
	or	$2, $2, $3
	la	$3, T17
	sw	$2, 0($3)
	la	$2, x1
	lw	$2, 0($2)
	sgt	$2, $2, $0
	seq	$2, $2, $0
	la	$3, T19
	sw	$2, 0($3)
	la	$2, y1
	lw	$2, 0($2)
	la	$3, T19
	lw	$3, 0($3)
	sgt	$2, $2, $0
	sgt	$3, $3, $0
	and	$2, $2, $3
	la	$3, T18
	sw	$2, 0($3)
	la	$2, c1
	lw	$2, 0($2)
	sgt	$2, $2, $0
	seq	$2, $2, $0
	la	$3, T18
	lw	$3, 0($3)
	sgt	$2, $2, $0
	sgt	$3, $3, $0
	and	$2, $2, $3
	la	$3, T17
	lw	$3, 0($3)
	sgt	$2, $2, $0
	sgt	$3, $3, $0
	or	$2, $2, $3
	la	$3, T14
	sw	$2, 0($3)
	la	$2, x1
	lw	$2, 0($2)
	sgt	$2, $2, $0
	seq	$2, $2, $0
	la	$3, T16
	sw	$2, 0($3)
	la	$2, y1
	lw	$2, 0($2)
	sgt	$2, $2, $0
	seq	$2, $2, $0
	la	$3, T16
	lw	$3, 0($3)
	sgt	$2, $2, $0
	sgt	$3, $3, $0
	and	$2, $2, $3
	la	$3, T15
	sw	$2, 0($3)
	la	$2, c1
	lw	$2, 0($2)
	la	$3, T15
	lw	$3, 0($3)
	sgt	$2, $2, $0
	sgt	$3, $3, $0
	and	$2, $2, $3
	la	$3, T14
	lw	$3, 0($3)
	sgt	$2, $2, $0
	sgt	$3, $3, $0
	or	$2, $2, $3
	beq	$2, $0, L12
	li	$2, 0x1
	la	$3, s1
	sw	$2, 0($3)
	j L13
L12:
	li	$2, 0x0
	la	$3, s1
	sw	$2, 0($3)
L13:
	la	$2, x1
	lw	$2, 0($2)
	la	$3, T11
	sw	$2, 0($3)
	la	$2, y1
	lw	$2, 0($2)
	la	$3, T11
	lw	$3, 0($3)
	sgt	$2, $2, $0
	sgt	$3, $3, $0
	and	$2, $2, $3
	la	$3, T9
	sw	$2, 0($3)
	la	$2, x1
	lw	$2, 0($2)
	la	$3, T10
	sw	$2, 0($3)
	la	$2, c1
	lw	$2, 0($2)
	la	$3, T10
	lw	$3, 0($3)
	sgt	$2, $2, $0
	sgt	$3, $3, $0
	and	$2, $2, $3
	la	$3, T9
	lw	$3, 0($3)
	sgt	$2, $2, $0
	sgt	$3, $3, $0
	or	$2, $2, $3
	la	$3, T7
	sw	$2, 0($3)
	la	$2, y1
	lw	$2, 0($2)
	la	$3, T8
	sw	$2, 0($3)
	la	$2, c1
	lw	$2, 0($2)
	la	$3, T8
	lw	$3, 0($3)
	sgt	$2, $2, $0
	sgt	$3, $3, $0
	and	$2, $2, $3
	la	$3, T7
	lw	$3, 0($3)
	sgt	$2, $2, $0
	sgt	$3, $3, $0
	or	$2, $2, $3
	beq	$2, $0, L5
	li	$2, 0x1
	la	$3, c2
	sw	$2, 0($3)
	j L6
L5:
	li	$2, 0x0
	la	$3, c2
	sw	$2, 0($3)
L6:
	li	$2, 0x4
	la	$3, T4
	sw	$2, 0($3)
	la	$2, c2
	lw	$2, 0($2)
	la	$3, T4
	lw	$3, 0($3)
	mul	$2, $2, $3
	la	$3, T2
	sw	$2, 0($3)
	li	$2, 0x2
	la	$3, T3
	sw	$2, 0($3)
	la	$2, s1
	lw	$2, 0($2)
	la	$3, T3
	lw	$3, 0($3)
	mul	$2, $2, $3
	la	$3, T2
	lw	$3, 0($3)
	add	$2, $2, $3
	la	$3, T1
	sw	$2, 0($3)
	la	$2, s0
	lw	$2, 0($2)
	la	$3, T1
	lw	$3, 0($3)
	add	$2, $2, $3
	jr	$31


	.data
	.align 0
T1:	.word 0
T10:	.word 0
T11:	.word 0
T14:	.word 0
T15:	.word 0
T16:	.word 0
T17:	.word 0
T18:	.word 0
T19:	.word 0
T2:	.word 0
T20:	.word 0
T21:	.word 0
T22:	.word 0
T23:	.word 0
T24:	.word 0
T27:	.word 0
T3:	.word 0
T30:	.word 0
T31:	.word 0
T32:	.word 0
T33:	.word 0
T34:	.word 0
T37:	.word 0
T38:	.word 0
T39:	.word 0
T4:	.word 0
T42:	.word 0
T45:	.word 0
T46:	.word 0
T47:	.word 0
T48:	.word 0
T49:	.word 0
T50:	.word 0
T51:	.word 0
T52:	.word 0
T7:	.word 0
T8:	.word 0
T9:	.word 0
c1:	.word 0
c2:	.word 0
s0:	.word 0
s1:	.word 0
x:	.word 0
x0:	.word 0
x1:	.word 0
y:	.word 0
y0:	.word 0
y1:	.word 0

