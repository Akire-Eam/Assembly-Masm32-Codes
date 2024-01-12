.model small
.stack 100h
.data
    message db 13, 10, "Enter number: ", "$"
    newline db 13, 10, "$"
    input db ?

.code
    print_space proc near
    mov dl, 32
    mov ah, 02h
    int 21h
    ret
    print_space endp
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

    sub al, 48

    xor cx, cx
    mov cl, al

    ; Prints new line
    lea dx, newline
    mov ah, 09h
    int 21h

    @display_x:
        mov ah, 02h
        mov dl, 'X'
        int 21h
        call print_space
        loop @display_x


    ; Returning to ms-dos
    mov ax, 4c00h
    int 21h

    main endp
 end main

