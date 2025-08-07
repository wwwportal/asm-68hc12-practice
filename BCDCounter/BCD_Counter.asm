; BCD_Counter.asm
; Author:               D. Haley, Faculty
; Modified by:          Yassine Amraoui
; Student Number(s):    041044570
; Course:               CST8216
; Date:                 2025-07-25
;
; Purpose       BCD Counter $00 - $15 (BCD) using Hex Displays
;               and a single register, Accumulator A, for the count
;               The range of counting can be altered by changing the
;               FIRST_BCD and END_BCD constants
;
; ***** DO NOT CHANGE ANY CODE BETWEEN THESE MARKERS *****
; Library Routines  - to be used in your solution
;

Config_Hex_Displays         equ        $2117
Delay_Ms                    equ        $211F
Hex_Display                 equ        $2139
Extract_Msb                 equ        $2144
Extract_Lsb                 equ        $2149

; Program Constants - to be used in your solution
STACK           equ     $2000
                                ; Port P (PPT) Display Selection Values
DIGIT3_PP0      equ     %1110   ; Left-most display MSB
DIGIT2_PP1      equ     %1101   ; 2nd from left-most display LSB

; Delay Subroutine Value  - to be used in your solution
DVALUE  equ     #250            ; Delay value (base 10) 0 - 255 ms
                                ; 125 = 1/8 second <- good for Dragon12 Board

; ***** END OF DO NOT CHANGE ANY CODE BETWEEN THESE MARKERS *****

; BCD Count constants  - to be used in your solution
; Changing these values will change the Starting and End BCD counts

FIRST_BCD        equ     $00     ; Starting BCD count
END_BCD          equ     $15     ; Ending BCD count0

        org     $2000
Start   lds     #STACK          ; Initialize the Stack
        clra                    ; clear A
        jsr     Config_HEX_Displays ; Use the Hex Displays to display the counts
        ldaa    FIRST_BCD       ; load BCD to A

Loop    psha                    ; push BCD
        
        jsr     Extract_Msb     ; Extract MSB from Count to A
        ldab    #DIGIT3_PP0      ; Specify port to B
        jsr     Hex_Display     ; Display Digit on Hex Display
        
        ldaa    #DVALUE         ; load delay argument to A
        jsr     Delay_Ms        ; Delay a few milliseconds

        pula                    ; Pull BCD to extract LSB
        psha                    ; Push BCD because subroutines destroy it
        
        jsr     Extract_Lsb     ; Extract LSB from Count
        ldab    #DIGIT2_PP1
        jsr     Hex_Display     ; Display digit on Hex Display
        
        ldaa    #DVALUE         ; load delay argument to A
        jsr     Delay_Ms        ; Delay a few milliseconds
        
        pula                    ; pull BCD
        adda    #$01            ; Add 1 to the Count
        daa                     ; Decimal Adjust Addition A
        cmpa    #END_BCD        ; Compare accumulator A with END_BCD
        bls     Loop            ; Branch to Loop with current count if
                                ; A is lower than or equal to END_BCD
        ldaa    FIRST_BCD
        bra     Loop
        end

; Continually Count FIRST_BCD ... END_BCD ... FIRST_BCD ... END_BCD