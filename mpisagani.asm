.model small
.stack 100h
.data
    promptStart db "    Welcome to Isagani Game!","$"
    ; ----------------- IMPORTANT STRINGS USED THROUGHOUT THE GAME -----------------

    pak DB 'Press any key to continue...$'
    print_newline db 13, 10, "$"

    ; PLAYER AND AI MOVES
    promptAiMove01 db "AI moves from ", "$"
    promptAiMove02 db " to ", "$"
    promptPlayerWins db "Congratulations! You win!", "$"
    promptAiWins db "Oh no! Computer wins!", "$"
    prompt db "Your turn. Move from: ","$"
    promptMoveTo db "to: ","$"
    promptInvalid db "Invalid move! Press any key...$"
    playerMoves db 0
    MOVES DB 0
    AIMOVES DB 0
    TOTALAI DB  'Total AI moves: $'
    TOTALPL DB  'Your total moves: $'
    moveCountMsg db "Number of moves: ", "$"

    ; BOARD LINES -------
    arrayBoard1 db "[X]-\-[X]-/-[X]", "$"
    arrayBoard2 db "[ ]---[ ]---[ ]", "$"
    arrayBoard3 db "[O]-/-[O]-\-[O]", "$"
    divider db "     |     |     |", "$"
    column db "     a.    b.    c.", "$"
    empty db " ", "$"
    row_one db "1.", "$"
    row_two db "2.", "$"
    row_three db "3.", "$"

    ; INPUT SECTION PROMTS -------------------------
    playerInputT db 3, ?, 26 dup("$")
    playerInputT1 db ?
    playerInputT2 db ?
    playerInputF1 db ?
    playerInputF2 db ?
    playerInputF db 3, ?, 26 dup("$")
    win db ?
    win_ai db ?
    place01 db ?
    place02 db ?
    place03 db ?
    place04 db ?
    place05 db ?
    place06 db ?
    place07 db ?
    place08 db ?
    place09 db ?
    is_empty_bool db ?
    inp1 db ?
    inp2 db ?
    invalid_bool db ?
    invalid_bool_ai db ?
    valid_bool db ?
    valid_bool_ai db ?
    player_token_bool db 0
    ai_token db 0
    ai_avail db 0
    ai_token01 db 0
    ai_token02 db 0
    ai_token03 db 0
    ai_token_from1 db ?
    ai_token_to1 db ?
    ai_token_from2 db ?
    ai_token_to2 db ?
    randomNum db 0
    empty_spot1 db 0
    empty_spot2 db 0
    empty_spot3 db 0

    ; GAME RULES
    R DB 'Game Rules:$' 
    R1 DB '1. Players will take turns.$'
    R2 DB '2. You will start the game.$'
    R3 DB '3. You will use the token "O" and AI will use "X".$'
    R4 DB '4. The board is marked with row numbers and column letters.$'
    R5 DB '5. Enter column letter and row number to place your mark.$'
    R6 DB '6. Set 3 of your marks horizontally, vertically or diagonally to win.$'   
    R7 DB 'Good Luck!$'
    
    ; TRY AGAIN PROMPT MESSAGES -----------------------------
    TRA DB 'Want to play again? (y/n): $'
    WI DB  32, 32, 32, 'Wrong input! Press any key...                                                                                          $'   

    ; THIS LINE IS USED TO OVERWIRTE A LINE TO CLEAN THE AREA
    EMP db     '                                                                                                               $'
    ;--------------------------------------------------------

.code
    print_space proc near
    mov dl, 32
    mov ah, 02h
    int 21h
    ret
    print_space endp

    newline proc near
        lea dx, print_newline
        mov ah, 09h
        int 21h
        ret
    newline endp

    print_board proc near
    call newline
    call newline

    ; CLEAR SCREEN        
    MOV AX,0600H 
    MOV BH,07H 
    MOV CX,0000H 
    MOV DX,184FH 
    INT 10H
    
    ; SET CURSOR
    MOV AH, 2
    MOV BH, 0
    MOV DH, 6
    MOV DL, 30
    INT 10H

    lea dx, column
    mov ah, 09h
    int 21h
    call newline

    call print_space
    call print_space

    ; SET CURSOR 
    MOV AH, 2
    MOV DH, 7
    MOV DL, 30 
    INT 10H
    
    MOV AH, 2
    MOV DL, 32
    INT 21H

    lea dx, row_one
    mov ah, 09h
    int 21h
    call print_space
    lea dx, arrayBoard1
    mov ah, 09h
    int 21h
    call newline
    
    ; SET CURSOR
    MOV AH, 2
    MOV DH, 8
    MOV DL, 30 
    INT 10H 

    lea dx, divider
    mov ah, 09h
    int 21h
    call newline

    
    call print_space
    call print_space

    ; SET CURSOR
    MOV AH, 2
    MOV DH, 9
    MOV DL, 30 
    INT 10H
    
    MOV AH, 2
    MOV DL, 32
    INT 21H

    lea dx, row_two
    mov ah, 09h
    int 21h
    call print_space
    lea dx, arrayBoard2
    mov ah, 09h
    int 21h
    call newline

    ; SET CURSOR
    MOV AH, 2
    MOV DH, 10
    MOV DL, 30 
    INT 10H 

    lea dx, divider
    mov ah, 09h
    int 21h
    call newline

    call print_space
    call print_space

    ; SET CURSOR
    MOV AH, 2
    MOV DH, 11
    MOV DL, 30 
    INT 10H
        
    MOV AH, 2
    MOV DL, 32
    INT 21H  

    lea dx, row_three
    mov ah, 09h
    int 21h
    call print_space
    lea dx, arrayBoard3
    mov ah, 09h
    int 21h

    ; SET CURSOR
        MOV AH, 2
        MOV DH, 12
        MOV DL, 30 
        INT 10H 
    

        ; SET CURSOR
        MOV AH, 2
        MOV DH, 13
        MOV DL, 30 
        INT 10H
    
    LEA DX, TOTALPL
    MOV AH, 9
    INT 21H

    MOV AH, 02h
    MOV DL, MOVES
    ADD DL, '0'
    INT 21h

        ; SET CURSOR
        MOV AH, 2
        MOV DH, 14
        MOV DL, 30 
        INT 10H


    LEA DX, TOTALAI
    MOV AH, 9
    INT 21H

    MOV AH, 02h
    MOV DL, AIMOVES
    ADD DL, '0'
    INT 21h

    MOV AH, 02h
    MOV DL, 32
    INT 21h

    ; SET CURSOR
    MOV AH, 2
    MOV DH, 15
    MOV DL, 30 
    INT 10H

    call newline
    call newline
    ret
    print_board endp
    
    player_token_check proc near
    .if bl == 'O'
        mov player_token_bool, 01
    .endif
    ret
    player_token_check endp

    valid proc near
    ; move player token from a1 to a2, b1, b2 
    .if playerInputF1 == 'a' && playerInputF2 == '1'
        .if playerInputT1 == 'a' && playerInputT2 == '2'
            mov valid_bool, 01
        .elseif playerInputT1 == 'b' && playerInputT2 == '1'
            mov valid_bool, 01
        .elseif playerInputT1 == 'b' && playerInputT2 == '2'
            mov valid_bool, 01
        .else
            mov valid_bool, 00
        .endif
    ; move player token from a2 to a1, a3, b2 
    .elseif playerInputF1 == 'a' && playerInputF2 == '2'
        .if playerInputT1 == 'a' && playerInputT2 == '1'
            mov valid_bool, 01
        .elseif playerInputT1 == 'a' && playerInputT2 == '3'
            mov valid_bool, 01
        .elseif playerInputT1 == 'b' && playerInputT2 == '2'
            mov valid_bool, 01
        .else
            mov valid_bool, 00
        .endif
    ; move player token from a3 to a2, b2, b3 
    .elseif playerInputF1 == 'a' && playerInputF2 == '3'
        .if playerInputT1 == 'a' && playerInputT2 == '2'
            mov valid_bool, 01
        .elseif playerInputT1 == 'b' && playerInputT2 == '2'
            mov valid_bool, 01
        .elseif playerInputT1 == 'b' && playerInputT2 == '3'
            mov valid_bool, 01
        .else
            mov valid_bool, 00
        .endif
    ; move player token from b1 to a1, b2, c1
    .elseif playerInputF1 == 'b' && playerInputF2 == '1'
        .if playerInputT1 == 'a' && playerInputT2 == '1'
            mov valid_bool, 01
        .elseif playerInputT1 == 'b' && playerInputT2 == '2'
            mov valid_bool, 01
        .elseif playerInputT1 == 'c' && playerInputT2 == '1'
            mov valid_bool, 01
        .else
            mov valid_bool, 00
        .endif
    ; move player token from b2 to a1, a2, a3, b1, b3, c1, c2, c3 
    .elseif playerInputF1 == 'b' && playerInputF2 == '2'
        .if playerInputT1 == 'a' && playerInputT2 == '1'
            mov valid_bool, 01
        .elseif playerInputT1 == 'a' && playerInputT2 == '2'
            mov valid_bool, 01
        .elseif playerInputT1 == 'a' && playerInputT2 == '3'
            mov valid_bool, 01
        .elseif playerInputT1 == 'b' && playerInputT2 == '1'
            mov valid_bool, 01
        .elseif playerInputT1 == 'b' && playerInputT2 == '3'
            mov valid_bool, 01
        .elseif playerInputT1 == 'c' && playerInputT2 == '1'
            mov valid_bool, 01
        .elseif playerInputT1 == 'c' && playerInputT2 == '2'
            mov valid_bool, 01
        .elseif playerInputT1 == 'c' && playerInputT2 == '3'
            mov valid_bool, 01
        .else
            mov valid_bool, 00
        .endif
    ; move player token from b3 to a3, b2, c3 
    .elseif playerInputF1 == 'b' && playerInputF2 == '3'
        .if playerInputT1 == 'a' && playerInputT2 == '3'
            mov valid_bool, 01
        .elseif playerInputT1 == 'b' && playerInputT2 == '2'
            mov valid_bool, 01
        .elseif playerInputT1 == 'c' && playerInputT2 == '3'
            mov valid_bool, 01
        .else
            mov valid_bool, 00
        .endif
    ; move player token from c1 to b1, b2, c2 
    .elseif playerInputF1 == 'c' && playerInputF2 == '1'
        .if playerInputT1 == 'b' && playerInputT2 == '1'
            mov valid_bool, 01
        .elseif playerInputT1 == 'b' && playerInputT2 == '2'
            mov valid_bool, 01
        .elseif playerInputT1 == 'c' && playerInputT2 == '2'
            mov valid_bool, 01
        .else
            mov valid_bool, 00
        .endif
    ; move player token from c2 to b2, c1, c3 
    .elseif playerInputF1 == 'c' && playerInputF2 == '2'
        .if playerInputT1 == 'b' && playerInputT2 == '2'
            mov valid_bool, 01
        .elseif playerInputT1 == 'c' && playerInputT2 == '1'
            mov valid_bool, 01
        .elseif playerInputT1 == 'c' && playerInputT2 == '3'
            mov valid_bool, 01
        .else
            mov valid_bool, 00
        .endif
    ; move player token from c3 to b2, b3, c2 
    .elseif playerInputF1 == 'c' && playerInputF2 == '3'
        .if playerInputT1 == 'b' && playerInputT2 == '2'
            mov valid_bool, 01
        .elseif playerInputT1 == 'b' && playerInputT2 == '3'
            mov valid_bool, 01
        .elseif playerInputT1 == 'c' && playerInputT2 == '2'
            mov valid_bool, 01
        .else
            mov valid_bool, 00
        .endif
    .else   
        mov invalid_bool, 01
    .endif

    ret
    valid endp

    valid_ai proc near
    ; move ai token from a1 to a2, b1, b2 
    .if playerInputF1 == 'a' && playerInputF2 == '1'
        .if playerInputT1 == 'a' && playerInputT2 == '2'
            mov valid_bool_ai, 01
        .elseif playerInputT1 == 'b' && playerInputT2 == '1'
            mov valid_bool_ai, 01
        .elseif playerInputT1 == 'b' && playerInputT2 == '2'
            mov valid_bool_ai, 01
        .else
            mov valid_bool_ai, 00
        .endif
    ; move ai token from a2 to a1, a3, b2
    .elseif playerInputF1 == 'a' && playerInputF2 == '2'
        .if playerInputT1 == 'a' && playerInputT2 == '1'
            mov valid_bool_ai, 01
        .elseif playerInputT1 == 'a' && playerInputT2 == '3'
            mov valid_bool_ai, 01
        .elseif playerInputT1 == 'b' && playerInputT2 == '2'
            mov valid_bool_ai, 01
        .else
            mov valid_bool_ai, 00
        .endif
    ; move player token from a3 to a2, b2, b3 
    .elseif playerInputF1 == 'a' && playerInputF2 == '3'
        .if playerInputT1 == 'a' && playerInputT2 == '2'
            mov valid_bool_ai, 01
        .elseif playerInputT1 == 'b' && playerInputT2 == '2'
            mov valid_bool_ai, 01
        .elseif playerInputT1 == 'b' && playerInputT2 == '3'
            mov valid_bool_ai, 01
        .else
            mov valid_bool_ai, 00
        .endif
    ; move player token from b1 to a1, b2, c1
    .elseif playerInputF1 == 'b' && playerInputF2 == '1'
        .if playerInputT1 == 'a' && playerInputT2 == '1'
            mov valid_bool_ai, 01
        .elseif playerInputT1 == 'b' && playerInputT2 == '2'
            mov valid_bool_ai, 01
        .elseif playerInputT1 == 'c' && playerInputT2 == '1'
            mov valid_bool_ai, 01
        .else
            mov valid_bool_ai, 00
        .endif
    ; move player token from b2 to a1, a2, a3, b1, b3, c1, c2, c3 
    .elseif playerInputF1 == 'b' && playerInputF2 == '2'
        .if playerInputT1 == 'a' && playerInputT2 == '1'
            mov valid_bool_ai, 01
        .elseif playerInputT1 == 'a' && playerInputT2 == '2'
            mov valid_bool_ai, 01
        .elseif playerInputT1 == 'a' && playerInputT2 == '3'
            mov valid_bool_ai, 01
        .elseif playerInputT1 == 'b' && playerInputT2 == '1'
            mov valid_bool_ai, 01
        .elseif playerInputT1 == 'b' && playerInputT2 == '3'
            mov valid_bool_ai, 01
        .elseif playerInputT1 == 'c' && playerInputT2 == '1'
            mov valid_bool_ai, 01
        .elseif playerInputT1 == 'c' && playerInputT2 == '2'
            mov valid_bool_ai, 01
        .elseif playerInputT1 == 'c' && playerInputT2 == '3'
            mov valid_bool_ai, 01
        .else
            mov valid_bool_ai, 00
        .endif
    ; move player token from b3 to a3, b2, c3 
    .elseif playerInputF1 == 'b' && playerInputF2 == '3'
        .if playerInputT1 == 'a' && playerInputT2 == '3'
            mov valid_bool_ai, 01
        .elseif playerInputT1 == 'b' && playerInputT2 == '2'
            mov valid_bool_ai, 01
        .elseif playerInputT1 == 'c' && playerInputT2 == '3'
            mov valid_bool_ai, 01
        .else
            mov valid_bool_ai, 00
        .endif
    ; move player token from c1 to b1, b2, c2 
    .elseif playerInputF1 == 'c' && playerInputF2 == '1'
        .if playerInputT1 == 'b' && playerInputT2 == '1'
            mov valid_bool_ai, 01
        .elseif playerInputT1 == 'b' && playerInputT2 == '2'
            mov valid_bool_ai, 01
        .elseif playerInputT1 == 'c' && playerInputT2 == '2'
            mov valid_bool_ai, 01
        .else
            mov valid_bool_ai, 00
        .endif
    ; move player token from c2 to b2, c1, c3 
    .elseif playerInputF1 == 'c' && playerInputF2 == '2'
        .if playerInputT1 == 'b' && playerInputT2 == '2'
            mov valid_bool_ai, 01
        .elseif playerInputT1 == 'c' && playerInputT2 == '1'
            mov valid_bool_ai, 01
        .elseif playerInputT1 == 'c' && playerInputT2 == '3'
            mov valid_bool_ai, 01
        .else
            mov valid_bool_ai, 00
        .endif
    ; move player token from c3 to b2, b3, c2 
    .elseif playerInputF1 == 'c' && playerInputF2 == '3'
        .if playerInputT1 == 'b' && playerInputT2 == '2'
            mov valid_bool_ai, 01
        .elseif playerInputT1 == 'b' && playerInputT2 == '3'
            mov valid_bool_ai, 01
        .elseif playerInputT1 == 'c' && playerInputT2 == '2'
            mov valid_bool_ai, 01
        .else
            mov valid_bool_ai, 00
        .endif
    .else   
        mov invalid_bool_ai, 01
    .endif

    ret
    valid_ai endp

    ;description
    print_key PROC
        ; SET CURSOR
    MOV AH, 2
    MOV DH, 17
    MOV DL, 30
    INT 10H     
        
    LEA DX, pak ; PRESS ANY KEY
    MOV AH, 9
    INT 21H
            
    MOV AH, 7    ; INPUT WITHOUT ECHO
    INT 21H
    ret
    print_key ENDP

    ;description
    computermove PROC
        ; SET CURSOR
        MOV AH, 2
        MOV DH, 15
        MOV DL, 30 
        INT 10H

        lea dx, promptAiMove01
        mov ah, 09h
        int 21h

        mov dl, ai_token_from1
        mov ah, 02h
        int 21h

        mov dl, ai_token_from2
        mov ah, 02h
        int 21h

        lea dx, promptAiMove02
        mov ah, 09h
        int 21h

        mov dl, ai_token_to1
        mov ah, 02h
        int 21h

        mov dl, ai_token_to2
        mov ah, 02h
        int 21h

        mov dl, '.'
        mov ah, 02h
        int 21h
        ret
    computermove ENDP

    invalid proc near
    .if invalid_bool == 01
        
        ; SET CURSOR
        MOV AH, 2
        MOV DH, 15
        MOV DL, 30 
        INT 10H 
    

        ; SET CURSOR
        MOV AH, 2
        MOV DH, 15
        MOV DL, 39 
        INT 10H

        lea dx, promptInvalid
        mov ah, 09h
        int 21h

        MOV AH, 7     ; INPUT WITHOUT ECHO
        INT 21H 
        
        ; SET CURSOR
        MOV AH, 2
        MOV DH, 14
        MOV DL, 30 
        INT 10H 
    

        ; SET CURSOR
        MOV AH, 2
        MOV DH, 15
        MOV DL, 30 
        INT 10H
    
            
        LEA DX, EMP   ; EMPTY LINE TO OVERWRITE ANOTHER LINE TO CLEAN THE SPACE
        MOV AH, 9
        INT 21H 
        
        ; SET CURSOR
        MOV AH, 2
        MOV DH, 14
        MOV DL, 30 
        INT 10H 
    

        ; SET CURSOR
        MOV AH, 2
        MOV DH, 15
        MOV DL, 30 
        INT 10H

        call player_move
    .endif
    ret
    invalid endp

    invalid_ai proc near
    .if invalid_bool_ai == 01
        call ai_move
    .endif
    ret
    invalid_ai endp

    move_cond proc near
    .if bl == 'a' && bh == '1'
        lea si, arrayBoard1
        add si, 1
    .elseif bl == 'a' && bh == '2'
        lea si, arrayBoard2
        add si, 1
    .elseif bl == 'a' && bh == '3'
        lea si, arrayBoard3
        add si, 1
    .elseif bl == 'b' && bh == '1'
        lea si, arrayBoard1
        add si, 7
    .elseif bl == 'b' && bh == '2'
        lea si, arrayBoard2
        add si, 7
    .elseif bl == 'b' && bh == '3'
        lea si, arrayBoard3
        add si, 7
    .elseif bl == 'c' && bh == '1'
        lea si, arrayBoard1
        add si, 13
    .elseif bl == 'c' && bh == '2'
        lea si, arrayBoard2
        add si, 13
    .elseif bl == 'c' && bh == '3'
        lea si, arrayBoard3
        add si, 13
    .else   
        mov invalid_bool, 01
    .endif
    ret
    move_cond endp 
    
    ai_move_cond proc near
    .if bl == 'a' && bh == '1'
        lea si, arrayBoard1
        add si, 1
    .elseif bl == 'a' && bh == '2'
        lea si, arrayBoard2
        add si, 1
    .elseif bl == 'a' && bh == '3'
        lea si, arrayBoard3
        add si, 1
    .elseif bl == 'b' && bh == '1'
        lea si, arrayBoard1
        add si, 7
    .elseif bl == 'b' && bh == '2'
        lea si, arrayBoard2
        add si, 7
    .elseif bl == 'b' && bh == '3'
        lea si, arrayBoard3
        add si, 7
    .elseif bl == 'c' && bh == '1'
        lea si, arrayBoard1
        add si, 13
    .elseif bl == 'c' && bh == '2'
        lea si, arrayBoard2
        add si, 13
    .elseif bl == 'c' && bh == '3'
        lea si, arrayBoard3
        add si, 13
    .else   
        mov invalid_bool_ai, 01
    .endif

    ret

    ai_move_cond endp 
    
    ai_from proc near
    .if bl == 'X'
        mov ai_token, 01
    .else
        mov ai_token, 00
    .endif
    ret
    ai_from endp
    
    is_empty proc near
    .if bl == ' '
        mov is_empty_bool, 01
    .else
        mov is_empty_bool, 00
    .endif
    ret
    is_empty endp

    ;description
    emptyscreen PROC
        ; SET CURSOR
        MOV AH, 2
        MOV DH, 14
        MOV DL, 30 
        INT 10H 
        

        ; SET CURSOR
        MOV AH, 2
        MOV DH, 15
        MOV DL, 30 
        INT 10H
        
                
        LEA DX, EMP   ; EMPTY LINE TO OVERWRITE ANOTHER LINE TO CLEAN THE SPACE
        MOV AH, 9
        INT 21H 
            
        ; SET CURSOR
        MOV AH, 2
        MOV DH, 15
        MOV DL, 30 
        INT 10H 
        

        ; SET CURSOR
        MOV AH, 2
        MOV DH, 16
        MOV DL, 30 
        INT 10H

        LEA DX, EMP   ; EMPTY LINE TO OVERWRITE ANOTHER LINE TO CLEAN THE SPACE
        MOV AH, 9
        INT 21H 

        ; SET CURSOR
        MOV AH, 2
        MOV DH, 16
        MOV DL, 30 
        INT 10H 
        

        ; SET CURSOR
        MOV AH, 2
        MOV DH, 17
        MOV DL, 30 
        INT 10H

        LEA DX, EMP   ; EMPTY LINE TO OVERWRITE ANOTHER LINE TO CLEAN THE SPACE
        MOV AH, 9
        INT 21H
            
        ; SET CURSOR
        MOV AH, 2
        MOV DH, 14
        MOV DL, 30 
        INT 10H 
        

        ; SET CURSOR
        MOV AH, 2
        MOV DH, 15
        MOV DL, 30 
        INT 10H
        ret
    emptyscreen ENDP

    player_move proc near
    xor bl, bl
    xor bh, bh
    mov invalid_bool, 00
    mov player_token_bool, 00

    call emptyscreen

    ; SET CURSOR
    MOV AH, 2
    MOV DH, 15
    MOV DL, 30 
    INT 10H

    lea dx, prompt
    mov ah, 09h
    int 21h

    mov ah, 0ah
    mov dx, offset playerInputF
    int 21h

    call newline

     ; SET CURSOR
        MOV AH, 2
        MOV DH, 16
        MOV DL, 48
        INT 10H
 
    lea dx, promptMoveTo
    mov ah, 09h
    int 21h

    mov ah, 0ah
    mov dx, offset playerInputT
    int 21h

    ; SET CURSOR
        MOV AH, 2
        MOV DH, 17
        MOV DL, 30 
        INT 10H

    mov bl, [playerInputF+2]
    mov bh, [playerInputF+3]
    
    call move_cond

    mov bl, [si]
    call is_empty
    call player_token_check

    mov bl, [playerInputF+2]
    mov bh, [playerInputF+3]
    mov playerInputF1, bl
    mov playerInputF2, bh 

    mov bl, [playerInputT+2]
    mov bh, [playerInputT+3]
    mov playerInputT1, bl
    mov playerInputT2, bh 

    call valid

    ; increment move count
    inc MOVES

    mov al, playerMoves
    inc al
    mov playerMoves, al

    .if is_empty_bool == 1 || valid_bool == 00 || player_token_bool == 00
        mov invalid_bool, 01
        mov dl, empty
        xchg [si], dl
    .elseif is_empty_bool == 0 && valid_bool == 01 && player_token_bool == 01
        mov dl, empty
        xchg [si], dl
    .endif

    mov bl, [playerInputT+2]
    mov bh, [playerInputT+3]

    call move_cond
    mov bl, [si]
    call is_empty
    .if is_empty_bool == 01 && valid_bool == 01 && player_token_bool == 01;if empty
        xchg dl, [si]
    .elseif is_empty_bool == 00 || valid_bool == 00 || player_token_bool == 00
        mov bl, [playerInputF+2]
        mov bh, [playerInputF+3]
        call move_cond
        xchg dl, [si]
        mov invalid_bool, 01
    .endif



    call invalid
    call winner
    
    
    ret 
    player_move endp

    ai_movement proc near 
    mov ai_token01, 0
    mov ai_token02, 0
    mov ai_token03, 0
    lea si, arrayBoard1
    add si, 1
    mov bl, [si]
    call ai_from
    .if ai_token == 01
        mov ai_token01, 01
    .endif
    add si, 6
    mov bl, [si]
    call ai_from
    .if ai_token == 01
        .if ai_token01 == 0
            mov ai_token01, 02
        .elseif ai_token01 > 0
            .if ai_token02 == 0
                mov ai_token02, 02
            .elseif ai_token02 > 0
                mov ai_token03, 02
            .endif
        .endif 
    .endif

    add si, 6
    mov bl, [si]
    call ai_from
    .if ai_token == 01
        .if ai_token01 == 0
            mov ai_token01, 03
        .elseif ai_token01 > 0
            .if ai_token02 == 0
                mov ai_token02, 03
            .elseif ai_token02 > 0
                mov ai_token03, 03
            .endif
        .endif 
    .endif
    lea si, arrayBoard2
    add si, 1
    mov bl, [si]
    call ai_from
    .if ai_token == 01
        .if ai_token01 == 0
            mov ai_token01, 04
        .elseif ai_token01 > 0
            .if ai_token02 == 0
                mov ai_token02, 04
            .elseif ai_token02 > 0
                mov ai_token03, 04
            .endif
        .endif 
    .endif
    add si, 6
    mov bl, [si]
    call ai_from
    .if ai_token == 01
        .if ai_token01 == 0
            mov ai_token01, 05
        .elseif ai_token01 > 0
            .if ai_token02 == 0
                mov ai_token02, 05
            .elseif ai_token02 > 0
                mov ai_token03, 05
            .endif
        .endif 
    .endif
    add si, 6
    mov bl, [si]
    call ai_from
    .if ai_token == 01
        .if ai_token01 == 0
            mov ai_token01, 06
        .elseif ai_token01 > 0
            .if ai_token02 == 0
                mov ai_token02, 06
            .elseif ai_token02 > 0
                mov ai_token03, 06
            .endif
        .endif 
    .endif

    lea si, arrayBoard3
    add si, 1
    mov bl, [si]
    call ai_from
    .if ai_token == 01
        .if ai_token01 == 0
            mov ai_token01, 07
        .elseif ai_token01 > 0
            .if ai_token02 == 0
                mov ai_token02, 07
            .elseif ai_token02 > 0
                mov ai_token03, 07
            .endif
        .endif 
    .endif
    add si, 6
    mov bl, [si]
    call ai_from
    .if ai_token == 01
        .if ai_token01 == 0
            mov ai_token01, 08
        .elseif ai_token01 > 0
            .if ai_token02 == 0
                mov ai_token02, 08
            .elseif ai_token02 > 0
                mov ai_token03, 08
            .endif
        .endif 
    .endif
    add si, 6
    mov bl, [si]
    call ai_from
    .if ai_token == 01
        .if ai_token01 == 0
            mov ai_token01, 09
        .elseif ai_token01 > 0
            .if ai_token02 == 0
                mov ai_token02, 09
            .elseif ai_token02 > 0
                mov ai_token03, 09
            .endif
        .endif 
    .endif

    ; SET CURSOR
        MOV AH, 2
        MOV DH, 15
        MOV DL, 30 
        INT 10H

    ret
    ai_movement endp

    empty_spots proc near
    mov empty_spot1, 0
    mov empty_spot2, 0
    mov empty_spot3, 0
    lea si, arrayBoard1
    add si, 1
    mov bl, [si]
    call is_empty
    .if is_empty_bool == 01
        .if empty_spot1 == 0
            mov empty_spot1, 01
        .elseif empty_spot1 > 0
            .if empty_spot2 == 0
                mov empty_spot2, 01
            .elseif empty_spot2 > 0
                mov empty_spot3, 01
            .endif
        .endif 
    .endif
    add si, 6
    mov bl, [si]
    call is_empty
    .if is_empty_bool == 01
        .if empty_spot1 == 0
            mov empty_spot1, 02
        .elseif empty_spot1 > 0
            .if empty_spot2 == 0
                mov empty_spot2, 02
            .elseif empty_spot2 > 0
                mov empty_spot3, 02
            .endif
        .endif 
    .endif

    add si, 6
    mov bl, [si]
    call is_empty
    .if is_empty_bool == 01
        .if empty_spot1 == 0
            mov empty_spot1, 03
        .elseif empty_spot1 > 0
            .if empty_spot2 == 0
                mov empty_spot2, 03
            .elseif empty_spot2 > 0
                mov empty_spot3, 03
            .endif
        .endif 
    .endif
    lea si, arrayBoard2
    add si, 1
    mov bl, [si]
    call is_empty
    .if is_empty_bool == 01
        .if empty_spot1 == 0
            mov empty_spot1, 04
        .elseif empty_spot1 > 0
            .if empty_spot2 == 0
                mov empty_spot2, 04
            .elseif empty_spot2 > 0
                mov empty_spot3, 04
            .endif
        .endif 
    .endif
    add si, 6
    mov bl, [si]
    call is_empty
    .if is_empty_bool == 01
        .if empty_spot1 == 0
            mov empty_spot1, 05
        .elseif empty_spot1 > 0
            .if empty_spot2 == 0
                mov empty_spot2, 05
            .elseif empty_spot2 > 0
                mov empty_spot3, 05
            .endif
        .endif 
    .endif
    add si, 6
    mov bl, [si]
    call is_empty
    .if is_empty_bool == 01
        .if empty_spot1 == 0
            mov empty_spot1, 06
        .elseif empty_spot1 > 0
            .if empty_spot2 == 0
                mov empty_spot2, 06
            .elseif empty_spot2 > 0
                mov empty_spot3, 06
            .endif
        .endif 
    .endif

    lea si, arrayBoard3
    add si, 1
    mov bl, [si]
    call ai_from
    call is_empty
    .if is_empty_bool == 01
        .if empty_spot1 == 0
            mov empty_spot1, 07
        .elseif empty_spot1 > 0
            .if empty_spot2 == 0
                mov empty_spot2, 07
            .elseif empty_spot2 > 0
                mov empty_spot3, 07
            .endif
        .endif 
    .endif
    add si, 6
    mov bl, [si]
    call is_empty
    .if is_empty_bool == 01
        .if empty_spot1 == 0
            mov empty_spot1, 08
        .elseif empty_spot1 > 0
            .if empty_spot2 == 0
                mov empty_spot2, 08
            .elseif empty_spot2 > 0
                mov empty_spot3, 08
            .endif
        .endif 
    .endif
    add si, 6
    mov bl, [si]
    call is_empty
    .if is_empty_bool == 01
        .if empty_spot1 == 0
            mov empty_spot1, 09
        .elseif empty_spot1 > 0
            .if empty_spot2 == 0
                mov empty_spot2, 09
            .elseif empty_spot2 > 0
                mov empty_spot3, 09
            .endif
        .endif 
    .endif
    ret
    empty_spots endp

    genRandomNum proc near
    call delay
    call delay
    call delay
    mov ah, 0
    int 1ah

    mov ax, dx
    mov dx, 0
    mov bx, 3
    div bx
    mov randomNum, dl
    ret
    genRandomNum endp

    delay proc near
        xor cx, cx
        mov cx, 1
    startDelay:
        cmp cx, 30000
        JE endDelay
        inc cx
        JMP startDelay
    endDelay:
        ret
    delay endp

    ai_move_condfrom proc near
    .if bl == 01
        mov ai_token_from1, 'a'
        mov ai_token_from2, '1'
    .elseif bl == 02
        mov ai_token_from1, 'b'
        mov ai_token_from2, '1'
    .elseif bl == 03
        mov ai_token_from1, 'c'
        mov ai_token_from2, '1'
    .elseif bl == 04
        mov ai_token_from1, 'a'
        mov ai_token_from2, '2'
    .elseif bl == 05
        mov ai_token_from1, 'b'
        mov ai_token_from2, '2'
    .elseif bl == 06
        mov ai_token_from1, 'c'
        mov ai_token_from2, '2'
    .elseif bl == 07
        mov ai_token_from1, 'a'
        mov ai_token_from2, '3'
    .elseif bl == 08
        mov ai_token_from1, 'b'
        mov ai_token_from2, '3'
    .elseif bl == 09
        mov ai_token_from1, 'c'
        mov ai_token_from2, '3'
    .else   
        mov invalid_bool, 01
    .endif
    ret
    ai_move_condfrom endp

    ai_move_condto proc near
    .if bh == 01
        mov ai_token_to1, 'a'
        mov ai_token_to2, '1'
    .elseif bh == 02
        mov ai_token_to1, 'b'
        mov ai_token_to2, '1'
    .elseif bh == 03
        mov ai_token_to1, 'c'
        mov ai_token_to2, '1'
    .elseif bh == 04
        mov ai_token_to1, 'a'
        mov ai_token_to2, '2'
    .elseif bh == 05
        mov ai_token_to1, 'b'
        mov ai_token_to2, '2'
    .elseif bh == 06
        mov ai_token_to1, 'c'
        mov ai_token_to2, '2'
    .elseif bh == 07
        mov ai_token_to1, 'a'
        mov ai_token_to2, '3'
    .elseif bh == 08
        mov ai_token_to1, 'b'
        mov ai_token_to2, '3'
    .elseif bh == 09
        mov ai_token_to1, 'c'
        mov ai_token_to2, '3'
    .else   
        mov invalid_bool, 01
    .endif
    ret
    ai_move_condto endp

    ai_move proc near
    xor bl, bl
    xor bh, bh
    mov invalid_bool_ai, 00

    call ai_movement
    call genRandomNum

    .if randomNum == 0
        mov bl, ai_token01
        call ai_move_condfrom
        call empty_spots
        call genRandomNum
        .if randomNum == 0
            mov bh, empty_spot1
            call ai_move_condto
        .elseif randomNum == 1
            mov bh, empty_spot2
            call ai_move_condto
        .elseif randomNum == 2
            mov bh, empty_spot3
            call ai_move_condto
        .endif
        
    .elseif randomNum == 1
        mov bl, ai_token02
        call ai_move_condfrom
        call empty_spots
        call genRandomNum
        .if randomNum == 0
            mov bh, empty_spot1
            call ai_move_condto
        .elseif randomNum == 1
            mov bh, empty_spot2
            call ai_move_condto
        .elseif randomNum == 2
            mov bh, empty_spot3
            call ai_move_condto
        .endif

    .elseif randomNum == 2
        mov bl, ai_token03
        call ai_move_condfrom
        call empty_spots
        call genRandomNum
        .if randomNum == 0
            mov bh, empty_spot1
            call ai_move_condto
        .elseif randomNum == 1
            mov bh, empty_spot2
            call ai_move_condto
        .elseif randomNum == 2
            mov bh, empty_spot3
            call ai_move_condto
        .endif

    .endif

    mov bl, ai_token_from1
    mov bh, ai_token_from2
    
    call ai_move_cond

    mov bl, ai_token_from1
    mov bh, ai_token_from2
    mov playerInputF1, bl
    mov playerInputF2, bh 

    mov bl, ai_token_to1
    mov bh, ai_token_to2
    mov playerInputT1, bl
    mov playerInputT2, bh 

    call valid_ai

    .if valid_bool_ai == 01
        mov dl, empty
        xchg [si], dl
        mov bl, ai_token_to1
        mov bh, ai_token_to2

        call ai_move_cond
        xchg dl, [si]
    .elseif valid_bool_ai == 00
        mov invalid_bool_ai, 01
    .endif

    call invalid_ai
    call winner_ai

    ret
    ai_move endp

    winner proc near
    lea si, arrayBoard1
    add si, 1
    mov bl, [si]
    mov place01, bl
    add si, 6
    mov bl, [si]
    mov place02, bl
    add si, 6
    mov bl, [si]
    mov place03, bl

    lea si, arrayBoard2
    add si, 1
    mov bl, [si]
    mov place04, bl
    add si, 6
    mov bl, [si]
    mov place05, bl
    add si, 6
    mov bl, [si]
    mov place06, bl

    lea si, arrayBoard3
    add si, 1
    mov bl, [si]
    mov place07, bl
    add si, 6
    mov bl, [si]
    mov place08, bl
    add si, 6
    mov bl, [si]
    mov place09, bl

    .if place01 == 'O' && place02 == 'O' && place03 == 'O'
        mov win, 1
    .elseif place04 == 'O' && place05 == 'O' && place06 == 'O'
        mov win, 1
    .elseif place01 == 'O' && place04 == 'O' && place07 == 'O'
        mov win, 1
    .elseif place02 == 'O' && place05 == 'O' && place08 == 'O'
        mov win, 1
    .elseif place03 == 'O' && place06 == 'O' && place09 == 'O'
        mov win, 1
    .elseif place01 == 'O' && place05 == 'O' && place09 == 'O'
        mov win, 1
    .elseif place07 == 'O' && place05 == 'O' && place03 == 'O'
        mov win, 1
    .endif
    ret
    winner endp
    
    winner_ai proc near
    lea si, arrayBoard1
    add si, 1
    mov bl, [si]
    mov place01, bl
    add si, 6
    mov bl, [si]
    mov place02, bl
    add si, 6
    mov bl, [si]
    mov place03, bl

    lea si, arrayBoard2
    add si, 1
    mov bl, [si]
    mov place04, bl
    add si, 6
    mov bl, [si]
    mov place05, bl
    add si, 6
    mov bl, [si]
    mov place06, bl

    lea si, arrayBoard3
    add si, 1
    mov bl, [si]
    mov place07, bl
    add si, 6
    mov bl, [si]
    mov place08, bl
    add si, 6
    mov bl, [si]
    mov place09, bl

    .if place04 == 'X' && place05 == 'X' && place06 == 'X'
        mov win_ai, 1
    .elseif place07 == 'X' && place08 == 'X' && place09 == 'X'
        mov win_ai, 1
    .elseif place01 == 'X' && place04 == 'X' && place07 == 'X'
        mov win_ai, 1
    .elseif place02 == 'X' && place05 == 'X' && place08 == 'X'
        mov win_ai, 1
    .elseif place03 == 'X' && place06 == 'X' && place09 == 'X'
        mov win_ai, 1
    .elseif place01 == 'X' && place05 == 'X' && place09 == 'X'
        mov win_ai, 1
    .elseif place07 == 'X' && place05 == 'X' && place03 == 'X'
        mov win_ai, 1
    .endif
    ret
    winner_ai endp



    ; --------- DISPLAY THE TITLE SCREEN ---------    
    titlescreen proc
    
        ; CLEAR SCREEN
                    
            MOV AX,0600H 
            MOV BH,07H 
            MOV CX,0000H 
            MOV DX,184FH 
            INT 10H 

            ; SET CURSOR
            MOV AH, 2
            MOV BH, 0
            MOV DH, 6
            MOV DL, 14
            INT 10H 
            

            ; SET CURSOR
            MOV AH, 2
            MOV DH, 7
            MOV DL, 14
            INT 10H 
            
           
               
            ; SET CURSOR 
            MOV AH, 2
            MOV DH, 8
            MOV DL, 14
            INT 10H 
        
                

            ; SET CURSOR 
            MOV AH, 2
            MOV DH, 9
            MOV DL, 14
            INT 10H  
              

            ; SET CURSOR 
            MOV AH, 2
            MOV DH, 10
            MOV DL, 14
            INT 10H 

            
        
        ; LOGO DISPLAY END -----------------
        
            ; SET CURSOR
            MOV AH, 2
            MOV DH, 11
            MOV DL, 22
            INT 10H 
            
        
        LEA DX, promptStart  ; DEVELOPER NAME DISPLAY
        MOV AH, 9
        INT 21H
        
            ; SET CURSOR
            MOV AH, 2
            MOV DH, 13
            MOV DL, 24
            INT 10H  
         
        
        LEA DX, pak  ; PRESS ANY KEY
        MOV AH, 9
        INT 21H
        
        MOV AH, 7    ; INPUT WITHOUT ECHO
        INT 21H
        
            ; CLEAR SCREEN
                    
            MOV AX,0600H 
            MOV BH,07H 
            MOV CX,0000H 
            MOV DX,184FH 
            INT 10H 
            ret
    titlescreen endp

    ; ----------- DISPLAY GAME RULES --------------
                                               
                                               
    ;description
    rules PROC
        ; SET CURSOR
            MOV AH, 2
            MOV BH, 0
            MOV DH, 6
            MOV DL, 7
            INT 10H
        
        LEA DX, R
        MOV AH, 9
        INT 21H
        

            ; SET CURSOR
            MOV AH, 2
            MOV DH, 7
            MOV DL, 7
            INT 10H 
        
        
        LEA DX, R1   ; RULE 1
        MOV AH, 9
        INT 21H 
        

            ; SET CURSOR 
            MOV AH, 2
            MOV DH, 8
            MOV DL, 7
            INT 10H 
        
        LEA DX, R2   ; RULE 2
        MOV AH, 9
        INT 21H
        

            ; SET CURSOR 
            MOV AH, 2
            MOV DH, 9
            MOV DL, 7
            INT 10H 
        
        
        LEA DX, R3   ; RULE 3
        MOV AH, 9
        INT 21H
        

            ; SET CURSOR
            MOV AH, 2
            MOV DH, 10
            MOV DL, 7
            INT 10H
        
        
        LEA DX, R4   ; RULE 4
        MOV AH, 9
        INT 21H
        
  
            ; SET CURSOR 
            MOV AH, 2
            MOV DH, 11
            MOV DL, 7
            INT 10H      
            
        
        LEA DX, R5  ; RULE 5
        MOV AH, 9
        INT 21H
        
            
            ; SET CURSOR
            MOV AH, 2
            MOV DH, 12
            MOV DL, 7
            INT 10H
            
            
        LEA DX, R6
        MOV AH, 9
        INT 21H
           
           ; SET CURSOR
            MOV AH, 2
            MOV DH, 13
            MOV DL, 7
            INT 10H
             
       LEA DX, R7
       MOV AH, 9
       INT 21H
            
            ; SET CURSOR
            MOV AH, 2
            MOV DH, 17
            MOV DL, 7
            INT 10H     
        
        LEA DX, pak ; PRESS ANY KEY
        MOV AH, 9
        INT 21H
        
        MOV AH, 7   ; INPUT WITHOUT ECHO
        INT 21H 
        ret

    rules ENDP
     ; ---------- DISPLAY GAME RULES END ---------

    ;description
    victory PROC
        ; CLEAR SCREEN            
        MOV AX,0600H 
        MOV BH,07H 
        MOV CX,0000H 
        MOV DX,184FH 
        INT 10H 

        call print_board

        call emptyscreen

        ; SET CURSOR
        MOV AH, 2
        MOV DH, 15
        MOV DL, 30 
        INT 10H

        lea dx, promptPlayerWins
        mov ah, 09h
        int 21h

       call newline
       ; SET CURSOR
        MOV AH, 2
        MOV DH, 16
        MOV DL, 30 
        INT 10H

        mov ah, 09h
        mov dx, offset moveCountMsg
        int 21h

        mov dl, playerMoves
        add dl, 30h
        mov ah, 02h
        int 21h

        ret
    victory ENDP

    victory_ai PROC
        ; CLEAR SCREEN            
        MOV AX,0600H 
        MOV BH,07H 
        MOV CX,0000H 
        MOV DX,184FH 
        INT 10H  

        call print_board

        call emptyscreen

        ; SET CURSOR
        MOV AH, 2
        MOV DH, 15
        MOV DL, 30 
        INT 10H

        lea dx, promptAiWins
        mov ah, 09h
        int 21h

       call newline

        mov ah, 09h
        mov dx, offset moveCountMsg
        int 21h

        mov dl, playerMoves
        add dl, 30h
        mov ah, 02h
        int 21h

        ret
    victory_ai ENDP
    
    main proc near

    ; Initializing data
    mov ax, @data
    mov ds, ax
    mov bh, 00

    call titlescreen
    call rules
    call print_board
    
    .while bh < 01 && bl < 01
        call player_move
        call print_key
        call print_board
        mov bh, win
        
        .if win == 1
            call print_board
            call victory
            call print_key
            jmp TRYAGAIN
        .endif


        call ai_move

        inc AIMOVES
        
        call print_board
        call computermove
        call print_key
        mov bh, win
        mov bl, win_ai

        .if win_ai == 1
            call print_board
            call victory_ai
            call print_key
            jmp TRYAGAIN
        .endif

        call newline
    .endw

; ----------- TRY AGAIN -----------

    TRYAGAIN:
            ; CLEAR SCREEN
                        
            MOV AX,0600H 
            MOV BH,07H 
            MOV CX,0000H 
            MOV DX,184FH 
            INT 10H  
            
            ; SET CURSOR
            MOV AH, 2
            MOV BH, 0
            MOV DH, 10
            MOV DL, 24
            INT 10H
        
        
    
        LEA DX, TRA   ; TRY AGAIN PROMPT
        MOV AH, 9 
        INT 21H
        
        MOV AH, 1     
        INT 21H
        
        CMP AL, 121  ; CHECK IF INPUT IS 'y'
        call main 
        
        CMP AL, 89   ; CHECK IF INPUT IS 'Y'
        call main 
        
        ; IF INPUT IS 'Y'/'y' THEN REPEAT THE GAME
        
        CMP AL, 110  ; CHECK IF INPUT IS 'n'
        JZ exit
        CMP AL, 78   ; CHECK IF INPUT IS 'N'
        JZ exit  
        
        ; IF INPUT IS 'N'/'n' THEN EXIT THE GAME
        
        
        ; IF INPUT IS INVALID
        
            ; SET CURSOR
            MOV AH, 2
            MOV BH, 0
            MOV DH, 10
            MOV DL, 24
            INT 10H
        
        LEA DX, WI  ; WRONG INPUT MESSAGE
        MOV AH, 9
        INT 21H 
        
        MOV AH, 7 ; INPUT WITHOUT ECHO
        INT 21H
            
            ; SET CURSOR
            MOV AH, 2
            MOV BH, 0
            MOV DH, 10
            MOV DL, 24
            INT 10H
        
        LEA DX, EMP  ; EMPTY LINE TO OVERWRITE ANOTHER LINE TO CLEAN THE SPACE
        MOV AH, 9
        INT 21H
        
        
        
        JMP TRYAGAIN ; PROMPT THE TRY AGAIN     


; ----------- END OF INPUT -------- 
    exit:
    mov ax, 4c00h
    int 21h

    main endp
end main