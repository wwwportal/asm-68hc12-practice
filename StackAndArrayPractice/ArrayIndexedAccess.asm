FIRSTNUM        equ     $1002
        org     $1000
Array   db      18, $23, %00110110
Array2  dw      $3214, $5673
Result  ds      1

        org     $2000
        lds     #$2000
        
        ldx     #Array2
        
        ldaa    1,x+