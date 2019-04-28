# Drew Pesall - 1129022
# CS 370
# 2/11/2019


.data
gameBoard:  	.ascii	 "\n\n\n\n| . . . . | . . . . | . . . . | . . . . |   a b c d\t\t"
				.ascii 	  	   "\n| . . . . | . . . . | . . . . | . . . . |   e f g h\t\t"
				.ascii     	   "\n| . . . . | . . . . | . . . . | . . . . |   i j k l\t\t"
				.ascii    	   "\n| . . . . | . . . . | . . . . | . . . . |   m n o p\t\t"
				.asciiz   	   "\n|   (0)   |   (1)   |   (2)   |   (3)   |   (index)\n"
				
introText:  	.asciiz   "Start a One-Player, 4󫶘x4, 3D Tic-Tac-Toe Game.\n"

offset:    .half   6,   8,  10,  12,  16,  18,  20,  22,  26,  28,  30,  32,  36,  38,  40,  42
           .half  60,  62,  64,  66,  70,  72,  74,  76,  80,  82,  84,  86,  90,  92,  94,  96
           .half 114, 116, 118, 120, 124, 126, 128, 130, 134, 136, 138, 140, 144, 146, 148, 150
           .half 168, 170, 172, 174, 178, 180, 182, 184, 188, 190, 192, 194, 198, 200, 202, 204
                      
