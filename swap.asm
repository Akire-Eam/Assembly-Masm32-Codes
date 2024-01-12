.model small
.stack 100h
.data
    message_one db 13, 10, "Enter first character (x): ", "$"
    message_two db 13, 10, "Enter second character (y): ", "$"
    output_one db 13, 10, "The new value of x is ", "$"
    output_two db 13, 10, "The new value of y is ", "$"
    period db ".", "$"
    newline db 13, 10, "$"
    char db ?

.code
    main proc near

    ; Initializing data
    mov ax, @data
    mov ds, ax

    ; Displaying Input message 1
    lea dx, message_one
    mov ah, 09h
    int 21h

    ; Gets user input
    mov ah, 01h
    int 21h

    mov bh, al

    ; Displaying Input message 2
    lea dx, message_two
    mov ah, 09h
    int 21h

    ; Gets user input
    mov ah, 01h
    int 21h

    mov ch, al

    xchg bh, ch

    ;Print newline
    lea dx, newline
    mov ah, 09h
    int 21h

    ; Displaying Output message 1
    lea dx, output_one
    mov ah, 09h
    int 21h

    mov ah, 02h
    mov dl, bh
    int 21h

    mov ah, 09h
    lea dx, period
    int 21h

    ; Displaying Output message 2
    lea dx, output_two
    mov ah, 09h
    int 21h

    mov ah, 02h
    mov dl, ch
    int 21h

    mov ah, 09h
    lea dx, period
    int 21h

    ; Returning to ms-dos
    mov ax, 4c00h
    int 21h

    main endp
end main