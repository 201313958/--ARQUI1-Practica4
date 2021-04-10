;menú para ingresar texto, mostrar texto y un ciclo 
include macros.asm 
.model small 
; -------------- SEGMENTO DE PILA -----------------
.stack 
; -------------- SEGMENTO DE DATOS -----------------
.data 
;Cadenas de encabezados y menus
encabezado1 db 0ah,0dh, 'UNIVERSIDAD DE SAN CARLOS DE GUATEMALA' , '$'
encabezado2 db 0ah,0dh, 'ESCUELA DE CIENCIAS Y SISTEMAS' , '$'
encabezado3 db 0ah,0dh, 'ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1' , '$'
encabezado4 db 0ah,0dh, 'SECCION B' , '$'
encabezado5 db 0ah,0dh, 'PRIMER SEMESTRE 2021' , '$'
encabezado6 db 0ah,0dh, 'Jose Pablo Valiente Montes' , '$'
encabezado7 db 0ah,0dh, '201313958' , '$'
encabezado8 db 0ah,0dh, 'Primer Practica Assembler' , '$'
cadena_menu1 db 0ah,0dh,   '*********** MENU ***********' , '$'
cadena_opcion1 db 0ah,0dh, '***  1.) Cargar Archivo  ***' , '$'
cadena_opcion2 db 0ah,0dh, '***  2.) Ordenar         ***' , '$'
cadena_opcion3 db 0ah,0dh, '***  3.) Generar Reporte ***' , '$'
cadena_opcion4 db 0ah,0dh, '***  4.) Salir           ***' , '$'
cadena_menu2 db 0ah,0dh,   '****************************' , '$'
cadena_menu_ordenar db 0ah,0dh,   '********** ORDENAR *********' , '$'
cadena_bubble db 0ah,0dh,         '***    1.) Bubblesort    ***' , '$'
cadena_quick db 0ah,0dh,          '***    2.) Quicksort     ***' , '$'
cadena_shell db 0ah,0dh,          '***    3.) Shellsort     ***' , '$'
cadena_velocidad db 0ah,0dh,      'Ingrese un numero(0-9):' , '$'
cadena_menu_tipo db 0ah,0dh,   '********** TIPO *********' , '$'
cadena_asc db 0ah,0dh,            '***  1.) Ascedente    ***' , '$'
cadena_des db 0ah,0dh,            '***  2.) Descendete   ***' , '$'

Msg_Debu db 0ah,0dh, 'SI ESTA PASANDO POR AQUI', '$'
Debug db 20,'$'
saltolinea db 10,'$'

;Cargar de Archivos
ingreseruta db 0ah,0dh, 'Ingrese una ruta de archivo: ' , 0ah,0dh, 'Ejemplo: entrada.xml' , '$'
bufferentrada1 db 50 dup('$')
handlerentrada1 dw ?
bufferInformacion1 db 20000 dup('$')
err1 db 0ah,0dh, 'Error al abrir el archivo puede que no exista' , '$'
err5 db 0ah,0dh, 'Error al leer en el archivo' , '$'
NumTemp db 2 dup('$')
temp db 2 dup('$')
SeCargoExito db 0ah,0dh, 'Se Cargo exitosamente...' , 0ah,0dh, '$'

;Vectores para hacer los Ordenamientos
Vec_Original db 50 dup('$')
Vec_Actual db 50 dup('$')
Vec_Quick db 50 dup('$')
cadena_Ordenado db 0ah,0dh, 'Se ordeno correctamente', '$'
tamanio db 2 dup('$')
tamanio_1 db 2 dup('$')
Count db 2 dup('$')
i db 2 dup('$')
j db 2 dup('$')

;ordenamiento burbuja
vecJ db 2 dup('$')
vecJmas1 db 2 dup('$')

;Ordenamiento shell
vecI db 2 dup('$')
vecI_salto db 2 dup('$')
salto db 2 dup('$')
aux db 2 dup('$')
cambios db 2 dup('$')

;Ordenamiento Quick
buf db 2 dup('$')
from db 2 dup('$')
to db 2 dup('$')
pivot db 2 dup('$')
matrix_from db 2 dup('$')
matrix_to db 2 dup('$')
A db 2 dup('$')
B db 2 dup('$')

;Delay
tiempo db 2 dup('$')

;Modo Video 
Ordenamiento_Burbuja db 'Ordenamiento: BubbleSort', '$'
Ordenamiento_Shell db   'Ordenamiento: ShellSort', '$'
Ordenamiento_Quick db   'Ordenamiento: QuickSort', '$'
Cadena_vel db 'Velocidad: ', '$'
Cadena_Tiempo db        'Tiempo: ', '$'
Fila db 0
Fila_Actual db 0
Columna db 0
Columna_Actual db 0
Espacio_Vector db 2 dup('$')
Num_vector db 2 dup('$')
Espacio_Barra db 2 dup('$')
Fin_Barra dw 2 dup('$')
Alto_Barra db 2 dup('$')
Alto_Acutal db 2 dup('$')
Color_Barra db 0
i_Barra db 2 dup('$')
j_Barra db 2 dup('$')

