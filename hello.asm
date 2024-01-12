.model small
.stack 100h
.data
    message db 13, 10, "Hello world", "$"
.code
    main proc near

    ; Initializing data
    mov ax, @data
    mov ds, ax

    ; Display message
    mov dx, offset message
    mov ah, 09h
    int 21h

    ; Returning to ms-dos
    mov ax, 4c00h
    int 21h
    
    main endp
 end main

