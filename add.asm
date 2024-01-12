.model small
.stack 100h
.data
    message db 13, 10, "Input number 1: ", "$"
    message2 db 13, 10, "Input number 2: ", "$"
    newline db 13, 10, "$"
    input db ?
    input2 db ?

.code
    main proc near

    ; Initializing data
    mov ax, @data
    mov ds, ax

    ; Display message
    mov dx, offset message
    mov ah, 09h
    int 21h

    ; Gets user input
    mov ah, 01h
    int 21h

    ; Copy user input to input variable
    mov input, al

    mov ah, input

    ; Display message
    mov dx, offset message2
    mov ah, 09h
    int 21h

    ; Gets user input
    mov ah, 01h
    int 21h

    ; Copy user input to input variable
    mov input2, al

    ; Prints new line
    lea dx, newline
    mov ah, 09h
    int 21h

    sub input, 48
    sub input2, 48

    mov bh, input2
    add input, bh
    add input, 48

    ; Display output
    mov ah, 02h
    mov dl, input
    int 21h

    ; Returning to ms-dos
    mov ax, 4c00h
    int 21h
    
    main endp
 end main