comb: 	 .ascii  "0b0c0d 0f0k0p 0e0i0m 1a2a3a 1b2c3d 1e2i3m 1f2k3p"      # 0a
         .ascii  "0a0c0d 0f0j0n 1b2b3b 1f2j3n                     "      # 0b
         .ascii  "0a0b0d 0g0k0o 1c2c3c 1g2k3o                     "      # 0c
         .ascii  "0a0b0c 0h0l0p 0g0j0m 1d2d3d 1g2j3m 1c2b3a 1h2l3p"      # 0d
         .ascii  "0a0i0m 0f0g0h 1e2e3e 1f2g3h                     "      # 0e
         .ascii  "0e0g0h 0b0j0n 0a0k0p 1f2f3f                     "      # 0f
         .ascii  "0e0f0h 0c0k0o 0d0j0m 1g2g3g                     "      # 0g
         .ascii  "0e0f0g 0d0l0p 1h2h3h 1g2f3e                     "      # 0h
         .ascii  "0a0e0m 0j0k0l 1i2i3i 1j2k3l                     "      # 0i
         .ascii  "0i0k0l 0b0f0n 0m0g0d 1j2j3j                     "      # 0j
         .ascii  "0i0j0l 0c0g0o 0a0f0p 1k2k3k                     "      # 0k
         .ascii  "0i0j0k 0d0h0p 1l2l3l 1k2j3i                     "      # 0l
         .ascii  "0a0e0i 0n0o0p 0j0g0d 1m2m3m 1i2e3a 1n2o3p 1j2g3d"      # 0m
         .ascii  "0m0o0p 0b0f0j 1n2n3n 1j2f3b                     "      # 0n
         .ascii  "0m0n0p 0c0g0k 1o2o3o 1k2g3c                     "      # 0o
         .ascii  "0m0n0o 0d0h0l 0k0f0a 1p2p3p 1l2h3d 1k2f3a 1o2n2m"      # 0p
         .ascii  "1b1c1d 1f1k1p 1e1i1m 0a2a3a                     "      # 1a
         .ascii  "1a1c1d 1f1j1n 0b2b3b 0a2c3d                     "      # 1b
         .ascii  "1a1b1d 1g1k1o 0c2c3c 0d2b3a                     "      # 1c
         .ascii  "1a1b1c 1h1l1p 1g1j1m 0d2d3d                     "      # 1d
         .ascii  "1a1i1m 1f1g1h 0e2e3e 0a2i3m                     "      # 1e
         .ascii  "1e1g1h 1b1j1n 1a1k1p 0f2f3f 0a2k3p 0b2j3n 0e2g3h"      # 1f
         .ascii  "1e1f1h 1c1k1o 1d1j1m 0g2g3g 0d2j3m 0c2k3o 0h2f3e"      # 1g
         .ascii  "1e1f1g 1d1l1p 0h2h3h 0d2l3p                     "      # 1h
         .ascii  "1a1e1m 1j1k1l 0i2i3i 0m2e3a                     "      # 1i
         .ascii  "1i1k1l 1b1f1n 1d1g1m 0j2j3j 0m2g3d 0n2f3b 0i2k3l"      # 1j
         .ascii  "1i1j1l 1c1g1o 1a1f1p 0k2k3k 0p2f3a 0o2g3c 0l2j3i"      # 1k
         .ascii  "1i1j1k 1d1h1p 0l2l3l 0p2h3d                     "      # 1l
         .ascii  "1a1e1i 1n1o1p 1j1g1d 0m2m3m                     "      # 1m
         .ascii  "1m1o1p 1b1f1j 0n2n3n 0m2o3p                     "      # 1n
         .ascii  "1m1n1p 1c1g1k 0o2o3o 0p2n3m                     "      # 1o
         .ascii  "1m1n1o 1d1h1l 1k1f1a 0p2p3p                     "      # 1p
         .ascii  "2b2c2d 2f2k2p 2e2i2m 0a1a3a                     "      # 2a
         .ascii  "2a2c2d 2f2j2n 0b1b3b 3a1c0d                     "      # 2b
         .ascii  "2a2b2d 2g2k2o 0c1c3c 3d1b0a                     "      # 2c
         .ascii  "2a2b2c 2h2l2p 2g2j2m 0d1d3d                     "      # 2d
         .ascii  "2a2i2m 2f2g2h 0e1e3e 3a1i0m                     "      # 2e
         .ascii  "2e2g2h 2b2j2n 2a2k2p 0f1f3f 0h1g3e 0n1j3b 0p1k3a"      # 2f
         .ascii  "2e2f2h 2c2k2o 2d2j2m 0g1g3g 0o1k3c 0e1f3h 0m1j3d"      # 2g
         .ascii  "2e2f2g 2d2l2p 0h1h3h 3d1l0p                     "      # 2h
         .ascii  "2a2e2m 2j2k2l 0i1i3i 3m1e0a                     "      # 2i
         .ascii  "2i2k2l 2b2f2n 2d2g2m 0j1j3j 0l1k3i 0b1f3n 0d1g3m"      # 2j
         .ascii  "2i2j2l 2c2g2o 2a2f2p 0k1k3k 0c1g3o 0i1j3l 0a1f3p"      # 2k
         .ascii  "2i2j2k 2d2h2p 0l1l3l 0d1h3p                     "      # 2l
         .ascii  "2a2e2i 2n2o2p 2d2g2j 0m1m3m                     "      # 2m
         .ascii  "2m2o2p 2b2f2j 0n1n3n 0p1o3m                     "      # 2n
         .ascii  "2m2n2p 2c2g2k 0o1o3o 0m1n3p                     "      # 2o
         .ascii  "2m2n2o 2d2h2l 2a2f2k 0p1p3p                     "      # 2p
         .ascii  "3b3c3d 3f3k3p 3e3i3m 0a1a2a 0d1c2b 0p1k2f 0m1i2e"      # 3a
         .ascii  "3a3c3d 3f3j3n 0b1b2b 0n1j2f                     "      # 3b
         .ascii  "3a3b3d 3g3k3o 0c1c2c 0o1k2g                     "      # 3c
         .ascii  "3a3b3c 3h3l3p 3g3j3m 0d1d2d 0a1b2c 0m1j2g 0p1l2h"      # 3d
         .ascii  "3a3i3m 3f3g3h 0e1e2e 0h1g2f                     "      # 3e
         .ascii  "3e3g3h 3b3j3n 3a3k3p 0f1f2f                     "      # 3f
         .ascii  "3e3f3h 3c3k3o 3d3j3m 0g1g2g                     "      # 3g
         .ascii  "3e3f3g 3d3l3p 0h1h2h 0e1f2g                     "      # 3h
         .ascii  "3a3e3m 3j3k3l 0i1i2i 0l1k2j                     "      # 3i
         .ascii  "3i3k3l 3b3f3n 3d3g3m 0j1j2j                     "      # 3j
         .ascii  "3i3j3l 3c3g3o 3a3f3p 0k1k2k                     "      # 3k
         .ascii  "3i3j3k 3d3h3p 0l1l2l 0i1j2k                     "      # 3l
         .ascii  "3a3e3i 3n3o3p 3d3g3j 0m1m2m 0a1e2i 0d1g2j 0p1o2n"      # 3m
         .ascii  "3m3o3p 3b3f3j 0n1n2n 0b1f2j                     "      # 3n
         .ascii  "3m3n3p 3c3g3k 0o1o2o 0c1g2k                     "      # 3o
         .ascii  "3m3n3o 3d3h3l 3a3f3k 0p1p2p 0a1f2k 0d1h2l 0m1n2o"      # 3p

gridMessage:		.asciiz		"\nSelect a grid(0-3): "
gridError:			.asciiz		"\nPlease select a valid grid."

testGrid:			.word 	0
testIndex:			.byte	'a'

indexMessage:		.asciiz		"\nSelect an index(a-p): "
indexError:			.asciiz		"\nPlease select a valid index."

continueMessage:	.asciiz		"\nContinue playing?(y/n): "
newGameMessage: 	.asciiz		"\nStart a new game?(y/n): "
validMessage:		.asciiz		"\nPlease select a valid option."

madeIt:				.asciiz		"\nMade it"

playerSelectPieceMessage: 	.asciiz		"\nWhat would you like to play as?(x/o): "
playerSelectPieceError:		.asciiz		"\nPlease select a valid piece."

occupiedPosition:	.asciiz		"\nThere is already a piece there."

computerFirstO:		.asciiz		"\nThe computer went first and selected 'O'. You are playing as 'X'"
computerFirstX:		.asciiz		"\nThe computer went first and selected 'X'. You are playing as 'O'"

pieceX:     		.byte 	'x'
pieceO:     		.byte 	'o'
grid0:				.byte	 '0'
grid1:				.byte	 '1'
grid2:				.byte	 '2'
grid3:				.byte	 '3'

spota:				.byte	 'a'
spotb:				.byte	 'b'
spotc:				.byte	 'c'
spotd:				.byte	 'd'
spote:				.byte	 'e'
spotf:				.byte	 'f'
spotg:				.byte	 'g'
spoti:				.byte	 'h'
spoth:				.byte	 'i'
spotj:				.byte	 'j'
spotk:				.byte	 'k'
spotl:				.byte	 'l'
spotm:				.byte	 'm'
spotn:				.byte	 'n'
spoto:				.byte	 'o'
spotp:				.byte	 'p'

playerPiece:		.word	0
computerPiece:		.word	0

playerWon:			.asciiz		"Congratulations, you won! "	
computerWon:		.asciiz		"Uh oh, looks like the computer won! "
xWon:				.asciiz		"X got four in a a row. "
oWon:				.asciiz		"O got four in a row. "
gameTie:			.asciiz		"All cells filled: Game results in a tie."

yes:				.byte 	'y'
no:					.byte 	'n'
zero:				.half 	0
occupiedPositionMessage: .asciiz "\nThere is already a piece there."

userInput:			.space	4
userInputGrid:		.space 	4
userInputIndex:		.space 	4

userPreviousGrid:	.word	0
userPreviousIndex:	.word   0

computerPreviousGrid:	.word	0
computerPreviousIndex:	.word	0

index1:				.byte	'a'
index2:				.byte	'p'

.text

main:

jal initialDisplay

li $a1, 2  #Here you set $a1 to the max bound.
li $v0, 42  #generates the random number.
syscall

beqz	$a0, computerSelectPiece

jal 	playerSelectPiece

li $v0, 10
	syscall

initialDisplay: # Displays Initial Game Board and Greeting

# Prints out greeting
li 		$v0, 4
la 		$a0, introText
syscall

jr		$ra

resetGameBoard:
lh		$t0, zero
add		$t0, $t4, $t0
mul		$t0, $t0, 2
lh 		$t1, offset($t0)
li		$t2, '.'
sb		$t2, gameBoard($t1)
add		$t4, $t4, 1
ble		$t4, 64, resetGameBoard

j main

computerSelectPiece:

li		$v0, 4
la		$a0, computerFirstO
syscall

jal		playerSetX

j 		computerTurnO


computerTurnO:

# Selecting Grid
jal 	selectGridComputer


# Selecting Index
jal		selectIndexComputer

# Printing Board
lh 		$t0, zero
lh 		$t1, zero
lh		$t2, zero
lh 		$t3, zero
lh		$t4, zero

lb		$t1, ($s6) 
lb     	$t2, ($s7) 
sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index
sb		$t2, computerPreviousIndex

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4


add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)
li		$t2, 'O'

# Checks to see if there is already a piece there.
lb		$t9, gameBoard($t1)
bne		$t9, '.', computerTurnO

sb		$t2, gameBoard($t1)

jal		readCombComputerO

jal		gameLoopX

computerTurnX:

# Selecting Grid
jal 	selectGridComputer


# Selecting Index
jal		selectIndexComputer

# Printing Board
lh 		$t0, zero
lh 		$t1, zero
lh		$t2, zero
lh 		$t3, zero
lh		$t4, zero

lb		$t1, ($s6) 
lb     	$t2, ($s7) 
sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index
sb		$t2, computerPreviousIndex

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4


add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)
li		$t2, 'X'

# Checks to see if there is already a piece there.
lb		$t9, gameBoard($t1)
bne		$t9, '.', computerTurnX

sb		$t2, gameBoard($t1)

jal		readCombComputerX

jal		gameLoopO


playerSelectPiece:
#Display prompt
li      $v0, 4
la      $a0, playerSelectPieceMessage
syscall

#Enter your desired piece
move    $a0,$t2
li  	$v0, 8
la  	$a0, userInput
li  	$a1, 10
syscall

j start

playerSetO:	
li 		$v0, 'O'
sb 		$v0, playerPiece
li 		$v0, 'X'
sb 		$v0, computerPiece
jr  	$ra

playerSetX:
li 		$v0, 'X'
sb 		$v0, playerPiece
li 		$v0, 'O'
sb 		$v0, computerPiece
jr		$ra

start:

#Compare
la     	$s2, pieceX
lb     	$t2, ($s2)
la     	$s3, userInput
lb     	$t3, ($s3)
beq    	$t2,$t3,gameLoopX
la		$s4, pieceO
lb		$t2, ($s4)
beq		$t2,$t3,gameLoopO