.code
main proc far

    mov ax,@data
    mov ds,ax

    
    ;jmp salir

    ;---------- Se Imprime el Encabezado --------------
	encabezado:
        print encabezado1
		print encabezado2
		print encabezado3
		print encabezado4
		print encabezado5
		print encabezado6
		print encabezado7
		print encabezado8
		print saltolinea
        jmp menu	
    ;---------- Se Imprime el Menu --------------------
    menu:        
		print cadena_menu1
		print cadena_opcion1
		print cadena_opcion2
		print cadena_opcion3
		print cadena_opcion4
		print cadena_menu2
		print saltolinea
		getChar
        ;cmp para comparar 
		cmp al,49 ;mnemonio 31h = 1 en hexadecimal, ascii 49
			je carga_archivos
		cmp al,50 ;mnemonio 32h = 2 en hexadecimal, ascii 50
			je menu_ordenar
		cmp al,51 ;mnemonio 33h = 3 en hexadecimal, ascii 51
			;je factorial
		cmp al,52 ;mnemonio 34h = 4 en hexadecimal, ascii 52
			je salir
		jmp menu
    ;---------- Se Imprime el menu de ordenamientos ---
    menu_ordenar:
        print saltolinea
        print cadena_menu_ordenar
        print cadena_bubble
        print cadena_quick
        print cadena_shell
        print cadena_menu2
        print saltolinea
        getChar
        cmp al,49 ;mnemonio 31h = 1 en hexadecimal, ascii 49
			je Bubblesort
		cmp al,50 ;mnemonio 32h = 2 en hexadecimal, ascii 50
			je Quicksort
		cmp al,51 ;mnemonio 33h = 3 en hexadecimal, ascii 51
			je Shellsort
        jmp menu_ordenar
    ;---------- Ordenamiento BubbleSort, Velocidad ----
    Bubblesort:
        print cadena_velocidad ;Determinamos la velocidad de la simulacion
        print saltolinea
        getChar
        mov tiempo[0],al
        cmp al, 48 ;Si es menor a 0 se repite el menu
            jl Bubblesort
        cmp al, 57
            jg Bubblesort ;Si es mayor a 9 se repite el menu
        jmp ASC_DES_Bublesort
    
    ASC_DES_Bublesort:
        print saltolinea
        print cadena_menu_tipo
        print cadena_asc
        print cadena_des
        print cadena_menu2
        print saltolinea
        getChar
        cmp al, 49
            je ASC_Bubblesort ;Bubblesort Ascendente
        cmp al, 50
            je DES_Bubblesort ;Bubblesort Descendente
        jmp ASC_DES_Bublesort
    
    ;---------- Ordenamiento BubbleSort Ascendente-----
    ASC_Bubblesort:
        llenar_Vector Vec_Original, Vec_Actual
        print saltolinea
        print Vec_Original
        print saltolinea
        Bubblesort_Ascendente Vec_Actual

        jmp menu
    
    ;---------- Ordenamiento BubbleSort Desscendente---
    DES_Bubblesort:
        llenar_Vector Vec_Original, Vec_Actual
        print saltolinea
        print Vec_Original
        print saltolinea
        Bubblesort_Descendente Vec_Actual
        jmp menu
    ;---------- Ordenamiento QuickSort, Velocidad -----
    Quicksort:
        print cadena_velocidad ;Determinamos la velocidad de la simulacion
        print saltolinea
        getChar
        cmp al, 48 ;Si es menor a 0 se repite el menu
            jl Quicksort
        cmp al, 57
            jg Quicksort ;Si es mayor a 9 se repite el menu
        jmp ASC_DES_Quicksort

    ASC_DES_Quicksort:
        print saltolinea
        print cadena_menu_tipo
        print cadena_asc
        print cadena_des
        print cadena_menu2
        print saltolinea
        getChar
        cmp al, 49
            je ASC_Quicksort ;Quicksort Ascendente
        cmp al, 50
            je DES_Quicksort ;Quicksort Descendente
        jmp ASC_DES_Quicksort
    ;---------- Ordenamiento QuickSort Ascendente -----
    ASC_Quicksort:
        xor ax,ax
        xor bx,bx
        
        mov al,0
        mov from[0],al; Asignar 0 a from
        mov A[0],al
        
        mov al,tamanio[0]
        mov bl,1
        sub al,bl
        mov to[0],al ;Asignar el tamanio-1 a to
        mov B[0],al
        
        mov al, to[0]
        mov bl,2
        div bl
        mov pivot[0],al 
        MoverSi pivot
        mov al,Vec_Quick[si]
        mov pivot[0],al ;Asignamos a pivot el Valor de la mitad
        
        call Quicksort_Ascendente
        

        
        print saltolinea
        print Vec_Original
        print saltolinea
        print Vec_Quick
        jmp menu

    ;---------- Ordenamiento QuickSort Descendente ----    
    DES_Quicksort:
        ;call Quicksort_Descendente
        jmp menu
    ;---------- Ordenamiento ShellSort, Velocidad -----
    Shellsort:
        print cadena_velocidad ;Determinamos la velocidad de la simulacion
        print saltolinea
        getChar
        mov tiempo[0],al
        cmp al, 48 ;Si es menor a 0 se repite el menu
            jl Shellsort
        cmp al, 57
            jg Shellsort ;Si es mayor a 9 se repite el menu
        jmp ASC_DES_Shellsort
    ASC_DES_Shellsort:
        print saltolinea
        print cadena_menu_tipo
        print cadena_asc
        print cadena_des
        print cadena_menu2
        print saltolinea
        getChar
        cmp al, 49
            je ASC_Shellsort ;Bubblesort Ascendente
        cmp al, 50
            je DES_Shellsort ;Bubblesort Descendente
        jmp ASC_DES_Shellsort

    ;---------- Ordenamiento ShellSort Ascendente ----
    ASC_Shellsort:
        llenar_Vector Vec_Original, Vec_Actual
        print saltolinea
        print Vec_Original
        print saltolinea
        Shellsort_Ascendente Vec_Actual
        jmp menu

    ;---------- Ordenamiento ShellSort Descendente ----    
    DES_Shellsort:
        llenar_Vector Vec_Original, Vec_Actual
        print saltolinea
        print Vec_Original
        print saltolinea
        Shellsort_Descendente Vec_Actual
        jmp menu

    ;---------- Error para la carga de archivos -------
    Error1:
		print saltolinea
		print err1
		getChar
		jmp menu
	;---------- Error para la carga de archivos -------
	Error5:
		print saltolinea
		print err5
		getChar
		jmp menu
    ;---------- Carga de Archivos ---------------------
    carga_archivos:
        mov tamanio[0],0
        print saltolinea
		print ingreseruta
		print saltolinea
        limpiar bufferentrada1, SIZEOF bufferentrada1,24h
        limpiar Vec_Original, SIZEOF Vec_Original,24h
        limpiar Vec_Actual, SIZEOF Vec_Original,24h
		obtenerRuta bufferentrada1
		abrir bufferentrada1,handlerentrada1  ;le mandamos la ruta y el handler,que será la referencia al fichero 
		limpiar bufferInformacion1, SIZEOF bufferInformacion1,24h  ;limpiamos la variable donde guardaremos los datos del archivo 
		leer handlerentrada1, bufferInformacion1, SIZEOF bufferInformacion1 ;leemos el archivo 
        ;print bufferInformacion1
        xor si,si
        xor di,di
        jmp Encontrar_Mayor_inicial

    ;---------- Encuentra el primer > de la 1er etiqueta ----
    Encontrar_Mayor_inicial:
        mov al, bufferInformacion1[si]
        cmp al,62 ; Encuentra el > en los caracteres
            je EsNumero
        inc si
        jmp Encontrar_Mayor_inicial
    ;---------- Encuentra el primer > de cualquier etiqueta ----
    Encontrar_Mayor:
        mov al, bufferInformacion1[si]
        cmp al,62 ; Encuentra el > en los caracteres
            je EsNumero
        cmp al,83 ; Encuentra el S en los caracteres
            je Carga_exito
        cmp al,115 ; Encuentra el s en los caracteres
            je Carga_exito
        inc si
        jmp Encontrar_Mayor

    ;---------- Determina si el contenido es un numero ----
    EsNumero:
        inc si 
        mov al, bufferInformacion1[si]
        cmp al,48
            jl Encontrar_Mayor
        cmp al,57
            jg Encontrar_Mayor
        jmp Capturar_Numero

    ;---------- Si es un Numero Captura su valor ----------
    Capturar_Numero:
        mov NumTemp[0],al
        inc si 
        mov al, bufferInformacion1[si]
        ;mov Debug[0],al
        ;print Debug
        cmp al,48
            jl Un_digito
        cmp al,57
            jg Un_digito
        jmp dos_digitos

    ;---------- Numero de un solo digito ------------------
    Un_digito:
        mov al, NumTemp[0] ;Obtenemos el primer numero numero en ascii de la cadena
        sub al,30h ;Le restamos 0 para obtener su numero digital
        mov Vec_Original[di], al ;Se agrega al vector original
        IncContador tamanio
        inc di
        inc si
        ;print Vec_Original
        ;print saltolinea
        jmp Encontrar_Mayor

    ;---------- Numero de dos digitos ---------------------
    dos_digitos:
        mov NumTemp[1],al 
        mov al, NumTemp[0] ;Obtenemos el primer numero numero en ascii de la cadena
        sub al,30h ;Le restamos 0 para obtener su numero digital
        mov bl,10 ;guardamos el valor de 10 en bl
        mul bl ;Lo multiplicamos por 10 por se decenas
        mov temp[0],al ; por ultimo guardamos las decenas en temp[0]

        mov al, NumTemp[1] ;obtenemos el segundo numero en ascii de la cadena
        sub al, 30h ;le restamos 0 para obtener su numero digital
        mov bl,temp[0] ;movemos las decenas a bl
        add al,bl ;y sumamos las decenas con las unidades
        mov Vec_Original[di], al ;Se agrega al vector original
        IncContador tamanio
        inc di
        inc si
        ;print Vec_Original
        ;print saltolinea
        jmp Encontrar_Mayor

    ;---------- Mensaje de que se cargo con exito ----------
    Carga_exito:
        ;print Vec_Original
        print SeCargoExito
        print saltolinea
        ;NumToAscii tamanio
        jmp menu
    
    ;---------- Termina el programa ------------------------
    salir:
		close
