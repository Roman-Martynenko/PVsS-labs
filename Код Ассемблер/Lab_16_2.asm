.model small
.286
.stack 100h

.code

start: 
    mov ah, 00h
    mov al, 12h
    int 10h
    mov dx, 0
    mov cx, 0
    mov si, 0
    
    ; рисую диоганальную линию
k1:
    mov ah, 0Ch
    mov bh, 0
    int 10h
    inc cx
    inc dx
    inc si
    
    cmp si, 400
    je t1
    
    jmp k1
t1: 
    mov cx, 0
    mov si, 0
    mov al, 1
t2:   ; рисую диоганальную линию которая пересекает преддущию
    mov ah, 0Ch
    mov bh, 0
    int 10h
    inc cx  ; каждый пиксель меняю цвет
    inc al
    dec dx
    inc si
    
    cmp si, 400
    je k2
    
    jmp t2
    
    
k2:
    mov dx, 1
    mov cx, 0
    mov si, 0
    jmp k3
    
k4:
    mov cx, 0
    inc dx
    
k3: 
    cmp dx, 480
    je k5
    cmp cx, 640
    je k4
    
    mov ah, 0dh ;считываю цвет пикселя
    int 10h
    
    dec dx
    mov ah, 0Ch ; рисую пиксель на строку выше
    mov bh, 0
    int 10h

    inc dx  
    inc cx  ;перехожу на следующий столбец
    jmp k3

k5:
    cmp si, 480
    je konec
    inc si
    
    mov dx, 1
    mov cx, 0
    jmp k3
    

konec:
    mov ah,4ch
    int 21h
end start