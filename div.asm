data segment
msg1 db "Enter first number: $"
msg2 db "Enter second number: $"
msg3 db "Remainder is: $"
a dw ?
b dw ?
data ends

code segment
assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax
    
    ; display msg1 and take input for a
    mov dx, offset msg1
    mov ah, 9
    int 21h
    
    ; take input for a
    mov ah, 1
    int 21h
    sub al, '0'
    mov bl, al
    
    mov ah, 1
    int 21h
    sub al, '0'
    mov bh, al
    
    ; combine the digits to form a
    mov ax, 0
    mov al, bl
    mov ah, 10
    mul ah
    add ax, bx
    mov a, ax
    
    ; display msg2 and take input for b
    mov dx, offset msg2
    mov ah, 9
    int 21h
    
    ; take input for b
    mov ah, 1
    int 21h
    sub al, '0'
    mov bl, al
    
    mov ah, 1
    int 21h
    sub al, '0'
    mov bh, al
    
    ; combine the digits to form b
    mov ax, 0
    mov al, bl
    mov ah, 10
    mul ah
    add ax, bx
    mov b, ax
    
    ; divide a by b and get remainder
    mov ax, a
    xor dx, dx ; clear dx before dividing
    div b
    mov dl, ah ; remainder is stored in ah
    
    ; display msg3 and the remainder
    mov dx, offset msg3
    mov ah, 9
    int 21h
    
    mov al, dh
    add al, '0'
    mov ah, 2
    int 21h
    
    mov al, dl
    add al, '0'
    mov ah, 2
    int 21h
    
    ; terminate program
    mov ah, 4ch
    int 21h
code ends
end start