main endp

Determinar_Color proc
    mov al, Vec_Actual[si]
    cmp al,21
        jl Rojo
    cmp al,41
        jl Azul
    cmp al,61
        jl Amarillo
    cmp al,81
        jl Verde
    jmp Blaco

    Rojo:
        mov Color_Barra,04h
        jmp fin
    Azul:
        mov Color_Barra,01h
        jmp fin
    Amarillo:
        mov Color_Barra,0Eh
        jmp fin
    Verde:
        mov Color_Barra,02h
        jmp fin
    Blaco:
        mov Color_Barra,0Fh
        jmp fin
    fin: 
        ret
Determinar_Color endp


Pintar_10Barra proc
    Push si
    push di
    xor si,si 
    xor di,di

    mov temp[0],0
    mov cx, 35d    ; Columna        
    mov dx, 170d    ; fila
    
    Master:
        mov al,Vec_Actual[si]
        mov bl, 145
        mul bl
        mov bl, 100
        div bl
        mov Alto_Barra[0], al
        mov Alto_Acutal[0], 0d

        call Determinar_Color

        Ciclo1:
        mov dx, 170d
        mov Alto_Acutal[0], 0d

            Ciclo2:
            mov al, Color_Barra
            mov ah, 0ch 
            int 10h
            sub dx,1
            IncContador Alto_Acutal
            
            xor ax,ax
            mov al, Alto_Acutal[0]
            cmp al,Alto_Barra[0]
                jne Ciclo2

            inc di
            inc cx 
            cmp di,35d
                je Proximo
            jmp Ciclo1

    Proximo:
        mov Espacio_Barra[0],0
        xor di,di
        mover:
            IncContador Espacio_Barra
            inc cx
            mov al, Espacio_Barra[0]
            cmp al,22d
                jl mover 

        inc si
        IncContador temp
        mov al,temp[0]
        cmp al,tamanio[0]
        	je fin
        jmp Master

    fin:
        xor si,si 
        xor di,di
        pop di
        pop si
        ret 
Pintar_10Barra endp

Pintar_11Barra proc
    Push si
    push di
    xor si,si 
    xor di,di

    mov temp[0],0
    mov cx, 25d    ; Columna        
    mov dx, 170d    ; fila
    
    Master:
        mov al,Vec_Actual[si]
        mov bl, 145
        mul bl
        mov bl, 100
        div bl
        mov Alto_Barra[0], al
        mov Alto_Acutal[0], 0d

        call Determinar_Color

        Ciclo1:
        mov dx, 170d
        mov Alto_Acutal[0], 0d

            Ciclo2:
            mov al, Color_Barra
            mov ah, 0ch 
            int 10h
            sub dx,1
            IncContador Alto_Acutal
            
            xor ax,ax
            mov al, Alto_Acutal[0]
            cmp al,Alto_Barra[0]
                jne Ciclo2

            inc di
            inc cx 
            cmp di,35d
                je Proximo
            jmp Ciclo1

    Proximo:
        mov Espacio_Barra[0],0
        xor di,di
        mover:
            IncContador Espacio_Barra
            inc cx
            mov al, Espacio_Barra[0]
            cmp al,20d
                jl mover 

        inc si
        IncContador temp
        mov al,temp[0]
        cmp al,tamanio[0]
        	je fin
        jmp Master

    fin:
        xor si,si 
        xor di,di
        pop di
        pop si
        ret 
