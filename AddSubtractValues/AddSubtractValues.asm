; First.asm
;
; Author:               Yassine Amraoui
; Student Number:       041044570
; Date:                 2025-06-11
;
; Purpose:              Add the following values: $25 + $37 - $1
;

        org     $1000   ; Origin for Program Data
p:      db      $25     ; First addend is at location p
q:      db      $37     ; Second addend is at location q
r:      ds      1       ; Sum will be stored at location r
        org     $2000   ; Origin for Program Instructions
        ldaa    p       ; Load value at p into accumulator a
        adda    q       ; Add value at q into accumulator a
        deca            ; Decrement a
        staa    r       ; Store accumulator a at location r
        end