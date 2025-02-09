
; Materia: INF153 Assembler
; Estudiante: Erick Gutierrez Morales


mescolx macro texto, color
    mov al, texto
    mov bl, color
    mov cx, 35
    mov ah, 9
    int 10h
    mov ah, 9
    mov dx, offset texto
    int 21h
endm

messaje macro x
    lea dx, x
    mov ah, 9
    int 21h
endm

data segment
    v db 40 dup(0)
    enter db 10,13,36
    ms1 db "ES PRIMO$"
    ms2 db "NO ES PRIMO$"
    ms3 db "NUMERO FELIZ$"
    ms4 db "NUMERO INFELIZ$"
    ms5 db "NUMERO PERFECTO$"
    ms6 db "NUMERO IMPERFECTO$"
    ms7 db  "+---------------------------------+$"
    ms8 db  "|  cmd  |       descripcion       |$"
    ms9 db  "+-------+-------------------------+$"
    ms10 db "|   b   |  fibonacci              |$"
    ms11 db "|   f   |  factorial              |$"
    ms12 db "|   v   |  maximo comun divisor   |$"
    ms13 db "|   m   |  minimo comun multiplo  |$"
    ms14 db "|   d   |  divisores              |$"
    ms15 db "|   p   |  primos menores a       |$"
    ms16 db "|   e   |  es primo               |$"
    ms17 db "|   c   |  cuadrado               |$"
    ms18 db "|   u   |  cubo                   |$"
    ms19 db "|   t   |  potencia               |$"
    ms20 db "|   r   |  raiz cuadrada          |$"
    ms21 db "|   z   |  raiz                   |$"
    ms22 db "|   x   |  promedio               |$"
    ms23 db "|   l   |  numero feliz           |$"
    ms24 db "|   n   |  numero perfecto        |$"
    ms25 db "|   *   |  muestra el menu        |$"
    ms26 db "+-------+-------------------------+$"
    aux dw 0
    num dw 0
    ans dw 0
    sum dw 0
    cnt db 0
    cnu db 0
    cnv db 0
    a dw 0
    b dw 0
    x dw 0
    i dw 0  
    n db 0    
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
    ; set segment registers:
    mov ax, data
    mov ds, ax
    ;mov es, ax

    ; add your code here
    mov ax, 0
    mov cx, 0
    mov cl, es:[128]
    cmp cx, 0
    jz fin
    ; posicion con el metodo que se desea
    mov si, 130
    mov al, es:[si]
    add si,  2
    sub cl, 2 
    cmp al, 98
    jz fibonacci
    cmp al, 102
    jz factorial
    cmp al, 118
    jz maximoComunDivisor
    cmp al, 109
    jz minimoComunMultiplo
    cmp al, 100
    jz divisores
    cmp al, 112
    jz primosMenoresA
    cmp al, 101
    jz esPrimo
    cmp al, 99
    jz cuadrado
    cmp al, 117
    jz cubo
    cmp al, 116
    jz potencia
    cmp al, 114
    jz raizCuadrada
    cmp al, 122
    jz raiz
    cmp al, 120
    jz promedio
    cmp al, 108
    jz numeroFeliz
    cmp al, 110
    jz numeroPerfecto
    cmp al, 42
    jz menu
    jnz fin
    ;***********************************
    menu:
    mescolx ms7, 11
    messaje enter
    mescolx ms8, 11
    messaje enter
    mescolx ms9, 11
    messaje enter
    mescolx ms10, 11
    messaje enter
    mescolx ms11, 11
    messaje enter
    mescolx ms12, 11
    messaje enter
    mescolx ms13, 11
    messaje enter
    mescolx ms14, 11
    messaje enter
    mescolx ms15, 11
    messaje enter
    mescolx ms16, 11
    messaje enter
    mescolx ms17, 11
    messaje enter
    mescolx ms18, 11
    messaje enter
    mescolx ms19, 11
    messaje enter
    mescolx ms20, 11
    messaje enter
    mescolx ms21, 11
    messaje enter
    mescolx ms22, 11
    messaje enter
    mescolx ms23, 11
    messaje enter
    mescolx ms24, 11
    messaje enter
    mescolx ms25, 11
    messaje enter
    mescolx ms26, 11        
    jmp fin
    
    ;***********************************
    fibonacci:
    call readOneInput
    mov cx, bx
    mov a, -1
    mov b, 1
    fibo:
        mov bx, a
        add bx, b
        mov ax, b
        mov a, ax
        mov b, bx  
        push cx
        mov ans, bx
        call print
        pop cx 
    loop fibo
    jmp fin
    
    ;***********************************
    factorial:
    call readOneInput
    mov cx, 0
    mov cl, bl
    mov bx, 1
    mov x, 1
    cmp cl, 0
    jz printFactorial
    facto:
        mov ax, bx
        mov bx, x
        mul bx
        mov bx, ax
        inc x    
    loop facto
    printFactorial:
    mov ans, bx
    call print
    jmp fin
    
    ;***********************************
    maximoComunDivisor:
    call readTwoInput
    mcd:
        mov dx, 0
        mov ax, a
        mov bx, b
        div bx
        mov ax, b
        mov b, dx
        mov a, ax
        cmp b, 0
        jz endMcd
    jnz mcd
    endMcd:
    mov bx, a
    mov ans, bx
    call print
    jmp fin
    
    ;***********************************
    minimoComunMultiplo:
    call readTwoInput
    mov x, 0
    mov ax, a
    mov bx, b
    mul bx
    mov x, ax
    mcm:
        mov dx, 0
        mov ax, a
        mov bx, b
        div bx
        mov ax, b
        mov b, dx
        mov a, ax
        cmp b, 0
        jz endMcm
    jnz mcm
    endMcm:
    mov ax, x
    mov bx, a
    div bx
    mov ans, ax
    call print     
    jmp fin
    
    ;***********************************
    divisores:
    call readOneInput
    mov aux, bx
    mov num, bx
    inc num
    mov cx, 1
    divider:
        mov dx, 0
        mov ax, aux
        mov bx, cx
        div bx
        cmp dx, 0
        jz printDivider
        jnz searchDivider
        printDivider:
            mov ans, cx
            call print
        searchDivider:
        inc cx
        cmp cx, num
        jz endDivider
    jnz divider    
    endDivider:
    jmp fin
    
    ;***********************************
    primosMenoresA:
    call readOneInput
    mov cx, bx
    mov aux, 1
    for:
        mov bx, aux
        mov num, bx    
        call checkPrime
        cmp x, 0
        jz noEsPrimo
        mov ax, aux
        mov ans, ax
        call print
        noEsPrimo:
        inc aux
    loop for
    jmp fin
    
    ;***********************************
    esPrimo:
    call readOneInput
    mov num, bx
    call checkPrime
    cmp x, 0
    jz printFalse
    jnz printTrue
    printFalse:
    messaje ms2
    jmp fin
    printTrue:
    messaje ms1
    jmp fin
    
    ;***********************************
    cuadrado:
    call readOneInput
    mov ax, bx
    mul bx
    mov ans, ax
    call print
    jmp fin   
     
    ;***********************************
    cubo:
    call readOneInput
    mov ax, bx
    mul bx
    mul bx
    mov ans, ax
    call print
    jmp fin
       
    ;***********************************
    potencia:
    call readTwoInput
    mov bx, 1
    power:
        mov ax, bx
        mov bx, a
        mul bx
        mov bx, ax
        dec b
        cmp b, 0
        jz endPower
    jnz power        
    endPower:
    mov ans, bx
    call print
    jmp fin
    
    ;***********************************
    raizCuadrada:
    call readOneInput
    mov cx, 0
    cmp bx, 0
    jz save
    cmp bx, 1
    jz save
    mov i, 1
    mov ax, 1        
    cmp ax, bx
    ja save
    root:
        inc i
        mov ax, i
        mov cx, i
        mul cx
        cmp ax, bx
        ja endRoot
    jbe root
    endRoot:
    dec i
    mov ax, i
    mov ans, ax
    jmp checkDecimal
    save:
    mov ans, bx
    
    checkDecimal:
    ; obtenemos el primer residuo
    mov cx, bx
    mov ax, i
    mov bx, i
    mul bx
    sub cx, ax
    ; aniadimos 2 ceros para los decimales
    mov ax, cx
    mov bx, 100
    mul bx
    mov cx, ax
    ; iteramos para encontrar el 1er decimal
    mov ax, i
    mov bx, 20
    mul bx
    call getDecimal
    mov ax, i
    mov a, ax
    ; obtenemos el segundo residuo
    mov ax, cx
    sub ax, x
    ; aniadimos dos ceros para los decimales
    mov bx, 100
    mul bx
    mov cx, ax
    ; iteremos para encontrar el 2do decimal
    mov ax, ans
    mov bx, 10
    mul bx
    add ax, a
    mov bx, 20
    mul bx
    call getDecimal
    mov ax, i
    mov b, ax
    ; imprimimos la parte entera
    mov cnv, 1
    call print
    ; imprimimos el punto decimal
    mov dl, 46
    mov ah, 2
    int 21h
    ; imprimimos el primer decimal
    mov ax, a
    mov ans, ax
    call print
    ; imprimimos el segundo decimal
    mov ax, b
    mov ans, ax
    call print  
    jmp fin
    
    ;***********************************
    raiz:
    call readTwoInput
    cmp a, 0
    jz imprimir
    cmp a, 1
    jz imprimir
    mov i, 1
    mov cx, 0
    radical:
        mov ax, 1
        mov cx, b
        ciclo:
            mov bx, i
            mul bx
        loop ciclo
        cmp ax, a
        ja endRadical
        inc i
    jbe radical
    endRadical:
    dec i
    imprimir:
    mov ax, i
    mov ans, ax
    call print
    jmp fin
      
    ;***********************************
    promedio:
    mov cnt, cl
    mov ax, 0
    mov bx, 0
    mov cx, 0
    mov num, 0
    mov sum, 0
    mov cnu, 0
    forPromedio:
        mov cl, es:[si]
        cmp cl, 13
        jz endPromedio
        cmp cl, 32
        jz set
        jnz componer
        set:
        add sum, bx
        inc cnu
        mov bx, 0
        jmp noComponer
        componer:
        sub cl, 48
        mov ax, bx
        mov bx, 10
        mul bx
        add ax, cx
        mov bx, ax
        noComponer:
        inc si
        dec cnt
        cmp cnt, 0
        jz endPromedio   
    jnz forPromedio
    endPromedio:
    add sum, bx
    inc cnu
    
    mov ax, 0
    mov bx, 0
    mov dx, 0
    ; parte entera
    mov ax, sum
    mov bl, cnu
    div bx
    mov cnv, 1
    mov ans, ax
    push dx
    call print
    ; impresion del punto decimal
    mov dl, 46
    mov ah, 2
    int 21h
    pop dx
    ; obtenemos los decimales
    mov cnt, 2
    forDec:
        mov ax, dx
        mov bx, 10
        mul bx
        mov dx, 0
        mov bl, cnu
        div bx
        push dx
        mov dl, al
        add dl, 48
        mov ah, 2
        int 21h
        pop dx
        dec cnt
        cmp cnt, 0
        jz endForDec
    jnz forDec
    endForDec:    
    jmp fin
    
    ;***********************************
    numeroFeliz:
    call readOneInput
    mov num, bx
    ; verificamos si es un numero feliz
    mov si, offset v
    mov cx, 0
    mov n, 0
    happyNumber:
        mov sum, 0
        mov cnt, 0
        while1:
            mov dx, 0
            mov ax, bx
            mov bx, 10
            div bx
            push dx
            inc cnt
            cmp ax, 0
            jz endWhile1
            mov bx, ax
        jnz while1
        endWhile1:
        while2:
            pop ax
            mov bx, ax
            mul bx
            add sum, ax
            dec cnt
            cmp cnt, 0
            jz endWhile2
        jnz while2    
        endWhile2:
        cmp sum, 1
        jz endHappyNumber
        ; verificamos que no exista sum en el
        ; array y guardamos.
        mov di, offset v
        mov ax, sum
        mov cl, n
        cmp cx, 0
        jz pass
        forArray:
            cmp al, [di]
            jz endHappyNumber
            inc di    
        loop forArray
        pass:
        mov ax, sum
        mov [si], ax
        inc si
        inc n
        ; actualizamos el valor de bx
        mov bx, sum
    jnz happyNumber    
    endHappyNumber:    
    cmp sum, 1
    jz verdad
    jnz falso
    verdad:
        messaje ms3
        jmp fin
    falso:
        messaje ms4
        jmp fin
    
    ;***********************************
    numeroPerfecto:
    call readOneInput
    mov dx, 0
    mov cx, 0
    mov num, bx
    mov sum, 0
    mov cx, 1
    findDivider:
        mov dx, 0
        mov ax, num
        mov bx, cx 
        div bx
        cmp dx, 0
        jz igual
        jnz noigual
        igual:
        add sum, cx
        noigual:
        inc cx
        cmp cx, num
        jz endFindDivider
    jnz findDivider
    endFindDivider:     
    mov ax, num
    mov bx, sum
    cmp ax, bx
    jz perfect
    jnz notPerfect
    perfect:
        messaje ms5
        jmp fin
    notPerfect:
        messaje ms6
           
    ;***********************************
    fin:
    ; exit to operating system
    mov ax, 4c00h 
    int 21h
    
    ;***********************************
    ; subrutina para leer un solo numero
    readOneInput:
    mov ax, 0
    mov bx, 0
    mov cnu, cl
    mov cx, 0
    oneInput:
        mov cl, es:[si]
        cmp cl, 13
        jz endOneInput
        sub cl, 48
        mov ax, bx
        mov bx, 10
        mul bx
        add ax, cx
        mov bx, ax
        dec cnu
        cmp cnu, 0
        jz endOneInput
        inc si        
    jnz oneInput
    endOneInput:
    ret
    
    ; subrutina para leer dos numeros
    readTwoInput:
    mov ax, 0
    mov bx, 0
    mov cnu, cl
    mov cx, 0
    twoInput:
        mov cl, es:[si]
        cmp cl, 13
        jz endTwoInput
        cmp cl, 32
        jz reset
        jnz compose
        reset:
        mov a, bx
        mov ax, 0
        mov bx, 0
        mov cx, 0
        jmp decompose
        compose:
        sub cl, 48
        mov ax, bx
        mov bx, 10
        mul bx
        add ax, cx
        mov bx, ax
        decompose:
        dec cnu
        cmp cnu, 0
        jz endTwoInput
        inc si
    jnz twoInput
    endTwoInput:
    mov b, bx    
    ret
    
    ; subrutina verifica si es Primo
    checkPrime:
    cmp num, 1
    jbe false
    cmp num, 2
    jz true
    mov dx, 0
    mov ax, num
    mov bx, 2
    div bx
    cmp dx, 0
    jz false
    mov i, 3
    mov ax, i
    mov bx, i
    mul bx
    cmp ax, num
    ja true
    prime:
        mov dx, 0
        mov ax, num
        mov bx, i
        div bx
        cmp dx, 0
        jz false
        add i, 2
        mov ax, i
        mov bx, i
        mul bx
        cmp ax, num
        ja true
    jbe prime    
    false:
        mov x, 0
        jmp continue
    true:
        mov x, 1
    continue:
    ret    
    
    ; subrutina obtener decimal
    getDecimal:
    mov i, 1
    decimal:
        push ax
        add ax, i
        mov bx, i
        mul bx
        cmp ax, cx
        jae endDecimal
        mov x, ax
        pop ax
        inc i
    jb decimal 
    endDecimal:
    dec i
    pop ax
    ret    
    
    ; subrutina mostrar
    print:
    mov cnt, 0
    getDigit:
        mov dx, 0
        mov ax, ans
        mov bx, 10
        div bx
        push dx
        inc cnt
        mov ans, ax
        cmp ans, 0
        jz endGetDigit
    jnz getDigit
    endGetDigit:
    mostrar:
        pop dx
        add dl, 48
        mov ah, 2
        int 21h
        dec cnt
        cmp cnt, 0
        jz finMostrar
    jnz mostrar
    finMostrar:
    cmp cnv, 1
    jz notSpace    
    mov dl, 32
    mov ah, 2
    int 21h
    notSpace:    
    ret        
ends

end start
