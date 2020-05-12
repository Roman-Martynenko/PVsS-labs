.model small
.286
.code

easy_vivod macro        ; Макро для упрощения вывода символов через видеопамять
    mov [ds:si],al
    inc si
    mov [ds:si],00100000b
    inc si
    endm

start:
    mov di, 0
    mov bx, 0

    mov ah,00h
    mov al,03h      ; Видеорежим
    int 10h
    
    mov ax,0b800h   ; адресс видеопамяти
    mov ds,ax
    mov si,850
    
    jmp k1
    
m1:     ; Переход на новую строчку
    mov bl, 0
    add si, 96
    
k1:
    cmp di, 256
    je konec
    cmp bl, 16
    je m1
    
    ; вывод символа
    mov ax,di
    easy_vivod
    inc di
    inc bl
    
    ; вывод пробела
    mov ax, 20h
    easy_vivod
    jmp k1

    
    mov ah,08h
    int 21h

konec:
    mov ah,4ch
    int 21h
end start