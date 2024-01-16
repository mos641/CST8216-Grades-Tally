; GradesII.asm
;
; Author:               Mostapha A
; Course:               CST8216 Processor Architecture
;
; Purpose:              To Tally up the number of As, Bs, Cs, Ds and Fs
;                       in a Grades Array as per Flowchart for GradesII
;                       which uses a Switch-Case approach.

;
        org     $1020
Grades
#include Grades.txt     ; Grades file supplied for assignment
End_Grades

; Expected Result

;              $103A $103B $103C $103D  $103E $103F
;                 5     3     2    3     N/A    3

; as shown in the sumulator

        org     $103A   ; storage for counting grades start here
Storage ds      6

        org     $2000
        lds     #$2000  ; Stack initialization
        
; load pointers for beginning of grades array, and storage for counting
        ldx     #Grades
        ldy     #Storage

; Read grade and start of loop
A       ldaa    1,x+	; load acc a with beginning array, incrementing each loop

; compare the indexed array value to count each letter grade
CheckF  cmpa    #'F'
        beq     AsgnF
CheckD  cmpa    #'D'	; compare to D
        beq     AsgnD
CheckC  cmpa    #'C'	; compare to C
        beq     AsgnC
CheckB  cmpa    #'B'	; compare to B
        beq     AsgnB
CheckA  cmpa    #'A'	; compare to A
        beq     AsgnA
        bra     Check
        
; Increment the appropriate memory address depending on grade letter
AsgnA   ldaa    0,y	; increment address for letter grade A
        inca
        staa    0,y
        bra     Check
AsgnB   ldaa    1,y	; increment address for letter grade B
        inca
        staa    1,y
        bra     Check
AsgnC   ldaa    2,y	; increment address for letter grade C
        inca
        staa    2,y
        bra     Check
AsgnD   ldaa    3,y	; increment address for letter grade D
        inca
        staa    3,y
        bra     Check
AsgnF   ldaa    5,y	; increment address for letter grade F
        inca
        staa    5,y
        bra     Check

; Check if all grades have been processed
Check   cpx     #End_Grades
        bne     A       ; compare incremented array pointer to end grades
                        ; if it is not equal, loop otherwise end program
                        
        swi             ; forces program to quit executing in memory
        end             ; end the program
        