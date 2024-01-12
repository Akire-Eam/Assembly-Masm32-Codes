.model small
.data
    first_message db 13, 10, "Enter first number: ", "$"
    second_message db 13, 10, "Enter second number: ", "$"
    newline db 13, 10, "$"
    first_ones db ?
    second_ones db ?
    first_tens db ?
    second_tens db ?
    sum_output db 13, 10, "The sum of ", "$"
    diff_output db "The difference of ", "$"
    and_output db " and ", "$"
    is_output db " is ", "$"
    period_output db ".", "$"

.stack 100h
.code
    main proc near

    ; Initializing data
    mov ax, @data
    mov ds, ax

    ; Display first message
    lea dx, first_message
    mov ah, 09h
    int 21h

    ; Gets user input
    mov ah, 01h
    int 21h

    sub al, 48

    ; Copy user input to input variable
    mov first_tens, al
    mov bh, al

    ; Gets user input
    mov ah, 01h
    int 21h

    sub al, 48

    ; Copy user input to input variable
    mov first_ones, al
    mov bl, al

    ; bh:bl

    ; Display second message
    lea dx, second_message
    mov ah, 09h
    int 21h

    ; Gets user input
    mov ah, 01h
    int 21h

    sub al, 48

    ; Copy user input to input variable
    mov second_tens, al
    mov ch, al

    ; Gets user input
    mov ah, 01h
    int 21h

    sub al, 48

    ; Copy user input to input variable
    mov second_ones, al
    mov cl, al

    ; ch:cl

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
    mov dl, first_tens
    add dl, 48
    int 21h

    mov ah, 02h
    mov dl, first_ones
    add dl, 48
    int 21h

    lea dx, and_output
    mov ah, 09h
    int 21h

    mov ah, 02h
    mov dl, second_tens
    add dl, 48
    int 21h

    mov ah, 02h
    mov dl, second_ones
    add dl, 48
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

    ; Prints new line
    lea dx, newline
    mov ah, 09h
    int 21h

    ; Prints difference output
    lea dx, diff_output
    mov ah, 09h
    int 21h

    mov ah, 02h
    mov dl, first_tens
    add dl, 48
    int 21h

    mov ah, 02h
    mov dl, first_ones
    add dl, 48
    int 21h

    lea dx, and_output
    mov ah, 09h
    int 21h

    mov ah, 02h
    mov dl, second_tens
    add dl, 48
    int 21h

    mov ah, 02h
    mov dl, second_ones
    add dl, 48
    int 21h

    lea dx, is_output
    mov ah, 09h
    int 21h

    ; Perform subtraction
    mov bl, first_ones
    sub bl, second_ones

    mov al, bl
    mov ah, 0
    aas

    mov second_ones, al
    mov bl, ah 

    add first_tens, bl
    mov bl, first_tens
    sub bl, second_tens

    mov al, bl 
    mov ah, 0
    aas

    mov first_tens, ah 
    mov first_ones, al

    mov ah, 02h
    mov dl, first_tens
    add dl, 48
    int 21h

    mov ah, 02h
    mov dl, first_ones
    add dl, 48
    int 21h

    mov ah, 02h
    mov dl, second_ones
    add dl, 48
    int 21h

    lea dx, period_output
    mov ah, 09h
    int 21h
    
    ; Returning to ms-dos
    mov ax, 4c00h
    int 21h
    
    main endp
 end main

