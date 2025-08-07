STACK   equ     $2000

        org 	$1000
NUM1    db      $30

        org     $2000
Start   lds     #STACK
        ldaa    #NUM1
        ldab    NUM1
        end