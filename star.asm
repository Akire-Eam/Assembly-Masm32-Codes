.model small
.data
    prompt db 13, 10, "Enter number of rows: ", "$"
    newline db 13, 10 , "$"
    digit1 db ?
    digit2 dw ?
    var db ?
    row db ?

.stack 100h
.code
    main proc near

    ; Initializing data
    mov ax, @data
    mov ds, ax

    ; Dislay prompt
    mov ah, 09h
    lea dx, prompt
    int 21h

    ; Gets user input
    mov ah, 01h
    int 21h

    ; Copy user input to input variable
    mov digit1, al

    ; Gets user input
    mov ah, 01h
    int 21h

    ; Copy user input to input variable
    xor ah, ah
    mov digit2, ax
    mov ah, 09h

    mov ah, 09h
    lea dx, newline
    int 21h

    ; sub 048 from digits
    sub digit2, 048
    sub digit1, 048

    mov al, digit1
    mov bl, 10
    mul bl

    ; add ones and tens digit
    add ax, digit2
    mov bl, 1d
    div bl

    xor cx, cx
    mov cl, al

    mov bh, 01
    mov var, 01   

    .while bh <= cl
        .while var <= bh
            mov ah, 02h
            mov dl, '*'
            int 21h
            inc var
        .endw
        mov ah, 09h
        lea dx, newline
        int 21h
        inc bh
        mov var, 01
    .endw       
    
    ; Returning to ms-dos
    mov ax, 4c00h
    int 21h

    main endp
end main