.model small            ;Модель памяти Small
.286                    ;16 разрядный проц
.stack 100h             ;Директива .STACK описывает сегмент стека
.data                   ;Идентификатор сегмента данных
;Переменные Message, fio, gruppa типа строка,
;формата db - 1 байт на символ
    Message db 'Hello World',10,13,'$'
    fio db 'Martynenko Roman Sergeevich',10,13,'$'
    gruppa db 'I-2-18',10,13,'$'
.code                       ;Идентификатор сегмента кода

start:                      ;Метка начала блока start
    mov ax, @data           ;Передаем @data в ax
    mov ds, ax              ;Передаем ax в ds

    mov dx, offset Message  ;В dx записываем значение переменной Message
    mov ah,9h               ;в ah передаем код -9h (Вывод на экран)
    int 21h                 ;Вызываем прерывание для выполнения команды
    
    mov ah,9                ;в ah передаем код -9h (Вывод на экран)
    mov dx,offset fio       ;В dx записываем значение переменной fio
    int 21h                 ;Вызываем прерывание для выполнения команды
    ;Вывели fio на экран
    
    mov ah,9                ;в ah передаем код -9h (Вывод на экран)
    mov dx,offset gruppa    ;В dx записываем значение переменной gruppa
    int 21h                 ;Вызываем прерывание для выполнения команды
    ;Вывели gruppa на экран

    mov ah, 4ch         ;Передаем код завершения программы
    int 21h             ;Вызываем прерывание для выполнения команды
end start               ;Окончания блока start