Pintar_11Barra endp

Pintar_12Barra proc
    Push si
    push di
    xor si,si 
    xor di,di

    mov temp[0],0
    mov cx, 43d    ; Columna        
    mov dx, 170d    ; fila
    
    Master:
        mov al,Vec_Actual[si]
        mov bl, 145
        mul bl
        mov bl, 100
        div bl
        mov Alto_Barra[0], al
        mov Alto_Acutal[0], 0d

        call Determinar_Color

        Ciclo1:
        mov dx, 170d
        mov Alto_Acutal[0], 0d

            Ciclo2:
            mov al, Color_Barra
            mov ah, 0ch 
            int 10h
            sub dx,1
            IncContador Alto_Acutal
            
            xor ax,ax
            mov al, Alto_Acutal[0]
            cmp al,Alto_Barra[0]
                jne Ciclo2

            inc di
            inc cx 
            cmp di,28d
                je Proximo
            jmp Ciclo1

    Proximo:
        mov Espacio_Barra[0],0
        xor di,di
        mover:
            IncContador Espacio_Barra
            inc cx
            mov al, Espacio_Barra[0]
            cmp al,19d
                jl mover 

        inc si
        IncContador temp
        mov al,temp[0]
        cmp al,tamanio[0]
        	je fin
        jmp Master

    fin:
        xor si,si 
        xor di,di
        pop di
        pop si
        ret 
Pintar_12Barra endp

Pintar_13Barra proc
    Push si
    push di
    xor si,si 
    xor di,di

    mov temp[0],0
    mov cx, 18d    ; Columna        
    mov dx, 170d    ; fila
    
    Master:
        mov al,Vec_Actual[si]
        mov bl, 145
        mul bl
        mov bl, 100
        div bl
        mov Alto_Barra[0], al
        mov Alto_Acutal[0], 0d

        call Determinar_Color

        Ciclo1:
        mov dx, 170d
        mov Alto_Acutal[0], 0d

            Ciclo2:
            mov al, Color_Barra
            mov ah, 0ch 
            int 10h
            sub dx,1
            IncContador Alto_Acutal
            
            xor ax,ax
            mov al, Alto_Acutal[0]
            cmp al,Alto_Barra[0]
                jne Ciclo2

            inc di
            inc cx 
            cmp di,29d
                je Proximo
            jmp Ciclo1

    Proximo:
        mov Espacio_Barra[0],0
        xor di,di
        mover:
            IncContador Espacio_Barra
            inc cx
            mov al, Espacio_Barra[0]
            cmp al,19d
                jl mover 

        inc si
        IncContador temp
        mov al,temp[0]
        cmp al,tamanio[0]
        	je fin
        jmp Master

    fin:
        xor si,si 
        xor di,di
        pop di
        pop si
        ret 
Pintar_13Barra endp

Pintar_14Barra proc
    Push si
    push di
    xor si,si 
    xor di,di

    mov temp[0],0
    mov cx, 43d    ; Posicion inicial columna        
    mov dx, 170d    ; fila
    
    Master:
        mov al,Vec_Actual[si]
        mov bl, 145
        mul bl
        mov bl, 100
        div bl
        mov Alto_Barra[0], al
        mov Alto_Acutal[0], 0d

        call Determinar_Color

        Ciclo1:
        mov dx, 170d
        mov Alto_Acutal[0], 0d

            Ciclo2:
            mov al, Color_Barra
            mov ah, 0ch 
            int 10h
            sub dx,1
            IncContador Alto_Acutal
            
            xor ax,ax
            mov al, Alto_Acutal[0]
            cmp al,Alto_Barra[0]
                jne Ciclo2

            inc di
            inc cx 
            cmp di,25d ; Tamaño de las barras
                je Proximo
            jmp Ciclo1

    Proximo:
        mov Espacio_Barra[0],0
        xor di,di
        mover:
            IncContador Espacio_Barra
            inc cx
            mov al, Espacio_Barra[0]
            cmp al,15d ; Separacion entre barras
                jl mover 

        inc si
        IncContador temp
        mov al,temp[0]
        cmp al,tamanio[0]
        	je fin
        jmp Master

    fin:
        xor si,si 
        xor di,di
        pop di
        pop si
        ret 
Pintar_14Barra endp

Pintar_15Barra proc
    Push si
    push di
    xor si,si 
    xor di,di

    mov temp[0],0
    mov cx, 30d    ; Posicion inicial columna        
    mov dx, 170d    ; fila
    
    Master:
        mov al,Vec_Actual[si]
        mov bl, 145
        mul bl
        mov bl, 100
        div bl
        mov Alto_Barra[0], al
        mov Alto_Acutal[0], 0d

        call Determinar_Color

        Ciclo1:
        mov dx, 170d
        mov Alto_Acutal[0], 0d

            Ciclo2:
            mov al, Color_Barra
            mov ah, 0ch 
            int 10h
            sub dx,1
            IncContador Alto_Acutal
            
            xor ax,ax
            mov al, Alto_Acutal[0]
            cmp al,Alto_Barra[0]
                jne Ciclo2

            inc di
            inc cx 
            cmp di,25d ; Tamaño de las barras
                je Proximo
            jmp Ciclo1

    Proximo:
        mov Espacio_Barra[0],0
        xor di,di
        mover:
            IncContador Espacio_Barra
            inc cx
            mov al, Espacio_Barra[0]
            cmp al,15d ; Separacion entre barras
                jl mover 

        inc si
        IncContador temp
        mov al,temp[0]
        cmp al,tamanio[0]
        	je fin
        jmp Master

    fin:
        xor si,si 
        xor di,di
        pop di
        pop si
        ret 
Pintar_15Barra endp

