.model Small
.286
.stack 100h
.data
.code
vivod macro; vivod probelov
    mov al, 20h
    mov cx,1
    mov ah, 09h
    mov bh,0
    int 10h
    endm
    
easy_vivod macro        ; Макрос для быстрого вывода символа
    mov cx, 1
    mov ah, 09h
    mov bh,0
    mov bl,01110000b    ; цветовая схема
    int 10h
    
    inc dl
    mov bh,0
    mov ah, 02h
    int 10h
    endm
    
easy_vivod2 macro       ; Макрос для быстрого вывода большого количества символов
    mov ah, 09h
    mov bh,0
    mov bl,01110000b
    int 10h
    
    add dl, cl
    mov bh,0
    mov ah, 02h
    int 10h
    endm
    
start: 
    mov ah, 00h
    mov al, 03h     ; режим видеовывода
    int 10h
    mov di,0 ; shetchik elementov stroki
    mov si,0 ; shetchik simvolov
    mov dh, 3
    
    inc dh
    mov dl, 23
    mov bh,0
    mov ah, 02h
    int 10h
    ; вывожу часть рамки
    mov al, 218
    easy_vivod
    
    mov al, 196
    mov cx, 32
    easy_vivod2
    
    mov al, 191
    easy_vivod
    
    jmp m2
    
m1:
    ; вывод | в конце таблицы
    mov al, 179
    easy_vivod
m2:    
    mov di, 0
    inc dh
    mov dl, 23
    
    mov bh,0
    mov ah, 02h
    int 10h
    
    ; вывод | в начале таблицы
    mov al, 179
    easy_vivod
k1:
    mov bh,0
    mov ah, 02h
    int 10h
    
    cmp si, 256
    je konec
    cmp di, 16
    je m1
    
    ;vivod simvola
    mov ax, si
    mov cx, 1
    mov ah, 09h
    mov bh,0
    mov bl,01110000b
    int 10h
    inc si
    inc di
    inc dl
    
    mov bh,0
    mov ah, 02h
    int 10h
    
    vivod
    inc dl
    
    jmp k1
    
konec:
    ; вывожу часть рамки
    mov al, 179
    easy_vivod
    
    inc dh
    mov dl, 23
    mov bh,0
    mov ah, 02h
    int 10h
    
    mov al, 192
    easy_vivod
    
    mov al, 196
    mov cx, 32
    easy_vivod2
    
    mov al, 217
    easy_vivod
    
    
    mov ah, 4ch
    int 21h
end start