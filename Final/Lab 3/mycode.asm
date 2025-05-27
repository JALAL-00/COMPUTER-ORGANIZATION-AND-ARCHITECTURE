.MODEL SMALL
.STACK 100H

.DATA
    INPUT_MSG       DB 'Input binary number (6 to 16 bits): $'
    ONE_MSG         DB 13, 10, 'Number of 1s: $'
    ZERO_MSG        DB 13, 10, 'Number of 0s: $'
    PARITY_MSG      DB 13, 10, 'Parity Flag: $'
    EVEN_MSG        DB '1 (Even parity)$'
    ODD_MSG         DB '0 (Odd parity)$'
    NEWLINE         DB 13, 10, '$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Print input message
    MOV AH, 9
    LEA DX, INPUT_MSG
    INT 21H

    ; Initialize registers
    XOR BX, BX      
    XOR CX, CX      
    XOR SI, SI      

READ_LOOP:
    MOV AH, 1
    INT 21H
    CMP AL, 0DH     
    JE CHECK_LENGTH

    AND AL, 0FH    
    SHL BX, 1       
    OR BL, AL       
    INC CX          

    CMP AL, 1
    JNE SKIP_ONE
    INC SI          ; Count of 1s
SKIP_ONE:

    CMP CX, 16
    JE DISPLAY_RESULT
    JMP READ_LOOP

CHECK_LENGTH:
    CMP CX, 6
    JB READ_LOOP    ; If less than 6 bits, continue input

DISPLAY_RESULT:
    ; Count of 0s = CX - SI
    MOV DI, CX
    SUB DI, SI

    ; Show number of 1s
    MOV AH, 9
    LEA DX, ONE_MSG
    INT 21H
    MOV AX, SI
    CALL PRINT_NUM

    ; Show number of 0s
    MOV AH, 9
    LEA DX, ZERO_MSG
    INT 21H
    MOV AX, DI
    CALL PRINT_NUM

    ; Use TEST instruction to set parity flag
    TEST BL, 0FFH   ; Check parity of lower 8 bits

    ; Display parity flag
    MOV AH, 9
    LEA DX, PARITY_MSG
    INT 21H

    JP ODD_PARITY   ; Jump if Parity = 0 (odd parity)
    LEA DX, EVEN_MSG
    JMP SHOW_PARITY

ODD_PARITY:
    LEA DX, ODD_MSG

SHOW_PARITY:
    MOV AH, 9
    INT 21H

    MOV AH, 4CH
    INT 21H

MAIN ENDP


PRINT_NUM PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    MOV CX, 0
    MOV BX, 10

DIV_LOOP:
    XOR DX, DX
    DIV BX
    PUSH DX
    INC CX
    CMP AX, 0
    JNE DIV_LOOP

PRINT_DIGITS:
    POP DX
    ADD DL, '0'
    MOV AH, 2
    INT 21H
    LOOP PRINT_DIGITS

    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT_NUM ENDP

END MAIN