Pintar_16Barra proc
    Push si
    push di
    xor si,si 
    xor di,di

    mov temp[0],0
    mov cx, 15d    ; Posicion inicial columna        
    mov dx, 170d    ; fila
    
    Master:
        mov al,Vec_Actual[si]
        mov bl, 145
        mul bl
        mov bl, 100
        div bl
        mov Alto_Barra[0], al
        mov Alto_Acutal[0], 0d

        call Determinar_Color

        Ciclo1:
        mov dx, 170d
        mov Alto_Acutal[0], 0d

            Ciclo2:
            mov al, Color_Barra
            mov ah, 0ch 
            int 10h
            sub dx,1
            IncContador Alto_Acutal
            
            xor ax,ax
            mov al, Alto_Acutal[0]
            cmp al,Alto_Barra[0]
                jne Ciclo2

            inc di
            inc cx 
            cmp di,28d ; Tamaño de las barras
                je Proximo
            jmp Ciclo1

    Proximo:
        mov Espacio_Barra[0],0
        xor di,di
        mover:
            IncContador Espacio_Barra
            inc cx
            mov al, Espacio_Barra[0]
            cmp al,11d ; Separacion entre barras
                jl mover 

        inc si
        IncContador temp
        mov al,temp[0]
        cmp al,tamanio[0]
        	je fin
        jmp Master

    fin:
        xor si,si 
        xor di,di
        pop di
        pop si
        ret 
Pintar_16Barra endp

Pintar_17Barra proc
    Push si
    push di
    xor si,si 
    xor di,di

    mov temp[0],0
    mov cx, 57d    ; Posicion inicial columna        
    mov dx, 170d    ; fila
    
    Master:
        mov al,Vec_Actual[si]
        mov bl, 145
        mul bl
        mov bl, 100
        div bl
        mov Alto_Barra[0], al
        mov Alto_Acutal[0], 0d

        call Determinar_Color

        Ciclo1:
        mov dx, 170d
        mov Alto_Acutal[0], 0d

            Ciclo2:
            mov al, Color_Barra
            mov ah, 0ch 
            int 10h
            sub dx,1
            IncContador Alto_Acutal
            
            xor ax,ax
            mov al, Alto_Acutal[0]
            cmp al,Alto_Barra[0]
                jne Ciclo2

            inc di
            inc cx 
            cmp di,18d ; Tamaño de las barras
                je Proximo
            jmp Ciclo1

    Proximo:
        mov Espacio_Barra[0],0
        xor di,di
        mover:
            IncContador Espacio_Barra
            inc cx
            mov al, Espacio_Barra[0]
            cmp al,14d ; Separacion entre barras
                jl mover 

        inc si
        IncContador temp
        mov al,temp[0]
        cmp al,tamanio[0]
        	je fin
        jmp Master

    fin:
        xor si,si 
        xor di,di
        pop di
        pop si
        ret 
Pintar_17Barra endp

Pintar_18Barra proc
    Push si
    push di
    xor si,si 
    xor di,di

    mov temp[0],0
    mov cx, 35d    ; Posicion inicial columna        
    mov dx, 170d    ; fila
    
    Master:
        mov al,Vec_Actual[si]
        mov bl, 145
        mul bl
        mov bl, 100
        div bl
        mov Alto_Barra[0], al
        mov Alto_Acutal[0], 0d

        call Determinar_Color

        Ciclo1:
        mov dx, 170d
        mov Alto_Acutal[0], 0d

            Ciclo2:
            mov al, Color_Barra
            mov ah, 0ch 
            int 10h
            sub dx,1
            IncContador Alto_Acutal
            
            xor ax,ax
            mov al, Alto_Acutal[0]
            cmp al,Alto_Barra[0]
                jne Ciclo2

            inc di
            inc cx 
            cmp di,18d ; Tamaño de las barras
                je Proximo
            jmp Ciclo1

    Proximo:
        mov Espacio_Barra[0],0
        xor di,di
        mover:
            IncContador Espacio_Barra
            inc cx
            mov al, Espacio_Barra[0]
            cmp al,14d ; Separacion entre barras
                jl mover 

        inc si
        IncContador temp
        mov al,temp[0]
        cmp al,tamanio[0]
        	je fin
        jmp Master

    fin:
        xor si,si 
        xor di,di
        pop di
        pop si
        ret 
Pintar_18Barra endp

Pintar_19Barra proc
    Push si
    push di
    xor si,si 
    xor di,di

    mov temp[0],0
    mov cx, 24d    ; Posicion inicial columna        
    mov dx, 170d    ; fila
    
    Master:
        mov al,Vec_Actual[si]
        mov bl, 145
        mul bl
        mov bl, 100
        div bl
        mov Alto_Barra[0], al
        mov Alto_Acutal[0], 0d

        call Determinar_Color

        Ciclo1:
        mov dx, 170d
        mov Alto_Acutal[0], 0d

            Ciclo2:
            mov al, Color_Barra
            mov ah, 0ch 
            int 10h
            sub dx,1
            IncContador Alto_Acutal
            
            xor ax,ax
            mov al, Alto_Acutal[0]
            cmp al,Alto_Barra[0]
                jne Ciclo2

            inc di
            inc cx 
            cmp di,18d ; Tamaño de las barras
                je Proximo
            jmp Ciclo1

    Proximo:
        mov Espacio_Barra[0],0
        xor di,di
        mover:
            IncContador Espacio_Barra
            inc cx
            mov al, Espacio_Barra[0]
            cmp al,14d ; Separacion entre barras
                jl mover 

        inc si
        IncContador temp
        mov al,temp[0]
        cmp al,tamanio[0]
        	je fin
        jmp Master

    fin:
        xor si,si 
        xor di,di
        pop di
        pop si
        ret 
Pintar_19Barra endp

