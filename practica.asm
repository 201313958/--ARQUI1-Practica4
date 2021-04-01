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
Vec_Bubble db 50 dup('$')
Vec_Quick db 50 dup('$')
Vec_Shell db 50 dup('$')
cadena_Ordenado db 0ah,0dh, 'Se ordeno correctamente', '$'
tamanio db 2 dup('$')
tamanio_1 db 2 dup('$')
Count db 2 dup('$')
i db 2 dup('$')
j db 2 dup('$')

;ordenamiento burbuja
vecJ db 2 dup('$')
vecJmas1 db 2 dup('$')

;Delay
tiempo db 2 dup('$')

.code
mov dx,@data
mov ds,dx

main proc
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

    ASC_Bubblesort:
        print saltolinea
        Bubblesort_Ascendente Vec_Bubble
        jmp menu

    DES_Bubblesort:
        print saltolinea
        Bubblesort_Descendente Vec_Bubble
        jmp menu

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
    
    ASC_Quicksort:
        jmp menu
    DES_Quicksort:
        jmp menu

    Shellsort:
        print cadena_velocidad ;Determinamos la velocidad de la simulacion
        print saltolinea
        getChar
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

    ASC_Shellsort:
        jmp menu
    DES_Shellsort:
        jmp menu

    Error1:
		print saltolinea
		print err1
		getChar
		jmp menu
	
	Error5:
		print saltolinea
		print err5
		getChar
		jmp menu
    
    carga_archivos:
        mov tamanio[0],0
        print saltolinea
		print ingreseruta
		print saltolinea
        limpiar bufferentrada1, SIZEOF bufferentrada1,24h
        limpiar Vec_Original, SIZEOF Vec_Original,24h
        limpiar Vec_Bubble, SIZEOF Vec_Original,24h
        limpiar Vec_Quick, SIZEOF Vec_Original,24h
        limpiar Vec_Shell, SIZEOF Vec_Original,24h
		obtenerRuta bufferentrada1
		abrir bufferentrada1,handlerentrada1  ;le mandamos la ruta y el handler,que será la referencia al fichero 
		limpiar bufferInformacion1, SIZEOF bufferInformacion1,24h  ;limpiamos la variable donde guardaremos los datos del archivo 
		leer handlerentrada1, bufferInformacion1, SIZEOF bufferInformacion1 ;leemos el archivo 
        ;print bufferInformacion1
        xor si,si
        xor di,di
        jmp Encontrar_Mayor_inicial
    
    Encontrar_Mayor_inicial:
    mov al, bufferInformacion1[si]
    cmp al,62 ; Encuentra el > en los caracteres
        je EsNumero
    inc si
    jmp Encontrar_Mayor_inicial

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

    EsNumero:
        inc si 
        mov al, bufferInformacion1[si]
        cmp al,48
            jl Encontrar_Mayor
        cmp al,57
            jg Encontrar_Mayor
        jmp Capturar_Numero
    
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

    Un_digito:
        mov al, NumTemp[0] ;Obtenemos el primer numero numero en ascii de la cadena
        sub al,30h ;Le restamos 0 para obtener su numero digital
        mov Vec_Original[di], al ;Se agrega al vector original
        mov Vec_Bubble[di],al ;Se agrega al vector para el bubble
        mov Vec_Quick[di],al ;Se agrega al vector para el quick
        mov Vec_Shell[di],al ;Se agrega al vector para el shell
        IncContador tamanio
        inc di
        inc si
        ;print Vec_Original
        ;print saltolinea
        jmp Encontrar_Mayor

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
        mov Vec_Bubble[di],al ;Se agrega al vector para el bubble
        mov Vec_Quick[di],al ;Se agrega al vector para el quick
        mov Vec_Shell[di],al ;Se agrega al vector para el shell
        IncContador tamanio
        inc di
        inc si
        ;print Vec_Original
        ;print saltolinea
        jmp Encontrar_Mayor
    
    Carga_exito:
        ;print Vec_Original
        print SeCargoExito
        print saltolinea
        ;print tamanio
        jmp menu
    
    salir:
		close
main endp
end main