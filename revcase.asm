.model small
.data
    input_msg db 13, 10, "Enter string: ", "$"
    input db 11, ?, 26 dup("$")
    output_msg db 13, 10, "Transformed string: ", "$"
    len db ?

.stack 100h
.code
    main proc near

    ; Initializing data
    mov ax, @data
    mov ds, ax

    ; Display input message
    lea dx, input_msg
    mov ah, 09h
    int 21h

    ; Get user input
    mov ah, 0ah
    lea dx, input
    int 21h

    ; Display output message
    lea dx, output_msg
    mov ah, 09h
    int 21h

    mov si, offset[input + 2]
    xor cx, cx
    add cx, 01

    @display_arr:
    mov dl, [si]
    inc cx

    .if dl == '$' ; to check if null terminator
        je @end
    .elseif dl <= 90 ; uppercase
        .if dl >= 65
            add dl, 32
        .endif
    .elseif dl >= 97 ; lowercase
        .if dl <= 122
            sub dl, 32
        .endif
    .else
        add dl, 00
    .endif

    mov ah, 02h
    int 21h

    inc si
    loop @display_arr

    @end:
    mov ax, 4c00h
    int 21h

    main endp
end main