li		$v0, 4
la		$a0, playerSelectPieceError
syscall

j		playerSelectPiece

jr 		$ra

pgrid0:
la $s6, grid0
jr 		$ra
pgrid1:
la $s6, grid1
jr 		$ra
pgrid2:
la $s6, grid2
jr 		$ra
pgrid3:
la $s6, grid3
jr 		$ra

selectGridComputer:

xor  $a0, $a0, $a0     # Set a seed number.
li   $a1, 4           # random number 0 to 15
li   $v0, 42           # random number generator
syscall

sb		$a0, computerPreviousGrid

sb		$a0, userInputGrid

beqz	$a0, pgrid0
beq		$a0, 1, pgrid1
beq		$a0, 2, pgrid2
beq		$a0, 3, pgrid3

#Compare
la     	$s2, grid0
lb     	$t2, ($s2)
lb     	$t3, ($s6)
beq    	$t2,$t3,test
la		$s4, grid1
lb		$t2, ($s4)
beq		$t2,$t3,test
la		$s4, grid2
lb		$t2, ($s4)
beq		$t2,$t3,test
la		$s4, grid3
lb		$t2, ($s4)
beq		$t2,$t3,test

li		$v0, 4
la		$a0, gridError
syscall

j		selectGridComputer

jr 		$ra

selectGrid:

#Display prompt
li      $v0, 4
la      $a0, gridMessage
syscall

#Enter your desired grid
move    $a0,$t2
li  	$v0, 8
la  	$a0, userInputGrid
li  	$a1, 10
syscall

#Compare
la     	$s2, grid0
lb     	$t2, ($s2)
la     	$s6, userInputGrid
lb     	$t3, ($s6)
beq    	$t2,$t3,test
la		$s4, grid1
lb		$t2, ($s4)
beq		$t2,$t3,test
la		$s4, grid2
lb		$t2, ($s4)
beq		$t2,$t3,test
la		$s4, grid3
lb		$t2, ($s4)
beq		$t2,$t3,test

li		$v0, 4
la		$a0, gridError
syscall

j		selectGrid

jr 		$ra

test:

jr		$ra

continueGameX:
# Continue?
li      $v0, 4
la      $a0, continueMessage
syscall

#Enter your desired choice
move    $a0,$t2
li  	$v0, 8
la  	$a0, userInput
li  	$a1, 10
syscall

#Compare
la     	$s2, yes
lb     	$t2, ($s2)
la     	$s3, userInput
lb     	$t3, ($s3)
beq    	$t2,$t3,computerTurnX
la		$s4, no
lb		$t2, ($s4)
beq		$t2,$t3,newGame

li		$v0, 4
la		$a0, validMessage
syscall

j		continueGameX

jr 		$ra

continueGameO:
# Continue?
li      $v0, 4
la      $a0, continueMessage
syscall

#Enter your desired choice
move    $a0,$t2
li  	$v0, 8
la  	$a0, userInput
li  	$a1, 10
syscall

#Compare
la     	$s2, yes
lb     	$t2, ($s2)
la     	$s3, userInput
lb     	$t3, ($s3)
beq    	$t2,$t3,computerTurnO
la		$s4, no
lb		$t2, ($s4)
beq		$t2,$t3,newGame

li		$v0, 4
la		$a0, validMessage
syscall

j		continueGameO

jr 		$ra

exit:
li		$v0, 10
syscall

newGame:
# New Game?
li      $v0, 4
la      $a0, newGameMessage
syscall

#Enter your desired choice
move    $a0,$t2
li  	$v0, 8
la  	$a0, userInput
li  	$a1, 10
syscall

#Compare
la     	$s2, yes
lb     	$t2, ($s2)
la     	$s3, userInput
lb     	$t3, ($s3)
lh		$t4, zero
beq    	$t2,$t3,resetGameBoard
la		$s4, no
lb		$t2, ($s4)
beq		$t2,$t3,exit

li		$v0, 4
la		$a0, validMessage
syscall

j		newGame

jr 		$ra

sindexa:
la		$s7, spota
sb		$s7, computerPreviousIndex
jr		$ra
sindexb:
la		$s7, spotb
sb		$s7, computerPreviousIndex
jr		$ra
sindexc:
la		$s7, spotc
sb		$s7, computerPreviousIndex
jr		$ra
sindexd:
la		$s7, spotd
sb		$s7, computerPreviousIndex
jr		$ra
sindexe:
la		$s7, spote
sb		$s7, computerPreviousIndex
jr		$ra
sindexf:
la		$s7, spotf
sb		$s7, computerPreviousIndex
jr		$ra
sindexg:
la		$s7, spotg
sb		$s7, computerPreviousIndex
jr		$ra
sindexh:
la		$s7, spoth
sb		$s7, computerPreviousIndex
jr		$ra
sindexi:
la		$s7, spoti
sb		$s7, computerPreviousIndex
jr		$ra
sindexj:
la		$s7, spotj
sb		$s7, computerPreviousIndex
jr		$ra
sindexk:
la		$s7, spotk
sb		$s7, computerPreviousIndex
jr		$ra
sindexl:
la		$s7, spotl
sb		$s7, computerPreviousIndex
jr		$ra
sindexm:
la		$s7, spotm
sb		$s7, computerPreviousIndex
jr		$ra
sindexn:
la		$s7, spotn
sb		$s7, computerPreviousIndex
jr		$ra
sindexo:
la		$s7, spoto
sb		$s7, computerPreviousIndex
jr		$ra
sindexp:
la		$s7, spotp
sb		$s7, computerPreviousIndex
jr		$ra


