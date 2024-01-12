.model small
.stack 100h
.data
        STR1 DB 'Enter expression: $'
        sum_output db 13, 10, "The sum of ", "$"
        diff_output db "The difference of ", "$"
        mul_output db "The product of ", "$"
        div_output db "The quotient is ", "$"
        rem_output db " and remainder is ", "$"
        and_output db " and ", "$"
        is_output db " is ", "$"
        period_output db ".", "$"
        INSTR1 DB 20 DUP("$")
        NEWLINE DB 10,13,"$"
        num1_O db ?
        num2_O db ?
        num1_T db ?
        num2_T db ? 
        first db ?
        second db ?
        third db ?
        fourth db ?
        dividend db ?
        divisor db ?
        first_ones db ?
        first_tens db ?

.code
    main proc near

        MOV AX,@DATA
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

        ; parse INSTR1
        mov al, INSTR1+4
        cmp al, '+'
        je @add
        cmp al, '-'
        je @sub
        cmp al, '*'
        je @mul
        cmp al, '/'
        je @div
        
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

        ; Prints new line
        lea dx, newline
        mov ah, 09h
        int 21h

        ; Prints sum output
        lea dx, diff_output
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

        cmp     bx, cx
        jae     subtractionPos
        xchg    bx, cx          ; Swap if 1st number < 2nd number
        mov     dl, "-"         ; ... and display negative sign
        mov     ah, 02h         
        int     21h

subtractionPos:
        ; Perform subtraction
        sub bl, cl

        mov al, bl
        mov ah, 0
        aas

        mov cl, al
        mov bl, ah 

        add bh, bl
        mov bl, bh
        sub bl, ch

        mov al, bl 
        mov ah, 0
        aas

        mov bh, ah 
        mov bl, al

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

@mul:  
        MOV bh, INSTR1+2
        sub bh, 48
        mov num1_T, bh

        MOV bl, INSTR1+3
        sub bl, 48
        mov num1_O, bl  

        MOV ch, INSTR1+5
        sub ch, 48
        mov num2_T, ch

        MOV cl, INSTR1+6
        sub cl, 48
        mov num2_O, cl

        ; Prints new line
        lea dx, newline
        mov ah, 09h
        int 21h

        ; Prints sum output
        lea dx, mul_output
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
        int 21H

        ; Initializing variables
        mov first, 0
        mov second, 0
        mov third, 0
        mov fourth, 0
        
        ; Multiplying num1_O and num2_O
        mov al, num2_O
        mul num1_O
        mov ah, 00h
        aam
        add third, ah    ; 1st carry
        add fourth, al
        
        ; Multiplying num1_T and num2_O
        mov al, num2_O
        mul num1_T
        mov ah, 00h
        aam
        add second, ah   ; carry
        add third, al
        
        ; Multiplying num1_O and num2_T
        mov al, num2_T
        mul num1_O
        mov ah, 00h
        aam
        add second, ah   ; carry
        add third, al
        
        ; Multiplying num1_T and num2_T
        mov al, num2_T
        mul num1_T
        mov ah, 00h
        aam
        add first, ah    ; carry
        add second, al
        
        mov al, third
        mov ah, 00h
        aam
        add second, ah
        mov third, al 
        
        mov al, second
        mov ah, 00h
        aam
        mov second, al
        add first, ah
        
        ; Displaying the result
        mov dl, first
        add dl, 48
        mov ah, 02h
        int 21h 
        
        mov dl, second
        add dl, 48
        mov ah, 02h
        int 21h
        
        mov dl, third
        add dl, 48
        mov ah, 02h
        int 21h
        
        mov dl, fourth
        add dl, 48
        mov ah, 02h
        int 21h

        lea dx, period_output
        mov ah, 09h
        int 21h

        MOV AH,09H
        LEA DX,NEWLINE
        INT 21H
        jmp @end

@div:  
        MOV bh, INSTR1+2
        sub bh, 48

        MOV bl, INSTR1+3
        sub bl, 48

        ;combing two numbers
        mov ax,bx
        aad
        mov bx,ax

        MOV ch, INSTR1+5
        sub ch, 48

        MOV cl, INSTR1+6
        sub cl, 48

        ;combing two numbers
        mov ax,cx
        aad
        mov cx,ax

        cmp bx, cx
        jl below
        jge above

above:
        ;dividing the number
        mov al,bl
        div cl
        mov bl,ah
        aam
        mov cx,ax

        ; Prints new line
        lea dx, newline
        mov ah, 09h
        int 21h

        lea dx, div_output
        mov ah, 09h
        int 21h

        mov num2_T, ch
        mov num2_O, cl

        ;displaying the result
        mov dl,ch
        add dl,30h
        mov ah,02h
        int 21h
           
        mov dl,cl
        add dl,30h
        mov ah,02h
        int 21h
    
        lea dx, rem_output
        mov ah, 09h
        int 21h

        cmp bl, 9
        jle single
        jg double

single:
        ;displaying the result
        mov dl,bl
        add dl,30h
        mov ah,02h
        int 21h

        lea dx, period_output
        mov ah, 09h
        int 21h

        MOV AH,09H
        LEA DX,NEWLINE
        INT 21H
        jmp @end

double:
        ;displaying the result
        MOV bh, INSTR1+5
        sub bh, 48
        mov num1_T, bh

        MOV bl, INSTR1+6
        sub bl, 48
        mov num1_O, bl
        
        ; Initializing variables
        mov first, 0
        mov second, 0
        mov third, 0
        mov fourth, 0
        
        ; Multiplying num1_O and num2_O
        mov al, num2_O
        mul num1_O
        mov ah, 00h
        aam
        add third, ah    ; 1st carry
        add fourth, al
        
        ; Multiplying num1_T and num2_O
        mov al, num2_O
        mul num1_T
        mov ah, 00h
        aam
        add second, ah   ; carry
        add third, al
        
        ; Multiplying num1_O and num2_T
        mov al, num2_T
        mul num1_O
        mov ah, 00h
        aam
        add second, ah   ; carry
        add third, al
        
        ; Multiplying num1_T and num2_T
        mov al, num2_T
        mul num1_T
        mov ah, 00h
        aam
        add first, ah    ; carry
        add second, al
        
        mov al, third
        mov ah, 00h
        aam
        add second, ah
        mov third, al 
        
        mov al, second
        mov ah, 00h
        aam
        mov second, al
        add first, ah

        MOV bh, INSTR1+2
        sub bh, 48
        mov first_tens, bh

        MOV bl, INSTR1+3
        sub bl, 48
        mov first_ones, bl

        ; third:fourth

        ; Perform subtraction
        mov bl, first_ones
        sub bl, fourth

        mov al, bl
        mov ah, 0
        aas

        mov fourth, al
        mov bl, ah 

        add first_tens, bl
        mov bl, first_tens
        sub bl, third

        mov al, bl 
        mov ah, 0
        aas

        mov first_tens, ah 
        mov first_ones, al

        mov ah, 02h
        mov dl, first_ones
        add dl, 48
        int 21h

        mov ah, 02h
        mov dl, fourth
        add dl, 48
        int 21h

        lea dx, period_output
        mov ah, 09h
        int 21h

        MOV AH,09H
        LEA DX,NEWLINE
        INT 21H
        jmp @end

below:
        ;dividing the number
        mov al,bl
        div cl
        mov bl,ah
        aam
        mov cx,ax

        ; Prints new line
        lea dx, newline
        mov ah, 09h
        int 21h

        lea dx, div_output
        mov ah, 09h
        int 21h

        ;displaying the result
        mov dl,ch
        add dl,30h
        mov ah,02h
        int 21h
           
        mov dl,cl
        add dl,30h
        mov ah,02h
        int 21h
    
        lea dx, rem_output
        mov ah, 09h
        int 21h
           
        mov ah, 02h
        mov dl, INSTR1+2
        int 21h

        mov ah, 02h
        mov dl, INSTR1+3
        int 21h

        lea dx, period_output
        mov ah, 09h
        int 21h

        MOV AH,09H
        LEA DX,NEWLINE
        INT 21H
        jmp @end

@end:
        MOV AH,4CH
        INT 21H
        main endp
end main