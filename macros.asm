print macro cadena ;imprimir cadenas
    mov ah,09h ;Numero de funcion para imprimir cadena en pantalla
	mov dx, @data ;con esto le decimos que nuestro dato se encuentra en la sección data
	mov ds,dx ;el ds debe apuntar al segmento donde se encuentra la cadena (osea el dx, que apunta  a data)
	mov dx,offset cadena ;especificamos el largo de la cadena, con la instrucción offset
	int 21h  ;ejecutamos la interrupción
endm

close macro  ;cerrar el programa
    mov ah, 4ch ;Numero de función que finaliza el programa
    xor al,al ;limpiar al 
    int 21h
endm

getChar macro ;obtener caracter
    mov ah,01h ;se guarda en al en código hexadecimal del caracter leído 
    int 21h
endm

ObtenerTexto macro cadena ;macro para recibir una cadena, varios caracteres 

LOCAL ObtenerChar, endTexto 
;, cx, di  registros que usualmente se usan como contadores 
    xor di,di  ; => mov di, 0  reinica el contador

    ObtenerChar:
        getChar  ;llamamos al método de obtener caracter 
        cmp al, 0dh ; como se guarda en al, comparo di al es igual a salto de línea, ascii de salto de linea en hexadecimal o 10en ascii
        je endTexto ;di es igual que el salto de línea, nos vamos a la etiqueta endTexto, donde agregamos el $ de dolar a la entrada 
        mov cadena[di],al ; mov destino, fuente.  Vamos copiando el ascii del caracter que se guardó en al, al vector cadena en la posicion del contador di
        inc di ; => di = di+1
        jmp ObtenerChar

    endTexto:
        mov al, 36 ;ascii del signo $ o en hexadecimal 24h
        mov cadena[di],al  ;copiamos el $ a la cadena
endm

NumToAscii macro temp
    mov al, temp      
    aam                
    add ax, 3030h 
    push ax     
    mov dl, ah 
    ;En dl estan las decenas     
    mov temp[0],dl   
    mov ah, 02h        
    int 21h
    pop dx
    ; en dl esta en unidades 
    mov temp[1], dl
    mov temp[2], 36            
    mov ah, 02h        
    int 21h
endm 

limpiar macro buffer, numbytes, caracter
LOCAL Repetir
	xor di,di ; colocamos en 0 el contador di
	xor cx,cx ; colocamos en 0 el contador cx
	mov	cx,numbytes ;le pasamos a cx el tamaño del arreglo a limpiar 

	Repetir:
		mov buffer[di], caracter ;le asigno el caracter que le estoy mandando 
		inc di ;incremento di
		Loop Repetir ;se va a repetir hasta que cx sea 0 
endm

crear macro buffer, handler
	
	mov ah,3ch ;función para crear fichero
	mov cx,00h ;fichero normal 
	lea dx,buffer ;carga la dirección de la variable buffer a dx
	int 21h
	mov handler, ax ;sino hubo error nos devuelve el handler 

endm

escribir macro handler, buffer, numbytes

	mov ah, 40h ;función de escritura del archivo 
	mov bx, handler ;en bx copiamos el handler, 
	mov cx, numbytes ;numero de bytes a escribit 
	lea dx, buffer ;carga la dirección de la variable buffer a dx
	int 21h ;ejecutamos la interrupción 

endm

cerrar macro handler
	
	mov ah,3eh
	mov bx, handler
	int 21h
	mov handler,ax

endm

limpiar macro buffer, numbytes, caracter
LOCAL Repetir
    push di
	xor di,di ; colocamos en 0 el contador di
	xor cx,cx ; colocamos en 0 el contador cx
	mov	cx,numbytes ;le pasamos a cx el tamaño del arreglo a limpiar 

	Repetir:
		mov buffer[di], caracter ;le asigno el caracter que le estoy mandando 
		inc di ;incremento di
		Loop Repetir ;se va a repetir hasta que cx sea 0 
    xor di,di
    pop di
endm

Concatenar_Encabezado_HTML macro destino, fuente
    LOCAL LeerCaracter, FinCadena ;si, cx, di  registros que usualmente se usan como contadores 
    xor di, di
    LeerCaracter:
        mov al, fuente[di]
        cmp al, 36
            je FinCadena
        mov destino[si], al
        inc si
        inc di
        jmp LeerCaracter        
    FinCadena:
endm

obtenerRuta macro buffer
LOCAL ObtenerChar, endTexto
	xor di,di ; xor di,di =	mov di,0
	
	ObtenerChar:
		getChar
		cmp al,0dh ; ascii de salto de linea en hexa
		je endTexto
		mov buffer[di],al ;mov destino, fuente
		inc di ; di = di + 1
		jmp ObtenerChar

	endTexto:
		mov al,00h ; asci del caracter nulo
		mov buffer[di], al  
endm

abrir macro buffer,handler
	mov ah,3dh ;funcion para abrir fichero 
	mov al,02h ;010b Acceso de lectura/escritura. 010b 
	lea dx,buffer ;carga la dirección de la fuente (buffer) a dx 
	int 21h ;ejecutamos la interrupción 
	jc Error1 ;salta el flag de acarreo = 1
	mov handler,ax ;sino hay error  en ax devuelve un handle para acceder al fichero 
endm

leer macro handler,buffer, numbytes	
	mov ah,3fh ;interrupción para leer 
	mov bx,handler ;copiamos en bx el handler,referencia al fichero
	mov cx,numbytes ;numero de bytes a leer, tamaño del arreglo que guarda el contenido 
	lea dx,buffer ;carga la dirección de la variable buffer a dx
	int 21h
	jc  Error5
	;en el buffer se guarda la información
endm

Delay macro 
LOCAL Seg_0, Seg_1, Seg_2, Seg_3, Seg_4, Seg_5, Seg_6, Seg_7, Seg_8, Seg_9, fin
	mov al,tiempo[0]
	cmp al,48
		je Seg_0
	cmp al,49
		je Seg_1
	cmp al,50
		je Seg_2
	cmp al,51
		je Seg_3
	cmp al,52
		je Seg_4	
	cmp al,53
		je Seg_5	
	cmp al,54
		je Seg_6	
	cmp al,55
		je Seg_7
	cmp al,56
		je Seg_8	
	cmp al,57
		je Seg_9	
	Seg_0:
		jmp fin
	Seg_1:
		mov cx,0007h
		mov dx,0A120h
		mov ah,86h
		mov al,0
		int 15h
		jmp fin
	Seg_2:
		mov cx,000Fh
		mov dx,04240h
		mov ah,86h
		mov al,0
		int 15h
		jmp fin
	Seg_3:
		mov cx,0016h
		mov dx,0E360h
		mov ah,86h
		mov al,0
		int 15h
		jmp fin
	Seg_4:
		mov cx,001Eh
		mov dx,08480h
		mov ah,86h
		mov al,0
		int 15h
		jmp fin
	Seg_5:
		mov cx,0026h
		mov dx,025A0h
		mov ah,86h
		mov al,0
		int 15h
		jmp fin
	Seg_6:
		mov cx,002Dh
		mov dx,0C6C0h
		mov ah,86h
		mov al,0
		int 15h
		jmp fin
	Seg_7:
		mov cx,0035h
		mov dx,067E0h
		mov ah,86h
		mov al,0
		int 15h
		jmp fin
	Seg_8:
		mov cx,003Dh
		mov dx,00900h
		mov ah,86h
		mov al,0
		int 15h
		jmp fin
	Seg_9:
		mov cx,0044h
		mov dx,0AA20h
		mov ah,86h
		mov al,0
		int 15h
		jmp fin
	fin:							
endm

IncContador macro numero
    mov al, numero[0]
    add al, 1
    mov numero[0], al
    xor ax,ax
endm

Bubblesort_Ascendente macro vector
LOCAL ciclo1, Inter, ciclo2, Inter2, condicion_if, fin
	xor si,si
	xor di,di
	xor ax,ax
	xor bx,bx
	mov i[0],0 ; int i = 0
	mov j[0],0 ; int j = 0
	mov Count[0],0 ; int j = 0
	mov al,tamanio[0] ;Vector.length
	sub al,1
	mov tamanio_1[0],al ;Vector.length - 1 
	ciclo1: 
		mov al,i[0] ;valor actual de i
		cmp al,tamanio[0] ; i<vector.length 
			jge fin ; Si no cumple la condicion anterior termina	
		xor di,di ; j = 0
		mov j[0],0 ; j = 0
		jmp ciclo2 ;Va al for anidado

	Inter:
		IncContador i ; i++
		inc si ; i++
		jmp ciclo1

	ciclo2:
		mov al,j[0] ;Valor actual de j
		cmp al,tamanio_1[0] ;j<vector.length - 1
			jge Inter ;Si no cumple vuelve al primer for
		
		mov al,vector[di] ;al contiene vector[j]
		inc di
		mov bl,vector[di] ;bl contiene vector[j+1]
		dec di
		cmp al,bl
			jg condicion_if
		jmp Inter2
		
	Inter2:
		IncContador j ; j++
		inc di ;j++
		jmp ciclo2 ;Se repite el for
	
	condicion_if:
		mov al,vector[di] ;al contiene vector[j]
		inc di
		mov bl,vector[di] ;bl contiene vector[j+1]
		dec di

		mov temp[0],al ; temp = vector[j]
		mov vector[di],bl ;vector[j] = vector[j+1];
		inc di ;j+1
		mov al, temp[0]
		mov vector[di],al ;vector[j+1] = temp;
		dec di
		print vector
		print saltolinea
		Delay
		jmp Inter2

	fin:
		print vector
		print saltolinea
		;print i
		;print saltolinea
		;print tamanio_1
		;print saltolinea
endm

Bubblesort_Descendente macro vector
LOCAL ciclo1, Inter, ciclo2, Inter2, condicion_if, fin
	xor si,si
	xor di,di
	xor ax,ax
	xor bx,bx
	mov i[0],0 ; int i = 0
	mov j[0],0 ; int j = 0
	mov Count[0],0 ; int j = 0
	mov al,tamanio[0] ;Vector.length
	sub al,1
	mov tamanio_1[0],al ;Vector.length - 1 
	ciclo1: 
		mov al,i[0] ;valor actual de i
		cmp al,tamanio[0] ; i<vector.length 
			jge fin ; Si no cumple la condicion anterior termina	
		xor di,di ; j = 0
		mov j[0],0 ; j = 0
		jmp ciclo2 ;Va al for anidado

	Inter:
		IncContador i ; i++
		inc si ; i++
		jmp ciclo1

	ciclo2:
		mov al,j[0] ;Valor actual de j
		cmp al,tamanio_1[0] ;j<vector.length - 1
			jge Inter ;Si no cumple vuelve al primer for
		
		mov al,vector[di] ;al contiene vector[j]
		inc di
		mov bl,vector[di] ;bl contiene vector[j+1]
		dec di
		cmp al,bl
			jl condicion_if
		jmp Inter2
		
	Inter2:
		IncContador j ; j++
		inc di ;j++
		jmp ciclo2 ;Se repite el for
	
	condicion_if:
		mov al,vector[di] ;al contiene vector[j]
		inc di
		mov bl,vector[di] ;bl contiene vector[j+1]
		dec di

		mov temp[0],al ; temp = vector[j]
		mov vector[di],bl ;vector[j] = vector[j+1];
		inc di ;j+1
		mov al, temp[0]
		mov vector[di],al ;vector[j+1] = temp;
		dec di
		print vector
		print saltolinea
		Delay
		jmp Inter2

	fin:
		print vector
		print saltolinea
		;print i
		;print saltolinea
		;print tamanio_1
		;print saltolinea
endm

Shellsort_Ascendente macro vector
LOCAL Ciclo1, Inter1, Ciclo2, Inter2, condicion_if, condicion_while, InterW, fin
	xor si,si
	xor di,di
	xor ax,ax
	xor bx,bx
	mov Count[0],0
	mov i[0],0 ; int i = 0	
	mov salto[0],0 ;salto = 0
	mov aux[0],0 ;aux = 0
	mov cambios[0],1 ;cambios = true

	mov al,tamanio[0]
	mov bl,2
	div bl
	mov salto[0],al ;salto = vector.length / 2
	ciclo1:	
		mov al, salto[0]
		cmp al,0
			je fin ;salto != 0 sale del ciclo
		mov cambios[0],1 ;cambios = true;
		jmp condicion_while

	condicion_while:
		mov cambios[0],0 ;cambios = false
		xor ax,ax
		xor bx,bx
		mov al,salto[0]
		mov i[0],al ; int i = salto
		Salto_I ; asigna el valor de i si
		jmp Ciclo2

	Ciclo2:
		xor ax,ax
		mov al, vector[si]	
		mov vecI[0],al ; vector[i]
		
		push si
		xor si,si
		Salto_indice
		mov al, vector[si]	
		mov vecI_salto[0],al ; vector[i - salto]
		xor si,si
		pop si
		
		mov al,vecI_salto[0]
		mov bl,vecI[0]
		cmp al,bl ;if (vector[i - salto] > vector[i])
			jg condicion_if

		IncContador i
		inc si
		jmp Inter2

	condicion_if:
		xor ax,ax
		mov al, vecI[0]
		mov aux[0],al ;aux = vector[i]; 
		
		mov al,vecI_salto[0]
		mov vector[si], al ;vector[i] = vector[i - salto];

		push si
		xor si,si
		Salto_indice
		mov al,aux[0]
		mov vector[si],al ;vector[i - salto] = aux;
		xor si,si
		pop si

		mov cambios[0],1 ;cambios = true;

		IncContador i
		inc si

		print vector
		print saltolinea
		Delay

		jmp Inter2

	Inter2:
		xor ax,ax
		xor bx,bx
		mov al,i[0]
		mov bl,tamanio[0]		
		cmp al,bl
			jl Ciclo2
		jmp InterW
	
	InterW:
		xor ax,ax
		xor bx,bx
		mov al, cambios[0]
		cmp al,1
			je condicion_while
		jmp Inter1
		

	Inter1:
		xor ax,ax
		xor bx,bx
		mov al,salto[0]
		mov bl,2
		div bl
		mov salto[0],al
		jmp ciclo1

	fin:
		print saltolinea
		print vector 
