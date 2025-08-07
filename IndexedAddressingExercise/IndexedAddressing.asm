; IDX_Questions.asm
;
; Author: Yassine Amraoui
; Course: CST8216

LEN     equ     EndArray-MyArray

        org     $1000
MyArray db      $10, $62, $72, $15, $08, $44
EndArray

Result  ds      4

        org     $2000
        lds     #$2000
        ldx     #MyArray
        ldd     MyArray
        exg     a,b
        ldaa    0,x
        inx
        ldab    2,x
        ldaa    3,x+
        ldy     #Result
        staa    4,y
        tfr     a,b
        stab    1,y+
        end