playerWinScreen:

li		$v0, 4
la		$a0, playerWon
syscall

jr		$ra


selectIndexComputer: 

#Enter your desired choice
xor  $a0, $a0, $a0     # Set a seed number.
li   $a1, 16           # random number 0 to 15
li   $v0, 42           # random number generator
syscall

beqz	$a0, sindexa
beq		$a0, 1, sindexb
beq		$a0, 2, sindexc
beq		$a0, 3, sindexd
beq		$a0, 4, sindexe
beq		$a0, 5, sindexf
beq		$a0, 6, sindexg
beq		$a0, 7, sindexh
beq		$a0, 8, sindexi
beq		$a0, 9, sindexj
beq		$a0, 10, sindexk
beq		$a0, 11, sindexl
beq		$a0, 12, sindexm
beq		$a0, 13, sindexn
beq		$a0, 14, sindexo
beq		$a0, 15, sindexp

#Compare
la     	$s2, index1
lb     	$t2, ($s2)
lb     	$t3, ($s7)
blt    	$t3,$t2,indexRetry
la		$s4, index2
lb		$t2, ($s4)
bgt		$t3,$t2,indexRetry

jr 		$ra

selectIndex:
# Select Index
li      $v0, 4
la      $a0, indexMessage
syscall

#Enter your desired choice
move    $a0,$t2
li  	$v0, 8
la  	$a0, userInputIndex
li  	$a1, 10
syscall

#Compare
la     	$s2, index1
lb     	$t2, ($s2)
la     	$s7, userInputIndex
lb     	$t3, ($s7)
blt    	$t3,$t2,indexRetry
la		$s4, index2
lb		$t2, ($s4)
bgt		$t3,$t2,indexRetry

jr 		$ra

indexRetry:

li		$v0, 4
la		$a0, indexError
syscall

j		selectIndex

jr		$ra

gameLoopX:
jal		playerSetX

# Printing Board
li 		$v0, 4
la 		$a0, gameBoard
syscall

# Selecting Grid
jal 	selectGrid


# Selecting Index
jal		selectIndex

# Printing Board
lh 		$t0, zero
lh 		$t1, zero
lh		$t2, zero
lh 		$t3, zero
lh		$t4, zero

lb		$t1, ($s6) 
lb     	$t2, ($s7) 
sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4


add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)
li		$t2, 'X'

# Checks to see if there is already a piece there
lb		$t9, gameBoard($t1)
bne		$t9, '.', occupiedX

sb		$t2, gameBoard($t1)

li		$v0, 4
la		$a0, gameBoard
syscall

jal		readCombX ###########################################

# Continue?
jal		continueGameO

jr 		$ra

occupiedX:
li		$v0, 4
la		$a0, occupiedPosition
syscall
j		gameLoopX

jr		$ra

occupiedO:
li		$v0, 4
la		$a0, occupiedPosition
syscall
j		gameLoopO

jr		$ra

gameLoopO:
jal		playerSetO

# Printing Board
li 		$v0, 4
la 		$a0, gameBoard
syscall

# Selecting Grid
jal 	selectGrid


# Selecting Index
jal		selectIndex

# Printing Board
lh 		$t0, zero
lh 		$t1, zero
lh		$t2, zero
lh 		$t3, zero
lh		$t4, zero

# $s6 = grid
# $s7 = cell
lb		$t1, ($s6) 
lb     	$t2, ($s7) 
sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

# Equation: $t0 = (cell�4)�16 + grid�4 + cell%4
div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4


add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)
li		$t2, 'O'

# Checks to see if there is already a piece there.
lb		$t9, gameBoard($t1)
bne		$t9, '.', occupiedO

sb		$t2, gameBoard($t1)

li		$v0, 4
la		$a0, gameBoard
syscall

jal		readCombO

# Continue?
jal		continueGameX

jr 		$ra


winScreenX:
li		$v0, 4
la		$a0, xWon
syscall

li		$v0, 4
la		$a0, playerWon
syscall

j		newGame

winScreenO:
li		$v0, 4
la		$a0, oWon
syscall

li		$v0, 4
la		$a0, computerWon
syscall

j		newGame

readCombX: # $t0 = grid		$t1 = index
# Equation: (Grid�16+Index)�48
lb 		$t0, userInputGrid
sub		$t0, $t0, 48

lb		$t1, userInputIndex
sub		$t1, $t1, 'a'

mul		$t2, $t0, 16
add		$t2, $t2, $t1
mul		$t2, $t2, 48

lb 		$t3, comb($t2)

add		$t2, $t2, 1
lb 		$t4, comb($t2)

# Saving the $t2 offset in # $s5 and $s0
add		$s5, $t2, $zero
add		$s0, $t2, $zero

# $t3 = grid
# $t4 = index

sb		$t3, userPreviousGrid
sb		$t4, userPreviousIndex

j		winConditionX1

winConditionX1:

lb		$t1, userPreviousGrid 
lb     	$t2, userPreviousIndex

sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4

add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)

# Checks to see if there is already a piece there
lb		$t9, gameBoard($t1)
beq		$t9, 'X', winConditionX2

##############################################

add		$s5, $s5, 6
lb 		$t1, comb($s5)
add		$s5, $s5, 1
lb 		$t2, comb($s5)

sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4

add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)

# Checks to see if there is already a piece there
lb		$t9, gameBoard($t1)
beq		$t9, 'X', winConditionX2

#########################################################

add		$s5, $s5, 6
lb 		$t1, comb($s5)
add		$s5, $s5, 1
lb 		$t2, comb($s5)

sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4

add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)

# Checks to see if there is already a piece there
lb		$t9, gameBoard($t1)
beq		$t9, 'X', winConditionX2

#########################################################

add		$s5, $s5, 6
lb 		$t1, comb($s5)
add		$s5, $s5, 1
lb 		$t2, comb($s5)

sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4

add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)

# Checks to see if there is already a piece there
lb		$t9, gameBoard($t1)
beq		$t9, 'X', winConditionX2

#########################################################

add		$s5, $s5, 6
lb 		$t1, comb($s5)
add		$s5, $s5, 1
lb 		$t2, comb($s5)

sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4

add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)

# Checks to see if there is already a piece there
lb		$t9, gameBoard($t1)
beq		$t9, 'X', winConditionX2

#########################################################

add		$s5, $s5, 6
lb 		$t1, comb($s5)
add		$s5, $s5, 1
lb 		$t2, comb($s5)

sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4

add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)

# Checks to see if there is already a piece there
lb		$t9, gameBoard($t1)
beq		$t9, 'X', winConditionX2

#########################################################

add		$s5, $s5, 6
lb 		$t1, comb($s5)
add		$s5, $s5, 1
lb 		$t2, comb($s5)

sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4

add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)

# Checks to see if there is already a piece there
lb		$t9, gameBoard($t1)
beq		$t9, 'X', winConditionX2

j		continueGameO

winConditionX2:

add		$s5, $s5, 1
lb 		$t1, comb($s5)
add		$s5, $s5, 1
lb 		$t2, comb($s5)

sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4

add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)

# Checks to see if there is already a piece there
lb		$t9, gameBoard($t1)
beq		$t9, 'X', winConditionX3

j		continueGameO

winConditionX3:

add		$s5, $s5, 1
lb 		$t1, comb($s5)
add		$s5, $s5, 1
lb 		$t2, comb($s5)

sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4

add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)

# Checks to see if there is already a piece there
lb		$t9, gameBoard($t1)
beq		$t9, 'X', winScreenX

j		continueGameO

##################

readCombO: # $t0 = grid		$t1 = index
# Equation: (Grid�16+Index)�48
lb 		$t0, userInputGrid
sub		$t0, $t0, 48

lb		$t1, userInputIndex
sub		$t1, $t1, 'a'

mul		$t2, $t0, 16
add		$t2, $t2, $t1
mul		$t2, $t2, 48

lb 		$t3, comb($t2)

add		$t2, $t2, 1
lb 		$t4, comb($t2)

# Saving the $t2 offset in # $s5 and $s0
add		$s5, $t2, $zero
add		$s0, $t2, $zero

# $t3 = grid
# $t4 = index

sb		$t3, userPreviousGrid
sb		$t4, userPreviousIndex

j		winConditionO1

winConditionO1:

lb		$t1, userPreviousGrid 
lb     	$t2, userPreviousIndex

sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4

add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)

# Checks to see if there is already a piece there
lb		$t9, gameBoard($t1)
beq		$t9, 'O', winConditionO2

##############################################

add		$s5, $s5, 6
lb 		$t1, comb($s5)
add		$s5, $s5, 1
lb 		$t2, comb($s5)

sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4

add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)

# Checks to see if there is already a piece there
lb		$t9, gameBoard($t1)
beq		$t9, 'O', winConditionO2

#########################################################

add		$s5, $s5, 6
lb 		$t1, comb($s5)
add		$s5, $s5, 1
lb 		$t2, comb($s5)

sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4

add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)

# Checks to see if there is already a piece there
lb		$t9, gameBoard($t1)
beq		$t9, 'O', winConditionO2

#########################################################

add		$s5, $s5, 6
lb 		$t1, comb($s5)
add		$s5, $s5, 1
lb 		$t2, comb($s5)

sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4

add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)

# Checks to see if there is already a piece there
lb		$t9, gameBoard($t1)
beq		$t9, 'O', winConditionO2

#########################################################

add		$s5, $s5, 6
lb 		$t1, comb($s5)
add		$s5, $s5, 1
lb 		$t2, comb($s5)

sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4

add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)

# Checks to see if there is already a piece there
lb		$t9, gameBoard($t1)
beq		$t9, 'O', winConditionO2

#########################################################

add		$s5, $s5, 6
lb 		$t1, comb($s5)
add		$s5, $s5, 1
lb 		$t2, comb($s5)

sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4

add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)

# Checks to see if there is already a piece there
lb		$t9, gameBoard($t1)
beq		$t9, 'O', winConditionO2

#########################################################

add		$s5, $s5, 6
lb 		$t1, comb($s5)
add		$s5, $s5, 1
lb 		$t2, comb($s5)

sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4

add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)

# Checks to see if there is already a piece there
lb		$t9, gameBoard($t1)
beq		$t9, 'O', winConditionO2

j		continueGameX

winConditionO2:

add		$s5, $s5, 1
lb 		$t1, comb($s5)
add		$s5, $s5, 1
lb 		$t2, comb($s5)

sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4

add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)

# Checks to see if there is already a piece there
lb		$t9, gameBoard($t1)
beq		$t9, 'O', winConditionO3

j		continueGameX

winConditionO3:

add		$s5, $s5, 1
lb 		$t1, comb($s5)
add		$s5, $s5, 1
lb 		$t2, comb($s5)

sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4

add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)

# Checks to see if there is already a piece there
lb		$t9, gameBoard($t1)
beq		$t9, 'O', winScreenO

j		continueGameX

#############################################
##################	Computer	###########################
#############################################

readCombComputerX: # $t0 = grid		$t1 = index
# Equation: (Grid�16+Index)�48
lb 		$t0, computerPreviousGrid

lb		$t1, computerPreviousIndex

mul		$t2, $t0, 16
add		$t2, $t2, $t1
mul		$t2, $t2, 48

lb 		$t3, comb($t2)

add		$t2, $t2, 1
lb 		$t4, comb($t2)

# Saving the $t2 offset in # $s5 and $s0
add		$s5, $t2, $zero
add		$s0, $t2, $zero

# $t3 = grid
# $t4 = index

sb		$t3, computerPreviousGrid
sb		$t4, computerPreviousIndex

j		winConditionComputerX1

winConditionComputerX1:

lb		$t1, ($s6) 
lb     	$t2, ($s7)

sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4

add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)

# Checks to see if there is already a piece there
lb		$t9, gameBoard($t1)
beq		$t9, 'X', winConditionComputerX2

##############################################

add		$s5, $s5, 6
lb 		$t1, comb($s5)
add		$s5, $s5, 1
lb 		$t2, comb($s5)

sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4

add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)

# Checks to see if there is already a piece there
lb		$t9, gameBoard($t1)
beq		$t9, 'X', winConditionComputerX2

#########################################################

add		$s5, $s5, 6
lb 		$t1, comb($s5)
add		$s5, $s5, 1
lb 		$t2, comb($s5)

sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4

add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)

# Checks to see if there is already a piece there
lb		$t9, gameBoard($t1)
beq		$t9, 'X', winConditionComputerX2

#########################################################

add		$s5, $s5, 6
lb 		$t1, comb($s5)
add		$s5, $s5, 1
lb 		$t2, comb($s5)

sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4

add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)

# Checks to see if there is already a piece there
lb		$t9, gameBoard($t1)
beq		$t9, 'X', winConditionComputerX2

#########################################################

add		$s5, $s5, 6
lb 		$t1, comb($s5)
add		$s5, $s5, 1
lb 		$t2, comb($s5)

sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4

add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)

# Checks to see if there is already a piece there
lb		$t9, gameBoard($t1)
beq		$t9, 'X', winConditionComputerX2

#########################################################

add		$s5, $s5, 6
lb 		$t1, comb($s5)
add		$s5, $s5, 1
lb 		$t2, comb($s5)

sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4

add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)

# Checks to see if there is already a piece there
lb		$t9, gameBoard($t1)
beq		$t9, 'X', winConditionComputerX2

#########################################################

add		$s5, $s5, 6
lb 		$t1, comb($s5)
add		$s5, $s5, 1
lb 		$t2, comb($s5)

sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4

add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)

# Checks to see if there is already a piece there
lb		$t9, gameBoard($t1)
beq		$t9, 'X', winConditionComputerX2

j		gameLoopO

winConditionComputerX2:

