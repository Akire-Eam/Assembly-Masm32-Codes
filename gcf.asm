; find gcf of two integers(fixed three-digit) by implementing euclid's algo
.model small
.stack 100h

.data
    prompt1 db 13, 10, "Enter first number: ", "$"   
    prompt2 db 13, 10, "Enter second number: ", "$"   
    promptgcf db "The greatest common factor of ", "$"
    promptand db " and ", "$"
    promptis db " is ", "$"
    num1 dw ?
    one_digit1 db ?
    one_digit2 db ?
    one_digit3 dw ?
    num2 dw ?
    two_digit1 db ?
    two_digit2 db ?
    two_digit3 dw ?
    remainder dw ?
    placeholder dw ?
    newline db 13, 10, "$"

.code

    print_num proc near

    mov bx, 10          
    xor cx, cx          
    
    @first_num: 
    xor dx, dx          
    div bx              
    push dx             
    inc cx              
    test ax, ax         
    jne @first_num          
    
    @second_num: 
    pop dx              
    
    mov ah, 02h        
    add dl, "0"
    int 21h             
    loop @second_num

    ret
    print_num endp

    print_prompts proc near
    .if num1 == 0
        call print_zero
        call print_zero
        call print_zero
    .elseif num1 < 10
        call print_zero
    .elseif num1 < 100
        call print_zero
        call print_zero
    .endif
    mov ax, num1
    
    call print_num

    mov ah, 09h
    lea dx, promptand
    int 21h

    .if num2 == 0
        call print_zero
        call print_zero
        call print_zero
    .elseif num2 < 10
        call print_zero
    .elseif num2 < 100
        call print_zero
        call print_zero
    .endif

    mov ax, num2
    call print_num

    mov ah, 09h
    lea dx, promptis
    int 21h

    ret
    print_prompts endp

    period proc near
    mov ah, 02h
    mov dl, '.'
    int 21h
    ret
    period endp

    euclids_algo proc near
    xor bx, bx
    mov bx, num1
    .if bx < num2
        mov placeholder, bx     
        mov bx, num2      
        mov num1, bx      
        mov bx, placeholder     
        mov num2, bx      
    .endif

    .if num2 == 00
        mov ax, num1
        call print_num
    .else
        xor ax, ax
        mov ax, num1
        mov bx, 01
        mul bx

        xor bx, bx
        add bx, num2
        div bx
        mov remainder, dx

        .if remainder == 0
            mov ax, num2
            call print_num
        .else
            mov bx, num2
            mov num1, bx
            mov bx, remainder
            mov num2, bx
            call euclids_algo
        .endif
    .endif

    ret
    euclids_algo endp

    print_zero proc near
    mov ah, 02h
    mov dl, '0'
    int 21h
    ret
    print_zero endp

    main proc near
    ; Initialize data
    mov ax, @data
    mov ds, ax

    ; Display prompt message
    lea dx, prompt1
    mov ah, 09h
    int 21h

    ; Get user input
    mov ah, 01h
    int 21h
    mov one_digit1, al

    mov ah, 01h
    int 21h
    mov one_digit2, al

    mov ah, 01h
    int 21h
    xor ah, ah
    mov one_digit3, ax
    mov ah, 09h

    lea dx, prompt2
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
    mov two_digit1, al

    mov ah, 01h
    int 21h
    mov two_digit2, al

    mov ah, 01h
    int 21h
    xor ah, ah
    mov two_digit3, ax
    mov ah, 09h

    ; sub 048 from digits
    sub one_digit2, 048
    sub one_digit1, 048
    sub one_digit3, 048
    sub two_digit1, 048
    sub two_digit2, 048
    sub two_digit3, 048

    ; total of first number
    xor al, al
    mov al, one_digit1
    mov bl, 100
    mul bl
    mov num1, ax 

    mov al, one_digit2
    mov bl, 10
    mul bl
    add num1, ax
    mov bx, one_digit3
    add num1, bx

    ; total of second number
    mov al, two_digit1
    mov bl, 100
    mul bl
    mov num2, ax

    mov al, two_digit2
    mov bl, 10
    mul bl
    add num2, ax
    mov bx, two_digit3
    add num2, bx

    mov ah, 09h
    lea dx, newline
    int 21h

    ; division 
    mov ah, 09h
    lea dx, promptgcf
    int 21h

    call print_prompts
    call euclids_algo
    call period

    ; Returning to ms-dos
    mov ax, 4c00h
    int 21h

    main endp
end main