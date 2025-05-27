.MODEL SMALL
.STACK 100H

.DATA
    INPUT_MSG  DB 'Input the Binary Number:$'
    OUTPUT_MSG DB 'Output: $'

.CODE
MAIN PROC
    ; Set up data segment
    MOV AX, @DATA
    MOV DS, AX

    ; Display input prompt
    MOV AH, 9
    LEA DX, INPUT_MSG
    INT 21H

    ; Initialize registers
    XOR BX, BX      ; Clear BX (will store binary number)
    MOV CX, 0       ; Counter to track how many bits entered

READ_LOOP:
    MOV AH, 1       ; Read a character
    INT 21H
    CMP AL, 0DH     ; Check if Enter is pressed
    JE PROCESS_OUTPUT

    ; Convert ASCII '0' or '1' to actual 0 or 1
    AND AL, 0FH     ; '0' becomes 0, '1' becomes 1

    SHL BX, 1       ; Shift BX left to make space for new bit
    OR BL, AL       ; Insert the bit into BX (only using 8 bits here)
    INC CX          ; Count the bit

    CMP CX, 16      ; Allow only max 16 bits
    JE PROCESS_OUTPUT
    JMP READ_LOOP

PROCESS_OUTPUT:
    ; Print output header
    MOV AH, 9
    LEA DX, OUTPUT_MSG
    INT 21H

    ; Reset counter for printing
    MOV CL, 16

PRINT_LOOP:
    SHL BX, 1       ; MSB to carry
    JNC PRINT_ZERO
    MOV DL, '1'
    JMP PRINT_CHAR

PRINT_ZERO:
    MOV DL, '0'

PRINT_CHAR:
    MOV AH, 2
    INT 21H
    LOOP PRINT_LOOP

    ; Exit program
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN