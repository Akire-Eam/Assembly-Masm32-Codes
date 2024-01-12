; Kristine Jewel B. Malimban

.model small
.stack 100h
.data
    input_age db 13, 10, "Enter age: ", "$"
    minor_m db 13, 10, "Minor !", "$"
    adult_m db 13, 10, "Adult !", "$"
    senior_m db 13, 10, "Senior !", "$"
    total_age dw ?
    num1_digit1 db ?
    num1_digit2 dw ?

.code
    main proc near

    ; Initializing data
    mov ax, @data
    mov ds, ax

    ; Displaying Input message
    lea dx, input_age
    mov ah, 09h
    int 21h

    ; Gets user input
    mov ah, 01h
    int 21h

    ; Copy user input to input variable
    mov num1_digit1, al

    ; Gets user input
    mov ah, 01h
    int 21h

    ; Copy user input to input variable
    xor ah, ah
    mov num1_digit2, ax
    mov ah, 09h

    ; sub 048 from digits
    sub num1_digit2, 048
    sub num1_digit1, 048

    mov al, num1_digit1
    mov bl, 10
    mul bl

    mov total_age, ax
    mov bx, num1_digit2
    add total_age, bx

    cmp total_age, 17
    jle @minor_i

    cmp total_age, 59
    jle @adult_i

    cmp total_age, 60
    jge @senior_i

    add total_age, 048

    @minor_i:
    mov ah, 09h
    lea dx, minor_m
    int 21h
    jmp @end_condition

    @adult_i:
    mov ah, 02h
    lea dx, total_age
    int 21h
    jmp @end_condition

    @senior_i:
    mov ah, 09h
    lea dx, senior_m
    int 21h

    @end_condition:
    ; Returning to ms-dos
    mov ax, 4c00h
    int 21h

    main endp
end main