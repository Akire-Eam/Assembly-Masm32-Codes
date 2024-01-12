DATA SEGMENT
        STR1 DB 'Enter expression: $'
        sum_output db 13, 10, "The sum of ", "$"
        diff_output db "The difference of ", "$"
        and_output db " and ", "$"
        is_output db " is ", "$"
        period_output db ".", "$"
        STR2 DB "YOUR STRING IS ->$"
        STR3 DB "FIRST CHARACTER IS ->$"
        STR4 DB "LAST CHARACTER IS ->$"
        INSTR1 DB 20 DUP("$")
        num1_digit2 dw ?
        NEWLINE DB 10,13,"$"
        total_age dw ?
        N DB "$"
        S DB ?

DATA ENDS

CODE SEGMENT
        ASSUME DS:DATA,CS:CODE
START:

        MOV AX,DATA
        MOV DS,AX

        LEA SI,INSTR1

;GET STRING
        MOV AH,09H
        LEA DX,STR1
        INT 21H

        MOV AH,0AH
        MOV DX,SI
        INT 21H

        MOV AH,09H
        LEA DX,NEWLINE
        INT 21H

;PRINT THE STRING

        MOV AH,09H
        LEA DX,STR2
        INT 21H

        MOV AH,09H
        LEA DX,INSTR1+2
        INT 21H

        MOV AH,09H
        LEA DX,NEWLINE
        INT 21H

        ; parse INSTR1
        mov al, INSTR1+4
        cmp al, '+'
        je @add
        cmp al, '-'
        je @sub
        

;PRINT FIRST CHARACTER OF STRING
@add:  
        MOV bh, INSTR1+2
        sub bh, 48

        MOV bl, INSTR1+3
        sub bl, 48

        MOV ch, INSTR1+5
        sub ch, 48

        MOV cl, INSTR1+6
        sub cl, 48

        ; Perform Addition
        add bl, cl

        mov al, bl
        mov ah, 0
        aaa

        mov cl, al
        mov bl, ah 

        add bl, bh
        add bl, ch

        mov al, bl 
        mov ah, 0
        aaa

        mov bx, ax

        ; Prints new line
        lea dx, newline
        mov ah, 09h
        int 21h

        ; Prints sum output
        lea dx, sum_output
        mov ah, 09h
        int 21h

        mov ah, 02h
        mov dl, INSTR1+2
        int 21h

        mov ah, 02h
        mov dl, INSTR1+3
        int 21h

        lea dx, and_output
        mov ah, 09h
        int 21h

        mov ah, 02h
        mov dl, INSTR1+5
        int 21h

        mov ah, 02h
        mov dl, INSTR1+6
        int 21h

        lea dx, is_output
        mov ah, 09h
        int 21h

        mov ah, 02h
        mov dl, bh
        add dl, 48
        int 21h

        mov ah, 02h
        mov dl, bl
        add dl, 48
        int 21h

        mov ah, 02h
        mov dl, cl
        add dl, 48
        int 21h

        lea dx, period_output
        mov ah, 09h
        int 21h

        MOV AH,09H
        LEA DX,NEWLINE
        INT 21H
        jmp @end

@sub:

        MOV bh, INSTR1+2
        sub bh, 48

        MOV bl, INSTR1+3
        sub bl, 48

        MOV ch, INSTR1+5
        sub ch, 48

        MOV cl, INSTR1+6
        sub cl, 48

        ; Perform Addition
        add bl, cl

        mov al, bl
        mov ah, 0
        aaa

        mov cl, al
        mov bl, ah 

        add bl, bh
        add bl, ch

        mov al, bl 
        mov ah, 0
        aaa

        mov bx, ax

        ; Prints new line
        lea dx, newline
        mov ah, 09h
        int 21h

        ; Prints sum output
        lea dx, sum_output
        mov ah, 09h
        int 21h

        mov ah, 02h
        mov dl, INSTR1+2
        int 21h

        mov ah, 02h
        mov dl, INSTR1+3
        int 21h

        lea dx, and_output
        mov ah, 09h
        int 21h

        mov ah, 02h
        mov dl, INSTR1+5
        int 21h

        mov ah, 02h
        mov dl, INSTR1+6
        int 21h

        lea dx, is_output
        mov ah, 09h
        int 21h

        mov ah, 02h
        mov dl, bh
        add dl, 48
        int 21h

        mov ah, 02h
        mov dl, bl
        add dl, 48
        int 21h

        mov ah, 02h
        mov dl, cl
        add dl, 48
        int 21h

        lea dx, period_output
        mov ah, 09h
        int 21h

        MOV AH,09H
        LEA DX,NEWLINE
        INT 21H

;PRINT LAST CHARACTER OF STRING

        MOV AH,09H
        LEA DX,STR4
        INT 21H

        ADD SI,3

     L1:
        DEC SI
        MOV BL,BYTE PTR[SI]

;        MOV AH,09H
;        LEA DX,NEWLINE
;        INT 21H

;        MOV AH,02H
;        MOV DL,BL
;        INT 21H
  
        ADD SI,2
        CMP BYTE PTR[SI],"$"
        JNE L1

        MOV AH,02H
        MOV DL,BL
        INT 21H
        
        MOV AH,02H
        MOV DL,BL
        INT 21H

@end:
        MOV AH,4CH
        INT 21H
        CODE ENDS
END START