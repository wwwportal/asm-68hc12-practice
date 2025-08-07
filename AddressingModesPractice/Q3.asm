STACK   	equ     $2000
FIRSTNUM        equ 	%11000011
SECONDNUM       equ     30
THIRDNUM        equ     $30

        	org 	$1000
MyArray 	db	$22, $91, $08, $C0, $02      ;
Result 		ds 	2

        org $2000
Start   lds #STACK

        ldaa #FIRSTNUM
        ldab #SECONDNUM
        adda MyArray
        staa Result
        stab Result+1
        ldaa MyArray+4
        ldab Result
        decb
        ldaa #THIRDNUM
        coma
        std  Result
        swi
        swi
        end