Pintar_20Barra proc
    Push si
    push di
    xor si,si 
    xor di,di

    mov temp[0],0
    mov cx, 75d    ; Posicion inicial columna        
    mov dx, 170d    ; fila
    
    Master:
        mov al,Vec_Actual[si]
        mov bl, 145
        mul bl
        mov bl, 100
        div bl
        mov Alto_Barra[0], al
        mov Alto_Acutal[0], 0d

        call Determinar_Color

        Ciclo1:
        mov dx, 170d
        mov Alto_Acutal[0], 0d

            Ciclo2:
            mov al, Color_Barra
            mov ah, 0ch 
            int 10h
            sub dx,1
            IncContador Alto_Acutal
            
            xor ax,ax
            mov al, Alto_Acutal[0]
            cmp al,Alto_Barra[0]
                jne Ciclo2

            inc di
            inc cx 
            cmp di,14d ; Tamaño de las barras
                je Proximo
            jmp Ciclo1

    Proximo:
        mov Espacio_Barra[0],0
        xor di,di
        mover:
            IncContador Espacio_Barra
            inc cx
            mov al, Espacio_Barra[0]
            cmp al,10d ; Separacion entre barras
                jl mover 

        inc si
        IncContador temp
        mov al,temp[0]
        cmp al,tamanio[0]
        	je fin
        jmp Master

    fin:
        xor si,si 
        xor di,di
        pop di
        pop si
        ret 
Pintar_20Barra endp

Pintar_21Barra proc
    Push si
    push di
    xor si,si 
    xor di,di

    mov temp[0],0
    mov cx, 56d    ; Posicion inicial columna        
    mov dx, 170d    ; fila
    
    Master:
        mov al,Vec_Actual[si]
        mov bl, 145
        mul bl
        mov bl, 100
        div bl
        mov Alto_Barra[0], al
        mov Alto_Acutal[0], 0d

        call Determinar_Color

        Ciclo1:
        mov dx, 170d
        mov Alto_Acutal[0], 0d

            Ciclo2:
            mov al, Color_Barra
            mov ah, 0ch 
            int 10h
            sub dx,1
            IncContador Alto_Acutal
            
            xor ax,ax
            mov al, Alto_Acutal[0]
            cmp al,Alto_Barra[0]
                jne Ciclo2

            inc di
            inc cx 
            cmp di,14d ; Tamaño de las barras
                je Proximo
            jmp Ciclo1

    Proximo:
        mov Espacio_Barra[0],0
        xor di,di
        mover:
            IncContador Espacio_Barra
            inc cx
            mov al, Espacio_Barra[0]
            cmp al,10d ; Separacion entre barras
                jl mover 

        inc si
        IncContador temp
        mov al,temp[0]
        cmp al,tamanio[0]
        	je fin
        jmp Master

    fin:
        xor si,si 
        xor di,di
        pop di
        pop si
        ret 
Pintar_21Barra endp

Pintar_22Barra proc
    Push si
    push di
    xor si,si 
    xor di,di

    mov temp[0],0
    mov cx, 48d    ; Posicion inicial columna        
    mov dx, 170d    ; fila
    
    Master:
        mov al,Vec_Actual[si]
        mov bl, 145
        mul bl
        mov bl, 100
        div bl
        mov Alto_Barra[0], al
        mov Alto_Acutal[0], 0d

        call Determinar_Color

        Ciclo1:
        mov dx, 170d
        mov Alto_Acutal[0], 0d

            Ciclo2:
            mov al, Color_Barra
            mov ah, 0ch 
            int 10h
            sub dx,1
            IncContador Alto_Acutal
            
            xor ax,ax
            mov al, Alto_Acutal[0]
            cmp al,Alto_Barra[0]
                jne Ciclo2

            inc di
            inc cx 
            cmp di,14d ; Tamaño de las barras
                je Proximo
            jmp Ciclo1

    Proximo:
        mov Espacio_Barra[0],0
        xor di,di
        mover:
            IncContador Espacio_Barra
            inc cx
            mov al, Espacio_Barra[0]
            cmp al,10d ; Separacion entre barras
                jl mover 

        inc si
        IncContador temp
        mov al,temp[0]
        cmp al,tamanio[0]
        	je fin
        jmp Master

    fin:
        xor si,si 
        xor di,di
        pop di
        pop si
        ret 
Pintar_22Barra endp

Pintar_23Barra proc
    Push si
    push di
    xor si,si 
    xor di,di

    mov temp[0],0
    mov cx, 38d    ; Posicion inicial columna        
    mov dx, 170d    ; fila
    
    Master:
        mov al,Vec_Actual[si]
        mov bl, 145
        mul bl
        mov bl, 100
        div bl
        mov Alto_Barra[0], al
        mov Alto_Acutal[0], 0d

        call Determinar_Color

        Ciclo1:
        mov dx, 170d
        mov Alto_Acutal[0], 0d

            Ciclo2:
            mov al, Color_Barra
            mov ah, 0ch 
            int 10h
            sub dx,1
            IncContador Alto_Acutal
            
            xor ax,ax
            mov al, Alto_Acutal[0]
            cmp al,Alto_Barra[0]
                jne Ciclo2

            inc di
            inc cx 
            cmp di,14d ; Tamaño de las barras
                je Proximo
            jmp Ciclo1

    Proximo:
        mov Espacio_Barra[0],0
        xor di,di
        mover:
            IncContador Espacio_Barra
            inc cx
            mov al, Espacio_Barra[0]
            cmp al,10d ; Separacion entre barras
                jl mover 

        inc si
        IncContador temp
        mov al,temp[0]
        cmp al,tamanio[0]
        	je fin
        jmp Master

    fin:
        xor si,si 
        xor di,di
        pop di
        pop si
        ret 
Pintar_23Barra endp

Pintar_24Barra proc
    Push si
    push di
    xor si,si 
    xor di,di

    mov temp[0],0
    mov cx, 32d    ; Posicion inicial columna        
    mov dx, 170d    ; fila
    
    Master:
        mov al,Vec_Actual[si]
        mov bl, 145
        mul bl
        mov bl, 100
        div bl
        mov Alto_Barra[0], al
        mov Alto_Acutal[0], 0d

        call Determinar_Color

        Ciclo1:
        mov dx, 170d
        mov Alto_Acutal[0], 0d

            Ciclo2:
            mov al, Color_Barra
            mov ah, 0ch 
            int 10h
            sub dx,1
            IncContador Alto_Acutal
            
            xor ax,ax
            mov al, Alto_Acutal[0]
            cmp al,Alto_Barra[0]
                jne Ciclo2

            inc di
            inc cx 
            cmp di,14d ; Tamaño de las barras
                je Proximo
            jmp Ciclo1

    Proximo:
        mov Espacio_Barra[0],0
        xor di,di
        mover:
            IncContador Espacio_Barra
            inc cx
            mov al, Espacio_Barra[0]
            cmp al,10d ; Separacion entre barras
                jl mover 

        inc si
        IncContador temp
        mov al,temp[0]
        cmp al,tamanio[0]
        	je fin
        jmp Master

    fin:
        xor si,si 
        xor di,di
        pop di
        pop si
        ret 
