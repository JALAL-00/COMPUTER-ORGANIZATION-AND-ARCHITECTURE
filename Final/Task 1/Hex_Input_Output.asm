.MODEL SMALL
.STACK 100H

.DATA
    INPUT_MSG  DB 'Enter a 4-digit hexadecimal number: $'
    OUTPUT_MSG DB 13, 10, 'You entered: $' ; Newline before output

.CODE
MAIN PROC
    ; Setup DS
    MOV AX, @DATA
    MOV DS, AX

    ; Show input message
    MOV AH, 9
    LEA DX, INPUT_MSG
    INT 21H

    ; Read 4 hex digits
    XOR BX, BX         ; Clear BX to store the input
    MOV CX, 4          ; Expect 4 hex digits (16 bits)

READ_HEX:
    MOV AH, 1
    INT 21H            ; Read character into AL

    ; Skip echoing (no MOV DL, AL / INT 21H)

    ; Convert ASCII to binary
    MOV AH, 0
    CMP AL, '0'
    JB INVALID
    CMP AL, '9'
    JBE NUM
    CMP AL, 'A'
    JB INVALID
    CMP AL, 'F'
    JBE ALPHA
    JMP INVALID

NUM:
    SUB AL, '0'
    JMP STORE

ALPHA:
    SUB AL, 'A'
    ADD AL, 10

STORE:
    SHL BX, 4
    OR BL, AL
    LOOP READ_HEX

    ; Show output message
    MOV AH, 9
    LEA DX, OUTPUT_MSG
    INT 21H

    ; Print BX as hex
    MOV CX, 4          ; 4 hex digits

PRINT_HEX:
    ROL BX, 4
    MOV AL, BL
    AND AL, 0Fh
    CMP AL, 9
    JBE PRINT_NUM
    ADD AL, 7

PRINT_NUM:
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 2
    INT 21H
    LOOP PRINT_HEX

    ; Exit
    MOV AH, 4CH
    INT 21H

INVALID:
    ; Handle invalid input (optional)
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN