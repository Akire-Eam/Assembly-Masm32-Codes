.model small
.stack 100h
.data 
    array db "1", "2", "3", "4", "5", "$"
    len dw 5

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

    lea si, array
    xor cx, cx
    mov cx, len

    @display_array:
    mov dl, [si]
    mov ah, 02h 
    int 21h

    call print_space

    inc si
    loop @display_array

    mov ax, 4c00h
    int 21h

    main endp
 end main

