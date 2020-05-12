.model small
.286
.stack 100h

.code

start: 
    mov ah, 00h
    mov al, 11h
    int 10h
    mov dx, 10
    mov cx, 10
    mov si, 0
    
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
t2:   
    mov ah, 0Ch
    mov bh, 0
    int 10h
    inc cx
    dec dx
    inc si
    
    cmp si, 400
    je k2
    
    jmp t2
    
    
k2:
    mov si, 0

k3:
    cmp si, 100
    je konec
    inc si
    
    ;mov ah,0Fh
    ;int 10h;вызвать функцию 0F прерывания 10h
    
    mov     CX,0    ;координата левого верхнего угла 0,0
    mov     DH,30   ;правый нижний угол на строке 12
    mov     DL,80   ;столбец 31
    mov     AL,1    ;переместить 1 строку
    mov     BH,0010000b  ;атрибут новой строки
    mov     AH,6    ;прокрутка вверх
    int     10h     ;вызов видео-BIOS
    
    mov cx,65535
m1:
    nop
    nop
    nop
    nop
    nop
    loop m1
    jmp k3

konec:
    mov ah,4ch
    int 21h
end start