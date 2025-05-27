.MODEL SMALL
.STACK 100H
.DATA

    NAME_MSG DB 'JALAL UDDIN$'
    DEPT_MSG DB 'BSc in CSE$'
    ID_MSG   DB '22-46356-1$'

.CODE
MAIN PROC

    MOV AX, @DATA ; Initialize Data
    MOV DS, AX

    MOV AH, 9     ; Display Name
    LEA DX, NAME_MSG
    INT 21H

    MOV AH,2      ; LINE BREAK
    MOV DL,0AH
    INT 21H
    MOV DL,0DH
    INT 21H

    MOV AH, 9     ; Display Department
    LEA DX, DEPT_MSG
    INT 21H

    MOV AH,2      ; LINE BREAK
    MOV DL,0AH
    INT 21H
    MOV DL,0DH
    INT 21H

    MOV AH, 9     ; Display ID
    LEA DX, ID_MSG
    INT 21H

    ; Program Termination
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
