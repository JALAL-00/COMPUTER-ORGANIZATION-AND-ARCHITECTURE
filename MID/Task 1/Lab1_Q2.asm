.MODEL SMALL
.STACK 100H
.DATA

    X DB ?
    Y DB ?
    RESULT DB ?

.CODE
MAIN PROC

    MOV AX, @DATA  ; Initialize Data Segment
    MOV DS, AX


    MOV AH, 1      ; Input x
    INT 21H
    SUB AL, 30H
    MOV X, AL


    MOV AH, 2      ; Line Break
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H


    MOV AH, 1      ; Input y
    INT 21H
    SUB AL, 30H
    MOV Y, AL

    
    MOV AH, 2      ; Line Break
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H


    
    MOV AL, Y     ; Calculate (y + 2) - (x + 1)
    ADD AL, 2    

    MOV BL, X    
    ADD BL, 1

    SUB AL, BL   ; AL = (y + 2) - (x + 1)

    ADD AL, 30H  ; Convert result to ASCII
    MOV RESULT, AL

    ; Display Result
    MOV AH, 2
    MOV DL, RESULT
    INT 21H

    ; Program Termination
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN