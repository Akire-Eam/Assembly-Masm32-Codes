.model small
.data
    prompt_message db 13, 10, "Enter name: ", "$"
    newline db 13, 10, "$"
    ; kukuha ng string from the user
    ; 26 - buffer size, depends on the user
    ; after 26 is a blank data (?) - actual string size - string length
    ; all 26 becomes a "$" - actual
    ; ($, $, $, $, $,...) to (T, i, m, $, $,...)
    inputted_string db 26, ?, 26 dup("$") 
    message db 13, 10, "Enter age: ", "$"
    output db 13, 10, "Hello ", "$"
    output2 db "You are ", "$"
    output3 db " years old ", "$"
    input db ?
    input2 db ?

.stack 100h
.code
    main proc near

    ; Initializing data
    mov ax, @data
    mov ds, ax

    ; Display message
    lea dx, prompt_message
    mov ah, 09h
    int 21h

    ; Stores input of user to inputted_string
    mov ah, 0ah
    lea dx, inputted_string
    int 21h


    ; Display message
    mov dx, offset message
    mov ah, 09h
    int 21h

    ; Gets user input
    mov ah, 01h
    int 21h

    ; Copy user input to input variable
    mov input, al

    ; Gets user input
    mov ah, 01h
    int 21h

    ; Copy user input to input variable
    mov input2, al

    ; Prints new line
    lea dx, newline
    mov ah, 09h
    int 21h

    mov ah, 09h
    lea dx, output
    int 21h

    mov ah, 09h
    lea dx, [inputted_string + 2]
    int 21h

    ; Prints new line
    lea dx, newline
    mov ah, 09h
    int 21h

    mov ah, 09h
    lea dx, output2
    int 21h

    ; Display output
    mov ah, 02h
    mov dl, input
    int 21h

    ; Display output
    mov ah, 02h
    mov dl, input2
    int 21h

    mov ah, 09h
    lea dx, output3
    int 21h

    ; Returning to ms-dos
    ; best way
    mov ax, 4c00h
    int 21h

    ; Alternative
    ;mov ah, 4ch 
    ;mov al, 00h
    ;int 21h

    ; Alternative
    ;mov ah, 4ch
    ;int 21h
    
    main endp
 end main