add		$s5, $s5, 1
lb 		$t1, comb($s5)
add		$s5, $s5, 1
lb 		$t2, comb($s5)

sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4

add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)

# Checks to see if there is already a piece there
lb		$t9, gameBoard($t1)
beq		$t9, 'X', winConditionComputerX3

j		gameLoopO

winConditionComputerX3:

add		$s5, $s5, 1
lb 		$t1, comb($s5)
add		$s5, $s5, 1
lb 		$t2, comb($s5)

sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4

add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)

# Checks to see if there is already a piece there
lb		$t9, gameBoard($t1)
beq		$t9, 'X', winScreenComputerX

j		gameLoopO

winScreenComputerX:
li		$v0, 4
la		$a0, gameBoard
syscall

li		$v0, 4
la		$a0, xWon
syscall

li		$v0, 4
la		$a0, computerWon
syscall

j		newGame


##################

readCombComputerO: # $t0 = grid		$t1 = index
# Equation: (Grid�16+Index)�48
lb 		$t0, computerPreviousGrid
lb		$t1, computerPreviousIndex

mul		$t2, $t0, 16
add		$t2, $t2, $t1
mul		$t2, $t2, 48

lb 		$t3, comb($t2)

add		$t2, $t2, 1
lb 		$t4, comb($t2)


# Saving the $t2 offset in # $s5 and $s0
add		$s5, $t2, $zero
add		$s0, $t2, $zero



# $t3 = grid
# $t4 = index

sb		$t3, computerPreviousGrid
sb		$t4, computerPreviousIndex

j		winConditionComputerO1

winConditionComputerO1:

lb		$t1, ($s6)
lb     	$t2, ($s7)

sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4

add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)

# Checks to see if there is already a piece there
lb		$t9, gameBoard($t1)
beq		$t9, 'O', winConditionComputerO2

##############################################

add		$s5, $s5, 6
lb 		$t1, comb($s5)
add		$s5, $s5, 1
lb 		$t2, comb($s5)

sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4

add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)

# Checks to see if there is already a piece there
lb		$t9, gameBoard($t1)
beq		$t9, 'O', winConditionComputerO2

#########################################################

add		$s5, $s5, 6
lb 		$t1, comb($s5)
add		$s5, $s5, 1
lb 		$t2, comb($s5)

sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4

add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)

# Checks to see if there is already a piece there
lb		$t9, gameBoard($t1)
beq		$t9, 'O', winConditionComputerO2

#########################################################

add		$s5, $s5, 6
lb 		$t1, comb($s5)
add		$s5, $s5, 1
lb 		$t2, comb($s5)

sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4

add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)

# Checks to see if there is already a piece there
lb		$t9, gameBoard($t1)
beq		$t9, 'O', winConditionComputerO2

#########################################################

add		$s5, $s5, 6
lb 		$t1, comb($s5)
add		$s5, $s5, 1
lb 		$t2, comb($s5)

sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4

add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)

# Checks to see if there is already a piece there
lb		$t9, gameBoard($t1)
beq		$t9, 'O', winConditionComputerO2

#########################################################

add		$s5, $s5, 6
lb 		$t1, comb($s5)
add		$s5, $s5, 1
lb 		$t2, comb($s5)

sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4

add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)

# Checks to see if there is already a piece there
lb		$t9, gameBoard($t1)
beq		$t9, 'O', winConditionComputerO2

#########################################################

add		$s5, $s5, 6
lb 		$t1, comb($s5)
add		$s5, $s5, 1
lb 		$t2, comb($s5)

sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4

add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)

# Checks to see if there is already a piece there
lb		$t9, gameBoard($t1)
beq		$t9, 'O', winConditionComputerO2

j		gameLoopX

winConditionComputerO2:

add		$s5, $s5, 1
lb 		$t1, comb($s5)
add		$s5, $s5, 1
lb 		$t2, comb($s5)

sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4

add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)

# Checks to see if there is already a piece there
lb		$t9, gameBoard($t1)
beq		$t9, 'O', winConditionComputerO3

j		gameLoopX

winConditionComputerO3:

add		$s5, $s5, 1
lb 		$t1, comb($s5)
add		$s5, $s5, 1
lb 		$t2, comb($s5)

sub		$t1, $t1, 48  # Grid
sub		$t2, $t2, 'a' # Index

div		$t0, $t2, 4
mul		$t0, $t0, 16

mul		$t1, $t1, 4

add		$t0, $t0, $t1
div		$t2, $t2, 4
mfhi	$t2
add		$t0, $t2, $t0

mul		$t0, $t0, 2
lh 		$t1, offset($t0)

# Checks to see if there is already a piece there
lb		$t9, gameBoard($t1)
beq		$t9, 'O', winScreenComputerO

j		gameLoopX

winScreenComputerO:
li		$v0, 4
la		$a0, gameBoard
syscall

li		$v0, 4
la		$a0, oWon
syscall

li		$v0, 4
la		$a0, computerWon
syscall

j		newGame
