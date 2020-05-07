.model small            ;Модель памяти Small
.286                    ;16 разрядный проц
.stack 100h             ;Директива .STACK описывает сегмент стека
.data                   ;Идентификатор сегмента данных
    Sr00 db 'No lines with the specified character exist',10,13,'$'
.code
start: 
    mov ax, [ds:2ch]        ;Среда окружения
    mov ds, ax
    mov si, -1              ;Регистр указателя символа
    mov di, -1              ;Регистр указателя начала строки
    mov bl, 0

k3: 
    inc di
    mov si,di ; nachalo obozrevaemoy stroki
k2: 
    mov dl,[ds:si] ; simvol iz sredy okrujeniya
    cmp dl,'9'
    je k1 ; simvol est'
    inc si
    cmp dl,0
    jne k2
    
    mov dl,[ds:si]          ;proverka na vtoroy 0
    cmp dl,0
    jne k3
    
; stroki net
    cmp bl, 0
    je k7
    
    jmp k6
    
k1:     ;vyvod stroki
    mov dl,[ds:di]
    mov ah,2h
    int 21h
    cmp dl,0
    je k4
    inc di
    jmp k1
    
k4:         ; - переход на след строку
    mov bl, 1
    mov dl,10
    mov ah,2h
    int 21h
    mov dl,13
    mov ah,2h
    int 21h

    jmp k3

k7:
    mov ax, @data           ;Передаем @data в ax
    mov ds, ax              ;Передаем ax в ds
    
    mov dx, offset Sr00     ;В dx записываем значение переменной Message
    mov ah,9h               ;в ah передаем код -9h (Вывод на экран)
    int 21h                 ;Вызываем прерывание для выполнения команды

k6:     ;exit
    mov ah, 4ch         ;Передаем код завершения программы
    int 21h             ;Вызываем прерывание для выполнения команды
end start   