Pintar_24Barra endp

Pintar_25Barra proc
    Push si
    push di
    xor si,si 
    xor di,di

    mov temp[0],0
    mov cx, 25d    ; Posicion inicial columna        
    mov dx, 170d    ; fila
    
    Master:
        mov al,Vec_Actual[si]
        mov bl, 145
        mul bl
        mov bl, 100
        div bl
        mov Alto_Barra[0], al
        mov Alto_Acutal[0], 0d

        call Determinar_Color

        Ciclo1:
        mov dx, 170d
        mov Alto_Acutal[0], 0d

            Ciclo2:
            mov al, Color_Barra
            mov ah, 0ch 
            int 10h
            sub dx,1
            IncContador Alto_Acutal
            
            xor ax,ax
            mov al, Alto_Acutal[0]
            cmp al,Alto_Barra[0]
                jne Ciclo2

            inc di
            inc cx 
            cmp di,14d ; Tamaño de las barras
                je Proximo
            jmp Ciclo1

    Proximo:
        mov Espacio_Barra[0],0
        xor di,di
        mover:
            IncContador Espacio_Barra
            inc cx
            mov al, Espacio_Barra[0]
            cmp al,10d ; Separacion entre barras
                jl mover 

        inc si
        IncContador temp
        mov al,temp[0]
        cmp al,tamanio[0]
        	je fin
        jmp Master

    fin:
        xor si,si 
        xor di,di
        pop di
        pop si
        ret 
Pintar_25Barra endp

;-------------- Determina el espacio entre numeros ---------
Determinar_espacio_Num proc
    xor ax,ax
    mov al, tamanio[0]
    cmp al,10
        je Espacio10
    cmp al,11
        je Espacio11
    cmp al,12
        je Espacio12
    cmp al,13
        je Espacio13
    cmp al,14
        je Espacio14
    cmp al,15
        je Espacio15
    cmp al,16
        je Espacio16
    cmp al,17
        je Espacio17
    cmp al,18
        je Espacio18
    cmp al,19
        je Espacio19
    cmp al,20
        je Espacio20
    cmp al,21
        je Espacio21
    cmp al,22
        je Espacio22
    cmp al,23
        je Espacio23
    cmp al,24
        je Espacio24
    cmp al,25
        je Espacio25

    Espacio10:
        mov Espacio_Vector[0],7
        mov Fila, 22    
        mov Columna, -1
        mov al,Columna
        mov Columna_Actual,al ;Guardamos la fila actual
        jmp fin

    Espacio11:
        mov Espacio_Vector[0],7
        mov Fila, 22    
        mov Columna, -3
        mov al,Columna
        mov Columna_Actual,al ;Guardamos la fila actual
        jmp fin
    
    Espacio12:
        mov Espacio_Vector[0],6
        mov Fila, 22    
        mov Columna, 0
        mov al,Columna
        mov Columna_Actual,al ;Guardamos la fila actual
        jmp fin

    Espacio13:
        mov Espacio_Vector[0],6
        mov Fila, 22    
        mov Columna, -3
        mov al,Columna
        mov Columna_Actual,al ;Guardamos la fila actual
        jmp fin

    Espacio14:
        mov Espacio_Vector[0],5
        mov Fila, 22    
        mov Columna, 1
        mov al,Columna
        mov Columna_Actual,al ;Guardamos la fila actual
        jmp fin
    
    Espacio15:
        mov Espacio_Vector[0],5
        mov Fila, 22    
        mov Columna, -1
        mov al,Columna
        mov Columna_Actual,al ;Guardamos la fila actual
        jmp fin
    
    Espacio16:
        mov Espacio_Vector[0],5
        mov Fila, 22    
        mov Columna, -3
        mov al,Columna
        mov Columna_Actual,al ;Guardamos la fila actual
        jmp fin
    
    Espacio17:
        mov Espacio_Vector[0],4
        mov Fila, 22    
        mov Columna, 3
        mov al,Columna
        mov Columna_Actual,al ;Guardamos la fila actual
        jmp fin

    Espacio18:
        mov Espacio_Vector[0],4
        mov Fila, 22    
        mov Columna, 1
        mov al,Columna
        mov Columna_Actual,al ;Guardamos la fila actual
        jmp fin

    Espacio19:
        mov Espacio_Vector[0],4
        mov Fila, 22    
        mov Columna, -1
        mov al,Columna
        mov Columna_Actual,al ;Guardamos la fila actual
        jmp fin

    Espacio20:
        mov Espacio_Vector[0],3
        mov Fila, 22    
        mov Columna, 6
        mov al,Columna
        mov Columna_Actual,al ;Guardamos la fila actual
        jmp fin
        
    Espacio21:
        mov Espacio_Vector[0],3
        mov Fila, 22    
        mov Columna, 4
        mov al,Columna
        mov Columna_Actual,al ;Guardamos la fila actual
        jmp fin

    Espacio22:
        mov Espacio_Vector[0],3
        mov Fila, 22    
        mov Columna, 3
        mov al,Columna
        mov Columna_Actual,al ;Guardamos la fila actual
        jmp fin

    Espacio23:
        mov Espacio_Vector[0],3
        mov Fila, 22    
        mov Columna, 2
        mov al,Columna
        mov Columna_Actual,al ;Guardamos la fila actual
        jmp fin

    Espacio24:
        mov Espacio_Vector[0],3
        mov Fila, 22    
        mov Columna, 1
        mov al,Columna
        mov Columna_Actual,al ;Guardamos la fila actual
        jmp fin

    Espacio25:
        mov Espacio_Vector[0],3
        mov Fila, 22    
        mov Columna, 0
        mov al,Columna
        mov Columna_Actual,al ;Guardamos la fila actual
        jmp fin
    
    fin:
        ret 