endm

Shellsort_Descendente macro vector
LOCAL Ciclo1, Inter1, Ciclo2, Inter2, condicion_if, condicion_while, InterW, fin
	xor si,si
	xor di,di
	xor ax,ax
	xor bx,bx
	mov Count[0],0
	mov i[0],0 ; int i = 0	
	mov salto[0],0 ;salto = 0
	mov aux[0],0 ;aux = 0
	mov cambios[0],1 ;cambios = true

	mov al,tamanio[0]
	mov bl,2
	div bl
	mov salto[0],al ;salto = vector.length / 2
	ciclo1:	
		mov al, salto[0]
		cmp al,0
			je fin ;salto != 0 sale del ciclo
		mov cambios[0],1 ;cambios = true;
		jmp condicion_while

	condicion_while:
		mov cambios[0],0 ;cambios = false
		xor ax,ax
		xor bx,bx
		mov al,salto[0]
		mov i[0],al ; int i = salto
		Salto_I ; asigna el valor de i si
		jmp Ciclo2

	Ciclo2:
		xor ax,ax
		mov al, vector[si]	
		mov vecI[0],al ; vector[i]
		
		push si
		xor si,si
		Salto_indice
		mov al, vector[si]	
		mov vecI_salto[0],al ; vector[i - salto]
		xor si,si
		pop si
		
		mov al,vecI_salto[0]
		mov bl,vecI[0]
		cmp al,bl ;if (vector[i - salto] > vector[i])
			jl condicion_if

		IncContador i
		inc si
		jmp Inter2

	condicion_if:
		xor ax,ax
		mov al, vecI[0]
		mov aux[0],al ;aux = vector[i]; 
		
		mov al,vecI_salto[0]
		mov vector[si], al ;vector[i] = vector[i - salto];

		push si
		xor si,si
		Salto_indice
		mov al,aux[0]
		mov vector[si],al ;vector[i - salto] = aux;
		xor si,si
		pop si

		mov cambios[0],1 ;cambios = true;

		IncContador i
		inc si

		print vector
		print saltolinea
		Delay

		jmp Inter2

	Inter2:
		xor ax,ax
		xor bx,bx
		mov al,i[0]
		mov bl,tamanio[0]		
		cmp al,bl
			jl Ciclo2
		jmp InterW
	
	InterW:
		xor ax,ax
		xor bx,bx
		mov al, cambios[0]
		cmp al,1
			je condicion_while
		jmp Inter1
		

	Inter1:
		xor ax,ax
		xor bx,bx
		mov al,salto[0]
		mov bl,2
		div bl
		mov salto[0],al
		jmp ciclo1

	fin:
		print vector
		print saltolinea
endm

Salto_I macro
LOCAL ciclo
	xor cx,cx
	xor ax,ax
	xor si,si
	mov al,salto[0]
	mov cl,al ;Numero de veces que va hacer el ciclo
	ciclo:
		inc si		
	loop ciclo
endm

Salto_indice macro
LOCAL ciclo
	xor cx,cx
	xor bx,bx
	xor ax,ax
	mov al,i[0]
	mov bl,salto[0]
	sub al,bl
	mov cl,al ;Numero de veces que va hacer el ciclo
	ciclo:
		inc si
	loop ciclo
endm