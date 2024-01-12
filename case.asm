.model small
.stack 100h
.data
    message db 13, 10, "Enter character: ", "$"
    newline db 13, 10, "$"
    input db ?
    uppercase_message db 13, 10, "Upper case! ", "$"
    lowercase_message db 13, 10, "Lower case! ", "$"

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

    mov input, al

    ; Prints new line
    lea dx, newline
    mov ah, 09h
    int 21h

    cmp input, 90
    jle @display_uppercase
    jg @display_lowercase 

    @display_uppercase:
    mov ah, 09h
    lea dx, uppercase_message
    int 21h
    jmp @end_condition

    @display_lowercase:
    mov ah, 09h
    lea dx, lowercase_message
    int 21h

    ; Returning to ms-dos
    @end_condition:
    mov ax, 4c00h
    int 21h

    main endp
 end main