Determinar_espacio_Num endp

Pintar_Barras proc
    xor ax,ax
    mov al, tamanio[0]
    cmp al,10
        je Espacio10
    cmp al,11
        je Espacio11
    cmp al,12
        je Espacio12
    cmp al,13
        je Espacio13
    cmp al,14
        je Espacio14
    cmp al,15
        je Espacio15
    cmp al,16
        je Espacio16
    cmp al,17
        je Espacio17
    cmp al,18
        je Espacio18
    cmp al,19
        je Espacio19
    cmp al,20
        je Espacio20
    cmp al,21
        je Espacio21
    cmp al,22
        je Espacio22
    cmp al,23
        je Espacio23
    cmp al,24
        je Espacio24
    cmp al,25
        je Espacio25

    Espacio10:
        call Pintar_10Barra
        jmp fin
    Espacio11:
        call Pintar_11Barra
        jmp fin
    
    Espacio12:
        call Pintar_12Barra
        jmp fin

    Espacio13:
        call Pintar_13Barra
        jmp fin

    Espacio14:
        call Pintar_14Barra
        jmp fin
    
    Espacio15:
        call Pintar_15Barra
        jmp fin
    
    Espacio16:
        call Pintar_16Barra
        jmp fin
    
    Espacio17:
        call Pintar_17Barra
        jmp fin

    Espacio18:
        call Pintar_18Barra
        jmp fin

    Espacio19:
        call Pintar_19Barra
        jmp fin

    Espacio20:
        call Pintar_20Barra
        jmp fin
        
    Espacio21:
        call Pintar_21Barra
        jmp fin

    Espacio22:
        call Pintar_22Barra
        jmp fin

    Espacio23:
        call Pintar_23Barra
        jmp fin

    Espacio24:
        call Pintar_24Barra
        jmp fin

    Espacio25:
        call Pintar_25Barra
        jmp fin
    
    fin:
        ret 
Pintar_Barras endp

;-------------- Pintar Vector Burbuja ----------------------
Pintar_Vector proc
    xor ax,ax
    xor bx,bx
    xor si,si
    xor cx,cx

    call Determinar_espacio_Num
    mov cl,tamanio[0]
    Ciclo:
        mov Fila, 22
        mov al,Columna_Actual
        mov bl,Espacio_Vector[0]
        add al,bl
        mov Columna_Actual,al
        mov Columna,al
        call Set_Cursor
          
        mov al, Vec_Actual[si]
        mov Num_vector[0],al

        NumToAscii Num_vector
        inc si
    loop Ciclo
    ret
Pintar_Vector endp

;-------------- Inicia modo Video --------------------------
INI_VIDEO proc
	mov ax, 00Eh
	int 10h
	ret
INI_VIDEO endp

;-------------- Fin modo Video -----------------------------
FIN_VIDEO proc
	mov ax, 0003h
	int 10h
	ret
FIN_VIDEO endp

;-------------- Posicionar el Cursor -----------------------
Set_Cursor proc
        xor ax,ax
		xor bx,bx
		mov ah, 02
		mov bh, 00
        xor dx,dx
		mov dl, Columna ; columnas
		mov dh, Fila ; filas
		int 10h
		xor ax,ax
		xor bx,bx
		xor dx,dx
        ret
Set_Cursor endp

;-------------- Pendiente ----------------------------------
Quicksort_Ascendente proc

    DoWhile: 
        MoverSi from
        mov al, Vec_Quick[si]
        mov matrix_from[0],al ; Se obtiene el valor de matrix[from]
        cmp al,pivot[0]
            jb Ciclo1

        MoverSi to
        mov al,Vec_Quick[si]    
        mov matrix_to[0],al
        cmp al,pivot[0] ; Se obtiene el valor de matrix[to]
            ja Ciclo2

        jmp condicion_if   

    Ciclo1: 
        mov al,from[0]
        mov bl,1
        add al,bl
        mov from[0],al ; from++
        
        MoverSi from
        mov al,Vec_Quick[si]
        mov matrix_from[0],al ;Se actualiza matriz[from]
        cmp al,pivot[0] ; (matrix[from] < pivot)
            jb Ciclo1
        
        MoverSi to
        mov al,Vec_Quick[si]    
        mov matrix_to[0],al ; Se obtiene el valor de matrix[to]
        cmp al,pivot[0] ; (matrix[to] > pivot)
            ja Ciclo2
        
        jmp condicion_if

    Ciclo2:
        mov al,to[0]
        mov bl,1
        sub al,bl
        mov to[0],al ; to--

        MoverSi to
        mov al,Vec_Quick[si]    
        mov matrix_to[0],al
        cmp al,pivot[0] ;While(matrix[to] > pivot)
            ja Ciclo2
        jmp condicion_if

    condicion_if:
        mov al,from[0]
        cmp al,to[0]
            jbe accion_if
        jmp condicion_DoWhile
       
    accion_if:
        MoverSi from
        mov al,Vec_Quick[si]
        mov matrix_from[0],al; actualizo matrix[from]

        MoverSi to
        mov al,Vec_Quick[si]
        mov matrix_to[0],al; actualizo matrix[to]

        mov al,matrix_from[0]
        mov buf[0],al ;buf = matrix[from];

        MoverSi from
        mov al,matrix_to[0]
        mov Vec_Quick[si],al ; matrix[from] = matrix[to];

        MoverSi to
        mov al,buf[0]
        mov Vec_Quick[si],al ; matrix[to] = buf;

        mov al,from[0]
        mov bl,1
        add al,bl
        mov from[0],al ; from++

        mov al,to[0]
        mov bl,1
        sub al,bl
        mov to[0],al ; to--

        MoverSi from
        mov al,Vec_Quick[si]
        mov matrix_from[0],al; actualizo matrix[from]

        MoverSi to
        mov al,Vec_Quick[si]
        mov matrix_to[0],al; actualizo matrix[to]

        jmp condicion_DoWhile

    condicion_DoWhile:
        mov al,from[0]
        cmp al,to[0]
            jbe DoWhile
        jmp fin
    fin:
        ret
Quicksort_Ascendente endp
end main