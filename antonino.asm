.model small
.stack 100h
.data
    message db 13, 10, "Enter 3 digit integer (001-399): ", "$"
    error db 13, 10, "Invalid: Enter numbers between 001 and 399 only! ", "$"
    newline db 13, 10, "$"
    hundreds db 0
	tens db 0
	ones db 0
    ones1 dw ?
    num dw ? 
	hundredsvalue db 0
	tensvalue db 0
	onesvalue db 0

.code

    main proc near

        ; Initializing data
        mov ax, @data
        mov ds, ax

    @ask:
        ; Display message
        mov ah, 09h
        lea dx, message
        int 21h
                
        mov ah, 01h
        int 21h
                
        sub al, 48
        mov hundreds, al

        mov ah, 01h
        int 21h
                
        sub al, 48
        mov tens, al

        mov ah, 01h
        int 21h
        
        xor ah, ah
        mov ones1, ax
        mov ah, 09h
        sub ones1, 48

        sub al, 48
        mov ones, al

        mov ah, 09h
        lea dx, newline
        int 21h

        xor al, al
        mov al, hundreds
        mov bl, 100
        mul bl
        mov num, ax 

        mov al, tens
        mov bl, 10
        mul bl
        add num, ax
        mov bx, ones1
        add num, bx

        cmp num, 399
        jle @start
        jg @error
        
    @start:
        cmp num, 000
        je @error

        @hundreds:
            mov ah, hundredsvalue
            cmp ah, hundreds
            je @tens
                    
            mov ah, 02h
            mov dl, 'C'
            int 21h

            inc hundredsvalue
            jmp @hundreds
                    
        @tens:
            ; 90
            .if tens == 9
                mov ah, 02h
                mov dl, 'X'
                int 21h
                        
                mov ah, 02h
                mov dl, 'C'
                int 21h
                        
                sub tens, 9
                jmp @tens
            ; 50
            .elseif tens >= 5
                mov ah, 02h
                mov dl, 'L'
                int 21h
                        
                sub tens, 5
                jmp @tens
            ; 40
            .elseif tens == 4
                mov ah, 02h
                mov dl, 'X'
                int 21h
                        
                mov ah, 02h
                mov dl, 'L'
                int 21h
                        
                sub tens, 4
                jmp @tens
            .endif 
                    
            mov ah, tensvalue
            cmp ah, tens
            je @ones
                    
            mov ah, 02h
            mov dl, 'X'
            int 21h
                    
            inc tensvalue
            jmp @tens
                    
        @ones:
            ; 9
            .if ones == 9
                mov ah, 02h
                mov dl, 'I'
                int 21h
                        
                mov ah, 02h
                mov dl, 'X'
                int 21h
                        
                sub ones, 9
                jmp @ones
            ; 5
            .elseif ones >= 5
                mov ah, 02h
                mov dl, 'V'
                int 21h
                        
                sub ones, 5
                jmp @ones
            ; 4
            .elseif ones == 4
                mov ah, 02h
                mov dl, 'I'
                int 21h
                        
                mov ah, 2
                mov dl, 'V'
                int 21h
                        
                sub ones, 4
                jmp @ones 
            .endif 

            mov ah, onesvalue
            cmp ah, ones
            je @end
                    
            mov ah, 02h
            mov dl, 'I'
            int 21h
                    
            inc onesvalue    
            jmp @ones
                            
    @error:
        ; Display message
        mov ah, 09h
        lea dx, error
        int 21h
        
        mov ah, 09h
        lea dx, newline
        int 21h
        jmp @ask

    @end:
        mov ax, 4c00h
        int 21h
        main endp
end main