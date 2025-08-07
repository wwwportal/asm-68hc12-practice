; Reverse.asm

; Modified by:          Yassine Amraoui
; Student Number(s):    041044570
; Course:               CST8216
; Date:                 2025-07-25
;
; Purpose       To copy and reverse and array, while performing the following
;               additional operations to decrypt the Secret Message. After
;               reading in a value, we decrypt the value by
;                a. dividing the value by 3
;               b. then adding 32 to the value
;               c. storing the value

; Decryption Constants
DIVISOR         equ     3       ; Value in supplied array will be divided by
                                ; this value
ADDED_VALUE     equ     32      ; Divided value will have 32 added to it

                org     $1000
Source_Array
#include A3B_Array.txt
End_Source_Array
                org        $1020                        ; Secret Message will appear
                                                        ; starting here
Destination_Array
                ds      End_Source_Array-Source_Array   ; auto calculate Array Size
End_Destination_Array

                org     $2000
                lds     #$2000                  ; Initialize Stack
                ldx     #Source_Array           ; Point to Start of The Source Array
                ldy     #End_Destination_Array  ; Point to End of The Destination Array
Start           ldab    1,x+                    ; Get Dividend from source Array
                                                ; then increment source Array pointer
                pshx                            ; save source array pointer
                ldx     #DIVISOR                ; X is the divisor
                idiv                            ; answer in X
                                                ; remainder in D
                ldab    #32                     ; store value 32 in accumulator B
                abx   // add to a one byte location                          ; add 32 to X (division result)
                stx     1,y-                    ; store Modified Value in Destination Array
                                                ; and increment Y
                pulx                            ; restore source array pointer
                cpx     #End_Source_Array       ; compare pointer with end of source array
                blo     Start                   ; loop back to start if lower than
                                                ; the end of the source array
                end                             ; otherwise end the program