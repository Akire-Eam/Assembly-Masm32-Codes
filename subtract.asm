.model small
.stack 100h
.data
    message db 13, 10, "Input number: ", "$"
    newline db 13, 10, "$"
    input db ?

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

    ; Prints new line
    lea dx, newline
    mov ah, 09h
    int 21h

    sub input, 01

    ; Display output
    mov ah, 02h
    mov dl, input
    int 21h

    ; Returning to ms-dos
    mov ax, 4c00h
    int 21h
    
    main endp
 end main

