.data
gameBoard:  	.ascii	 "\n\n\n\n| . . . . | . . . . | . . . . | . . . . |   a b c d"
				.ascii 	  	   "\n| . . . . | . . . . | . . . . | . . . . |   e f g h"
				.ascii     	   "\n| . . . . | . . . . | . . . . | . . . . |   i j k l"
				.ascii    	   "\n| . . . . | . . . . | . . . . | . . . . |   m n o p"
				.asciiz   	   "\n|   (0)   |   (1)   |   (2)   |   (3)   |   (index)\n"

offset:    .half   6,   8,  10,  12,  16,  18,  20,  22,  26,  28,  30,  32,  36,  38,  40,  42
           .half  60,  62,  64,  66,  70,  72,  74,  76,  80,  82,  84,  86,  90,  92,  94,  96
           .half 114, 116, 118, 120, 124, 126, 128, 130, 134, 136, 138, 140, 144, 146, 148, 150
           .half 168, 170, 172, 174, 178, 180, 182, 184, 188, 190, 192, 194, 198, 200, 202, 204

 cell:	.half 0
 grid:	.half 1
 zero:	.half 'z'
.text

main:
lh		$t4, grid
lh		$t5, cell
lh		$t0, zero
lh		$t6, zero
lh		$t7, zero

sub		$t0, $t0, 'a'

mul 	$t0, $t5, 4
mul		$t4, $t4, 4
add 	$t0, $t4, $t0
divu	$t5, $4
mfhi	$t5
add		$t0, $t5, $t0

li $v0, 1
add $a0, $zero, $t0
syscall

mul	$t0, $t0, 2
lh 	$t6, offset($t0)
li	$t7, 'X'
sb	$t7, gameBoard($t6)

#li	$v0, 4
#la	$a0, gameBoard
#syscall




li $v0, 10
syscall
