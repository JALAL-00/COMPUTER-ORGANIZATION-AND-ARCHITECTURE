.MODEL SMALL
.STACK 100H

.DATA
    INPUT_MSG  DB 'Enter a binary number:$'
    OUTPUT_MSG DB 'Inverted Output: $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Display input prompt
    MOV AH, 9
    LEA DX, INPUT_MSG
    INT 21H

    ; Clear BX (accumulator for binary)
    XOR BX, BX
    MOV CX, 0       ; Bit counter

READ_BIN:
    MOV AH, 1       ; Read character
    INT 21H
    CMP AL, 0DH     ; Check Enter key
    JE APPLY_NOT

    ; Convert ASCII to binary digit (0 or 1)
    AND AL, 0FH
    SHL BX, 1       ; Shift BX left
    OR BL, AL       ; Add current bit
    INC CX          ; Increase bit count
    CMP CX, 16      ; Limit to 16 bits
    JE APPLY_NOT
    JMP READ_BIN

APPLY_NOT:
    NOT BX          ; Invert bits

    ; Show output message
    MOV AH, 9
    LEA DX, OUTPUT_MSG
    INT 21H

    ; Print the inverted bits
    MOV CL, 16      ; Bit counter

PRINT_BITS:
    SHL BX, 1       ; MSB to carry
    JNC PRINT_0
    MOV DL, '1'
    JMP DISPLAY

PRINT_0:
    MOV DL, '0'

DISPLAY:
    MOV AH, 2
    INT 21H
    LOOP PRINT_BITS

    ; Exit
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN