.model small            ;Модель памяти Small
.286                    ;16 разрядный проц
.stack 100h             ;Директива .STACK описывает сегмент стека
.data                   ;Идентификатор сегмента данных
    Sr00 db 24 dup (20h),218,32 dup (196),191,10,13,'$'
    Sr01 db 24 dup (20h),192,32 dup (196),217,10,13,'$'
.code
vivod macro     ;Макро вывода пробела
    mov dl,20h; код символа «пробел»
    mov ah,02h
    int 21h
    endm
start: 
    mov ax, @data       ;Передаем @data в ax
    mov ds, ax          ;Передаем ax в ds
    mov si, 0           ;код символа
    mov cx,2
k1: 
    mov dl, 10          ;переход на новую строку
    mov ah,02h
    int 21h
    loop k1             ;Выполняем k1 два раза (cx = 2)
    
    ;Вывод Верхней линии
    mov dx, offset Sr00     
    mov ah,9h               
    int 21h                 
    mov di,0; количество выведенных символов в строке
    mov cx, 24 ; для вывода 24-х пробелов
    
    jmp k2
    
m4:
    mov dl, 179
    mov ah, 02h
    int 21h
m2: 
    mov di,0; количество выведенных символов в строке
    mov cx, 24 ; для вывода 24-х пробелов
    
    mov dl, 10
    mov ah, 02h
    int 21h
k2: 
    vivod
    loop k2
    
    mov dl, 179
    mov ah, 02h
    int 21h
k3: 
    cmp si, 256
    je konec
    ;Исключение управляющих символов
    cmp di, 16
    je m4
    cmp si,27
    ja l1
    cmp si, 7
    je m1
    cmp si, 8
    je m1
    cmp si, 9
    je m1
    cmp si, 10
    je m1
    cmp si, 13
    je m1
    cmp si, 27
    jne l1
    
    mov ax, si
    ;mov al, 27
    int 29h
    vivod
    
    ; вывод символа
l1: 
    mov dx, si
    mov ah, 02h
    int 21h
    vivod
l2: 
    inc si
    inc di
    jmp k3
m1: 
    vivod
    vivod
    jmp l2
konec: 
    mov dl, 179
    mov ah, 02h
    int 21h
    mov dl, 10
    mov ah, 02h
    int 21h
    
    ;Вывод нижней линии
    mov dx, offset Sr01     
    mov ah,9h               
    int 21h                
    
    mov ah, 4ch         ;Передаем код завершения программы
    int 21h             ;Вызываем прерывание для выполнения команды
end start               ;Окончания блока start