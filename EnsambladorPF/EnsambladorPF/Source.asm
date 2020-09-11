.686p
.model flat, stdcall
.stack 4096

include Protos.inc
include Equs.inc
include Estructuras.inc

;Macro para copiar variables en otras variables
COPIAR macro Destino, Origen
	push eax
	mov eax, Origen
	mov Destino, eax
	pop eax
endm

IDB_BITMAP1    equ 101;MENU
IDB_BITMAP2    equ 102;CONTROLES
IDB_BITMAP3    equ 103;FONDO ESPACIO
IDB_BITMAP4    equ 104;NAVE BLANCA
IDB_BITMAP5    equ 105;NAVE NEGRA
IDB_BITMAP6    equ 106;INTERFAZ
IDB_BITMAP7    equ 107;CORAZON BLANCO
IDB_BITMAP8    equ 108;CORAZON NEGRO
IDB_BITMAP9    equ 109;GAME OVER
IDB_BITMAP10   equ 110;EXPLOSION BLANCO
IDB_BITMAP11   equ 111;EXPLOSION NEGRO
IDB_BITMAP12   equ 112;VIDA BLANCO
IDB_BITMAP13   equ 113;VIDA NEGRO
IDB_BITMAP14   equ 114;BOTON VERDE
IDB_BITMAP15   equ 115;BOTON ROJO

Colision	proto stdcall :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD

.data
indiceCaminar			DWORD	0
indiceBackground		DWORD	0
indiceShoot				DWORD	0
indiceMenu				DWORD	0
indiceTimer				DWORD	0
indiceMeteorito			DWORD	0
flagONE					BYTE	0
flagTWO					BYTE	0
Menu_open				BYTE	0
Vidas					DWORD	3
DistanciaVidas			DWORD	820
Contador				DWORD	0
flagControl				BYTE	0
flagShootDRAW			BYTE	0
flagShootKD				BYTE	0
flagChoque				BYTE	0
TimerShoot				DWORD	0
indiceShootDOS			DWORD	0
velocidadShoot			DWORD	0
TimerInactividad		DWORD	0
GO						BYTE	0 ;Bandera de GameOver
SCORE					DWORD	10 ;Puntaje

;Variables para humo de la nave
indiceHumo		DWORD	0
flagHumo		BYTE	0
velocidadHumo	DWORD	0
posXHumo		DWORD	0

;Variables de meteoritos
posicionMeteoritoUNO	DWORD	50
posicionMeteoritoDOS	DWORD	50
posicionMeteoritoTRES	DWORD	50
posicionMeteoritoCUATRO	DWORD	50
posicionMeteoritoCINCO	DWORD	50
posicionMeteoritoSEIS	DWORD	50
flagMeteoritoUNO		BYTE	0
flagMeteoritoDOS		BYTE	0
flagMeteoritoTRES		BYTE	0
flagMeteoritoCUATRO		BYTE	0
flagMeteoritoCINCO		BYTE	0
flagMeteoritoSEIS		BYTE	0
TimerUNO				DWORD	0
TimerDOS				DWORD	0
TimerTRES				DWORD	0
TimerCUATRO				DWORD	0
TimerCINCO				DWORD	0
TimerSEIS				DWORD	0

;Banderas para colisiones disparo - meteorito (EXPLOSION)
flagColsionMeteUNO		BYTE	0
flagColsionMeteDOS		BYTE	0
flagColsionMeteTRES		BYTE	0
flagColsionMeteCUATRO	BYTE	0
flagColsionMeteCINCO	BYTE	0
flagColsionMeteSEIS		BYTE	0
indiceExplosion			DWORD	0
velocidadExplosion		DWORD	0
posicionYExplosion		DWORD	0

;Variables para vida para agarrar
flagVidaUNO				BYTE	0
flagVidaDOS  			BYTE	0
indiceVidaUNO			DWORD	0
indiceVidaDOS			DWORD	0
posicionVidaUNO			DWORD	50
posicionVidaDOS			DWORD	50
timerVidaUNO			DWORD	0
timerVidaDOS			DWORD	0
velocidadVidadUNO		DWORD	0
velocidadVidadDOS		DWORD	0

;Variables para minas
flagMinaUNO				DWORD	0
flagMinaDOS				DWORD	0
flagMinaTRES			DWORD	0
flagMinaCUATRO			DWORD	0
flagMinaCINCO			DWORD	0
flagMinaSEIS			DWORD	0

;Variables de bitmaps				
hInstanc		dword ?
hwnd			dword ?
hBitmap			dword ?
hBitmap2		dword ?
hBitmap3		dword ?
hBitmap4		dword ?
hBitmapMenu		dword ?
hGameOver		dword ?
hInterfazUNO	dword ?
hMenuControles	dword ?
hMemDC			dword ?
hNaveN			dword ?
hNaveB			dword ?
hCorazonN		dword ?
hCorazonB		dword ?
hEspacio		dword ?
hMeteoritoB		dword ?
hMeteoritoN		dword ?
hVidaB			dword ?
hVidaN			dword ?
hBotonV			dword ?
hBotonR			dword ?

posFondoY		dword 3000
flagMB			BYTE 0

ClassName db "Clase_Simple",0
AppName db "SPACE WAR",0
FontName db "script",0
Cancion db 'C:\\Halo.wav', 0
Puntuacion db "PUNTUACION: ", 0

;estos datos corresponden a la fraccion del bitmap que tiene la secuencia de la animacion
;explosion.bmp, cada secuencia 
sprites					POINT <186,39>, <243,39>, <301,39>, <350,39>
spritesNave				POINT <0, 0>, <140, 0>, <280, 0>, <420,0>, <560, 0>, <700, 0>, <840, 0>, <980, 0>
spritesNave2			POINT <5,150>, <145,150>, <285,150>, <425,150>, <565,150>, <705,150>, <845,150>, <985,150>
spritesMeteorito		POINT <299,25>, <299,170>, <299,315>, <299,460>
spriteVida				POINT <94,493>, <162, 493>, <232,493>, <300,493>
spriteMina				POINT <302,629>, <415,629>
spriteDisparo			POINT <232,154>, <232,222>, <232, 302>, <232, 365>
spriteExplosion			POINT <18,149>, <18, 255>, <18, 373>, <18,481>
spriteHumo				POINT <131, 301>, <131, 398>, <131, 508>

indice				dword 0
indiceMinas			dword 0
indiceMinasDOS		dword 0
indiceMeteUNO		dword 0
indiceMeteDOS		dword 0
indiceMeteTRES		dword 0
indiceMeteCUATRO	dword 0
indiceMeteCINCO		dword 0
indiceMeteSEIS		dword 0

entrada XINPUT_STATE <>
posX			DWORD	0
posY			DWORD	0
posXDisparo		DWORD	0
posYDisparo		DWORD	0
dibuja			byte    0

.code
main proc	
	
	invoke GetModuleHandleA, NULL             
    mov hInstanc,eax                      
	invoke WinMain, hInstanc,NULL,NULL, SW_SHOWDEFAULT
	
	call ExitProcess@4
main endp

WinMain proc hInst:dword,hPrevInst:dword,CmdLine:dword,CmdShow:DWORD
	LOCAL wc:WNDCLASSEX
	LOCAL msge:MSG 

mov   wc.cbSize,SIZEOF WNDCLASSEX                    
    mov   wc.style, CS_HREDRAW or CS_VREDRAW 
    mov   wc.lpfnWndProc, OFFSET WndProc 
    mov   wc.cbClsExtra,NULL 
    mov   wc.cbWndExtra,NULL 
    push  hInstanc 
    pop   wc.hInstance 
    mov   wc.hbrBackground,COLOR_WINDOW + 1 
    mov   wc.lpszMenuName,NULL 
    mov   wc.lpszClassName,OFFSET ClassName 
    invoke LoadIconA,NULL,IDI_APPLICATION 
    mov   wc.hIcon,eax 
    mov   wc.hIconSm,eax 
    invoke LoadCursorA,NULL,IDC_ARROW 
    mov   wc.hCursor,eax 

	invoke RegisterClassExA, addr wc                       
    invoke CreateWindowExA,NULL, 
                ADDR ClassName,
                ADDR AppName, 
                WS_OVERLAPPEDWINDOW, 
                100,
                0,
                1000, 
                600, 
                NULL, 
                NULL, 
                hInst, 
                NULL 
    mov   hwnd,eax 
    invoke ShowWindow, hwnd,CmdShow                
    invoke UpdateWindow, hwnd  
	
	;estoy creando el timer, asociado a la ventana por el handler hwnd
	;el primer 200 es el identificador o "nombre" del timer, el segundo 40
	;es la duracion en milisegundos del timer, NULL es que no hay TIMEPROC
	                   
	invoke SetTimer, hwnd, 200, 40, NULL

    .WHILE TRUE                                   
                invoke GetMessageA, ADDR msge,NULL,0,0 
                .BREAK .IF (!eax) 
                invoke TranslateMessage, ADDR msge 
                invoke DispatchMessageA, ADDR msge 
				
   .ENDW 
    mov     eax,msge.wParam                                       
	ret 
WinMain endp

WndProc proc hWnd2:dword, uMsg:dword, wParam:dword, lParam:dword

	LOCAL hdc:dword
    LOCAL ps:PAINTSTRUCT 
    LOCAL hfont:dword
	LOCAL rectan:RECT 
	LOCAL estado:DWORD
	

	.IF uMsg==WM_DESTROY   
	    invoke KillTimer, hwnd, 200   
		invoke DeleteObject,hBitmap                      
        invoke PostQuitMessage,NULL 
	.ELSEIF uMsg==WM_CREATE  
		;CANCION
		PUSH edx
		mov edx, 0001h
		or edx, 008h
		or edx, 20000h
		invoke PlaySound, addr Cancion, 0, edx
		pop edx

		invoke LoadBitmapA,hInstanc,IDB_BITMAP3 ;Fondo espacio
		mov hEspacio,eax  
		invoke LoadBitmapA,hInstanc,IDB_BITMAP4 ;Cargando nave blanca
		mov hNaveB,eax  
		invoke LoadBitmapA,hInstanc,IDB_BITMAP5 ;Cargando nave negra
		mov hNaveN,eax  
		invoke LoadBitmapA,hInstanc,IDB_BITMAP1 ;Fondo del menu
		mov hBitmapMenu,eax  
		invoke LoadBitmapA,hInstanc,IDB_BITMAP2 ;Fondo de controles
		mov hMenuControles,eax
		invoke LoadBitmapA,hInstanc,IDB_BITMAP9 ;Fondo de gameover
		mov hGameOver,eax
		invoke LoadBitmapA,hInstanc,IDB_BITMAP6 ;Fondo de la interfaz
		mov hInterfazUNO,eax
		invoke LoadBitmapA,hInstanc,IDB_BITMAP8 ;Cargando corazon negro
		mov hCorazonN,eax
		invoke LoadBitmapA,hInstanc,IDB_BITMAP7 ;Cargando corazon blanco
		mov hCorazonB,eax
		invoke LoadBitmapA,hInstanc,IDB_BITMAP10 ;Cargando meteorito blanco
		mov hMeteoritoB,eax
		invoke LoadBitmapA,hInstanc,IDB_BITMAP11 ;Cargando meteorito blanco
		mov hMeteoritoN,eax
		invoke LoadBitmapA,hInstanc,IDB_BITMAP12 ;Cargando vida blanco
		mov hVidaB,eax
		invoke LoadBitmapA,hInstanc,IDB_BITMAP13 ;Cargando vida negro
		mov hVidaN,eax
		invoke LoadBitmapA,hInstanc,IDB_BITMAP14 ;Cargando boton verde
		mov hBotonV,eax
		invoke LoadBitmapA,hInstanc,IDB_BITMAP15 ;Cargando boton rojo
		mov hBotonR,eax

		mov posX, 500
		mov posY, 400

	.ELSEIF uMsg==WM_KEYUP
			mov eax, wParam
			.IF (ax == 'A')
				.WHILE indice != 0
					
					 dec indice
					jmp salta2
					;invoke InvalidateRect, hWnd, NULL, FALSE
					;invoke UpdateWindow, hWnd
				.ENDW
				mov flagONE, 0
			.ELSEIF (ax == 'D')
				.WHILE indice != 0
					dec indice
					jmp salta2
					;invoke InvalidateRect, hWnd, NULL, FALSE
					;invoke UpdateWindow, hWnd
				.ENDW
				mov flagTWO, 0
			.ENDIF
	.ELSEIF uMsg==WM_PAINT 
	
        invoke BeginPaint,hWnd, ADDR ps ;el begin paint siempre va cuando se imprime lo que sea en pantalla
        mov    hdc,eax 

		invoke CreateCompatibleDC,hdc 
		mov    hMemDC, eax 
		
		;DIBUJADO DEL MENU
		.IF Menu_open == 0

			mov Vidas, 3
			mov edi, indiceMenu
			shl edi, 3

			;aqui cargamos el menu
			invoke SelectObject,hMemDC,hBitmapMenu 
			invoke GetClientRect,hWnd,addr rectan 		
			invoke BitBlt,hdc,0,0,rectan.right,rectan.bottom,hMemDC,100,0,SRCCOPY 
		.ELSEIF Menu_open == 1 ;Controles
			mov edi, indiceMenu
			shl edi, 3

			;aqui cargamos el menu de controles
			invoke SelectObject,hMemDC,hMenuControles 
			invoke GetClientRect,hWnd,addr rectan 		
			invoke BitBlt,hdc,0,0,rectan.right,rectan.bottom,hMemDC,100,0,SRCCOPY
		
		.ELSEIF Menu_open == 2 ;Dibujado del juego
			.IF Vidas > 3 ;Si perdemos entra
				mov edi, indiceMenu
				shl edi, 3
			
				invoke SelectObject,hMemDC,hGameOver 
				invoke GetClientRect,hWnd,addr rectan 		
				invoke BitBlt,hdc,0,0,rectan.right,rectan.bottom,hMemDC,100,0,SRCCOPY
				
				.IF GO == 1
					mov flagMB, 1
					
					mov Menu_open, 0 ;Volvemos al menu principal
					;Reacomodamos la posicion de la nave
					mov posX, 400
					mov posY, 400
					mov Vidas, 3 ;Restauramos la vida
					;Reseteamos todos los timers
					mov TimerUNO,0
					mov TimerDOS,0
					mov TimerTRES,0
					mov TimerCUATRO,0
					mov TimerCINCO,0
					mov TimerSEIS,0
					mov timerVidaUNO,0
					mov timerVidaDOS,0
					mov TimerShoot,0
					;Reseteamos todas las posiciones
					mov posicionMeteoritoUNO, 50
					mov posicionMeteoritoDOS, 50
					mov posicionMeteoritoTRES, 50
					mov posicionMeteoritoCUATRO, 50
					mov posicionMeteoritoCINCO, 50
					mov posicionMeteoritoSEIS, 50
					mov posicionVidaUNO, 50
					mov posicionVidaDOS, 50
					;Reseteamos las banderas de dibujado
					mov flagMeteoritoUNO, 0
					mov flagMeteoritoDOS, 0
					mov flagMeteoritoTRES, 0
					mov flagMeteoritoCUATRO, 0
					mov flagMeteoritoCINCO, 0
					mov flagMeteoritoSEIS, 0
					mov flagShootDRAW, 0
					mov flagVidaUNO,0
					mov flagVidaDOS,0
					mov flagColsionMeteUNO, 0
					mov flagColsionMeteDOS, 0
					mov flagColsionMeteTRES, 0
					mov flagColsionMeteCUATRO, 0
					mov flagColsionMeteCINCO, 0
					mov flagColsionMeteSEIS, 0		
					mov flagHumo, 0
					mov posFondoY, 3000 ;Regresamos la imagen de fondo
					mov GO, 0
				.ENDIF
		
			.ELSE
				mov edi, indiceBackground
				shl edi, 3
				;aqui cargamos el fondo
				invoke SelectObject,hMemDC,hEspacio
				invoke GetClientRect,hWnd,addr rectan 		
				invoke BitBlt,hdc,0,0,rectan.right,rectan.bottom,hMemDC,0,posFondoY,SRCCOPY 

				;aqui cargamos la interfaz
				invoke SelectObject,hMemDC,hInterfazUNO 
				invoke GetClientRect,hWnd,addr rectan 		
				invoke BitBlt,hdc,0,0,rectan.right,rectan.bottom,hMemDC,0,0,SRCCOPY 

				;aqui cargamos la vida
				xor ebx, ebx
				mov ebx, Vidas
				mov ecx, Vidas
				.WHILE Contador != ebx
					invoke SelectObject,hMemDC,hCorazonB 
					invoke GetClientRect,hWnd,addr rectan 		
					invoke BitBlt,hdc,DistanciaVidas,10,50,50,hMemDC,0,0,SRCAND 

					invoke SelectObject,hMemDC,hCorazonN 
					invoke GetClientRect,hWnd,addr rectan 		
					invoke BitBlt,hdc,DistanciaVidas,10,50,50,hMemDC,0,0,SRCPAINT 
					add DistanciaVidas, 60
					inc Contador
				.ENDW
				mov Contador, 0
				mov DistanciaVidas, 820

				;Aqui cargamos cuando tengas el disparo cargado
				.IF TimerShoot > 100 
					invoke SelectObject,hMemDC,hBotonV 
					invoke GetClientRect,hWnd,addr rectan 		
					invoke BitBlt,hdc,550,0,50,50,hMemDC,0,0,SRCCOPY 
				.ELSE
					invoke SelectObject,hMemDC,hBotonR 
					invoke GetClientRect,hWnd,addr rectan 		
					invoke BitBlt,hdc,550,0,50,50,hMemDC,0,0,SRCCOPY 
				.ENDIF

				;aqui dibujamos los meteoritos
				.IF flagMeteoritoUNO == 1
					mov esi, indiceMeteorito
					shl esi, 3
					invoke SelectObject,hMemDC,hMeteoritoB 				
					invoke BitBlt,hdc,0,posicionMeteoritoUNO,78,145,hMemDC,spritesMeteorito[esi].x,spritesMeteorito[esi].y,SRCAND 

					invoke SelectObject,hMemDC,hMeteoritoN				
					invoke BitBlt,hdc,0,posicionMeteoritoUNO,78,145,hMemDC,spritesMeteorito[esi].x,spritesMeteorito[esi].y,SRCPAINT 		
				.ENDIF

				;Mina
				.IF flagMeteoritoDOS == 1
					mov esi, indiceMinas
					shl esi, 3
					invoke SelectObject,hMemDC,hVidaB 				
					invoke BitBlt,hdc,180,posicionMeteoritoDOS,104,104,hMemDC,spriteMina[esi].x,spriteMina[esi].y,SRCAND 

					invoke SelectObject,hMemDC,hVidaN				
					invoke BitBlt,hdc,180,posicionMeteoritoDOS,104,104,hMemDC,spriteMina[esi].x,spriteMina[esi].y,SRCPAINT 	
				.ENDIF

				.IF flagMeteoritoTRES == 1
					mov esi, indiceMeteorito
					shl esi, 3
					invoke SelectObject,hMemDC,hMeteoritoB 				
					invoke BitBlt,hdc,350,posicionMeteoritoTRES,78,145,hMemDC,spritesMeteorito[esi].x,spritesMeteorito[esi].y,SRCAND 

					invoke SelectObject,hMemDC,hMeteoritoN				
					invoke BitBlt,hdc,350,posicionMeteoritoTRES,78,145,hMemDC,spritesMeteorito[esi].x,spritesMeteorito[esi].y,SRCPAINT 	 	
				.ENDIF

				.IF flagMeteoritoCUATRO == 1
					mov esi, indiceMeteorito
					shl esi, 3
					invoke SelectObject,hMemDC,hMeteoritoB 				
					invoke BitBlt,hdc,550,posicionMeteoritoCUATRO,78,145,hMemDC,spritesMeteorito[esi].x,spritesMeteorito[esi].y,SRCAND 

					invoke SelectObject,hMemDC,hMeteoritoN				
					invoke BitBlt,hdc,550,posicionMeteoritoCUATRO,78,145,hMemDC,spritesMeteorito[esi].x,spritesMeteorito[esi].y,SRCPAINT 	
				.ENDIF
				
				;Mina
				.IF flagMeteoritoCINCO == 1
					mov esi, indiceMinasDOS
					shl esi, 3
					invoke SelectObject,hMemDC,hVidaB 				
					invoke BitBlt,hdc,700,posicionMeteoritoCINCO,104,104,hMemDC,spriteMina[esi].x,spriteMina[esi].y,SRCAND 

					invoke SelectObject,hMemDC,hVidaN				
					invoke BitBlt,hdc,700,posicionMeteoritoCINCO,104,104,hMemDC,spriteMina[esi].x,spriteMina[esi].y,SRCPAINT 		
				.ENDIF

				.IF flagMeteoritoSEIS == 1
					mov esi, indiceMeteorito
					shl esi, 3
					invoke SelectObject,hMemDC,hMeteoritoB 				
					invoke BitBlt,hdc,870,posicionMeteoritoSEIS,78,145,hMemDC,spritesMeteorito[esi].x,spritesMeteorito[esi].y,SRCAND 

					invoke SelectObject,hMemDC,hMeteoritoN				
					invoke BitBlt,hdc,870,posicionMeteoritoSEIS,78,145,hMemDC,spritesMeteorito[esi].x,spritesMeteorito[esi].y,SRCPAINT 	
				.ENDIF

				;Disparos
				.IF flagShootDRAW == 1

					mov esi, indiceShoot
					shl esi, 3
					invoke SelectObject,hMemDC,hMeteoritoB 				
					invoke BitBlt,hdc,posXDisparo,posYDisparo,60,60,hMemDC,spriteDisparo[esi].x,spriteDisparo[esi].y,SRCAND 

					invoke SelectObject,hMemDC,hMeteoritoN				
					invoke BitBlt,hdc,posXDisparo,posYDisparo,60,60,hMemDC,spriteDisparo[esi].x,spriteDisparo[esi].y,SRCPAINT 

					;Colisiones si disparo
					;Colision disparo - meteorito 1
					invoke Colision, posXDisparo, posYDisparo, 40, 40, 0, posicionMeteoritoUNO, 68, 145
					.IF flagChoque == 1
						mov flagColsionMeteUNO, 1	
						add SCORE, 75
						COPIAR posicionYExplosion, posicionMeteoritoUNO
					.ENDIF
					mov flagChoque, 0

					;Colision disparo - meteorito 2
					invoke Colision, posXDisparo, posYDisparo, 40, 40, 180, posicionMeteoritoDOS, 104, 104
					.IF flagChoque == 1
						mov flagColsionMeteDOS, 1	
						COPIAR posicionYExplosion, posicionMeteoritoDOS
						inc Vidas
						.IF Vidas > 3
							mov Vidas, 3
						.ENDIF 
					.ENDIF
					mov flagChoque, 0

					;Colision disparo - meteorito 3
					invoke Colision, posXDisparo, posYDisparo, 40, 40, 350, posicionMeteoritoTRES, 68, 145
					.IF flagChoque == 1
						mov flagColsionMeteTRES, 1	
						add SCORE, 75
						COPIAR posicionYExplosion, posicionMeteoritoTRES
					.ENDIF
					mov flagChoque, 0

					;Colision disparo - meteorito 4
					invoke Colision, posXDisparo, posYDisparo, 40, 40, 550, posicionMeteoritoCUATRO, 68, 145
					.IF flagChoque == 1
						mov flagColsionMeteCUATRO, 1	
						add SCORE, 75
						COPIAR posicionYExplosion, posicionMeteoritoCUATRO
					.ENDIF
					mov flagChoque, 0

					;Colision disparo - meteorito 5
					invoke Colision, posXDisparo, posYDisparo, 40, 40, 700, posicionMeteoritoCINCO, 104, 104
					.IF flagChoque == 1
						mov flagColsionMeteCINCO, 1	
						COPIAR posicionYExplosion, posicionMeteoritoCINCO
						inc Vidas
						.IF Vidas > 3
							mov Vidas, 3
						.ENDIF 
					.ENDIF
					mov flagChoque, 0

					;Colision disparo - meteorito 6
					invoke Colision, posXDisparo, posYDisparo, 40, 40, 870, posicionMeteoritoSEIS, 68, 145
					.IF flagChoque == 1
						mov flagColsionMeteSEIS, 1	
						add SCORE, 75
						COPIAR posicionYExplosion, posicionMeteoritoSEIS
					.ENDIF
					mov flagChoque, 0

				.ENDIF

				;Dibujado de explosion si colisiona con disparos

				;Dibujado colision meteorito 1
				.IF flagColsionMeteUNO == 1			
					mov esi, indiceExplosion
					shl esi, 3
					invoke SelectObject,hMemDC,hMeteoritoB 				
					invoke BitBlt,hdc,0,posicionYExplosion,96,96,hMemDC,spriteExplosion[esi].x,spriteExplosion[esi].y,SRCAND 

					invoke SelectObject,hMemDC,hMeteoritoN				
					invoke BitBlt,hdc,0,posicionYExplosion,96,96,hMemDC,spriteExplosion[esi].x,spriteExplosion[esi].y,SRCPAINT 
				.ENDIF

				;Dibujado colision meteorito 2
				.IF flagColsionMeteDOS == 1			
					mov esi, indiceExplosion
					shl esi, 3
					invoke SelectObject,hMemDC,hMeteoritoB 				
					invoke BitBlt,hdc,180,posicionYExplosion,96,96,hMemDC,spriteExplosion[esi].x,spriteExplosion[esi].y,SRCAND 

					invoke SelectObject,hMemDC,hMeteoritoN				
					invoke BitBlt,hdc,180,posicionYExplosion,96,96,hMemDC,spriteExplosion[esi].x,spriteExplosion[esi].y,SRCPAINT 
				.ENDIF

				;Dibujado colision meteorito 3
				.IF flagColsionMeteTRES == 1			
					mov esi, indiceExplosion
					shl esi, 3
					invoke SelectObject,hMemDC,hMeteoritoB 				
					invoke BitBlt,hdc,350,posicionYExplosion,96,96,hMemDC,spriteExplosion[esi].x,spriteExplosion[esi].y,SRCAND 

					invoke SelectObject,hMemDC,hMeteoritoN				
					invoke BitBlt,hdc,350,posicionYExplosion,96,96,hMemDC,spriteExplosion[esi].x,spriteExplosion[esi].y,SRCPAINT 
				.ENDIF

				;Dibujado colision meteorito 4
				.IF flagColsionMeteCUATRO == 1			
					mov esi, indiceExplosion
					shl esi, 3
					invoke SelectObject,hMemDC,hMeteoritoB 				
					invoke BitBlt,hdc,550,posicionYExplosion,96,96,hMemDC,spriteExplosion[esi].x,spriteExplosion[esi].y,SRCAND 

					invoke SelectObject,hMemDC,hMeteoritoN				
					invoke BitBlt,hdc,550,posicionYExplosion,96,96,hMemDC,spriteExplosion[esi].x,spriteExplosion[esi].y,SRCPAINT 
				.ENDIF

				;Dibujado colision meteorito 5
				.IF flagColsionMeteCINCO == 1			
					mov esi, indiceExplosion
					shl esi, 3
					invoke SelectObject,hMemDC,hMeteoritoB 				
					invoke BitBlt,hdc,700,posicionYExplosion,96,96,hMemDC,spriteExplosion[esi].x,spriteExplosion[esi].y,SRCAND 

					invoke SelectObject,hMemDC,hMeteoritoN				
					invoke BitBlt,hdc,700,posicionYExplosion,96,96,hMemDC,spriteExplosion[esi].x,spriteExplosion[esi].y,SRCPAINT 
				.ENDIF

				;Dibujado colision meteorito 6
				.IF flagColsionMeteSEIS == 1			
					mov esi, indiceExplosion
					shl esi, 3
					invoke SelectObject,hMemDC,hMeteoritoB 				
					invoke BitBlt,hdc,870,posicionYExplosion,96,96,hMemDC,spriteExplosion[esi].x,spriteExplosion[esi].y,SRCAND 

					invoke SelectObject,hMemDC,hMeteoritoN				
					invoke BitBlt,hdc,870,posicionYExplosion,96,96,hMemDC,spriteExplosion[esi].x,spriteExplosion[esi].y,SRCPAINT 
				.ENDIF

				;Vidas
				.IF flagVidaUNO == 1		
					mov esi, indiceVidaUNO
					shl esi, 3
					invoke SelectObject,hMemDC,hVidaB 				
					invoke BitBlt,hdc,110,posicionVidaUNO,50,50,hMemDC,spriteVida[esi].x,spriteVida[esi].y,SRCAND 

					invoke SelectObject,hMemDC,hVidaN				
					invoke BitBlt,hdc,110,posicionVidaUNO,50,50,hMemDC,spriteVida[esi].x,spriteVida[esi].y,SRCPAINT 
				.ENDIF

				.IF flagVidaDOS == 1		
					mov esi, indiceVidaDOS
					shl esi, 3
					invoke SelectObject,hMemDC,hVidaB 				
					invoke BitBlt,hdc,805,posicionVidaDOS,50,50,hMemDC,spriteVida[esi].x,spriteVida[esi].y,SRCAND 

					invoke SelectObject,hMemDC,hVidaN				
					invoke BitBlt,hdc,805,posicionVidaDOS,50,50,hMemDC,spriteVida[esi].x,spriteVida[esi].y,SRCPAINT 
				.ENDIF

				;con esto movemos a la nave
				mov esi, 0			
				.IF flagONE == 1
					.IF indice < 7 
						mov esi, indice
						shl esi, 3
						invoke SelectObject,hMemDC,hNaveB 				
						invoke BitBlt,hdc,posX,posY,140,140,hMemDC,spritesNave[esi].x,spritesNave[esi].y,SRCAND ; carga de imagen en blanco

						invoke SelectObject,hMemDC,hNaveN				
						invoke BitBlt,hdc,posX,posY,140,140,hMemDC,spritesNave[esi].x,spritesNave[esi].y,SRCPAINT 	; carga de imagene en negro el 140 es el tamano de la imagen
					.ELSEIF indice >= 7
						invoke SelectObject,hMemDC,hNaveB 				
						invoke BitBlt,hdc,posX,posY,140,140,hMemDC,spritesNave[48].x,spritesNave[48].y,SRCAND ; carga de imagen en blanco

						invoke SelectObject,hMemDC,hNaveN				
						invoke BitBlt,hdc,posX,posY,140,140,hMemDC,spritesNave[48].x,spritesNave[48].y,SRCPAINT 	; carga de imagene en negro el 140 es el tamano de la imagen
					.ENDIF
				.ELSEIF flagTWO == 1
					.IF indice < 7 
						mov esi, indice
						shl esi, 3
						invoke SelectObject,hMemDC,hNaveB 				
						invoke BitBlt,hdc,posX,posY,140,140,hMemDC,spritesNave2[esi].x,spritesNave2[esi].y,SRCAND 

						invoke SelectObject,hMemDC,hNaveN				
						invoke BitBlt,hdc,posX,posY,140,140,hMemDC,spritesNave2[esi].x,spritesNave2[esi].y,SRCPAINT 	
					.ELSEIF indice >= 7
						invoke SelectObject,hMemDC,hNaveB 				
						invoke BitBlt,hdc,posX,posY,140,140,hMemDC,spritesNave2[48].x,spritesNave2[48].y,SRCAND 

						invoke SelectObject,hMemDC,hNaveN				
						invoke BitBlt,hdc,posX,posY,140,140,hMemDC,spritesNave2[48].x,spritesNave2[48].y,SRCPAINT 	
					.ENDIF
				.ELSE 
					mov esi, indice
					shl esi, 3
					invoke SelectObject,hMemDC,hNaveB 				
					invoke BitBlt,hdc,posX,posY,140,140,hMemDC,spritesNave[esi].x,spritesNave[esi].y,SRCAND 

					invoke SelectObject,hMemDC,hNaveN				
					invoke BitBlt,hdc,posX,posY,140,140,hMemDC,spritesNave[esi].x,spritesNave[esi].y,SRCPAINT 

				.ENDIF

				;Checar colisiones con vida
				;Paquete de vida izquierdo
				invoke Colision, posX, posY, 107, 107, 110, posicionVidaUNO, 40, 40
				.IF flagChoque == 1
					inc Vidas
					.IF Vidas > 3
						mov Vidas, 3
					.ENDIF
					mov posicionVidaUNO, 600
				.ENDIF
				mov flagChoque, 0

				;Paquete de vida derecho
				invoke Colision, posX, posY, 107, 107, 805, posicionVidaDOS, 40, 40
				.IF flagChoque == 1
					inc Vidas
					.IF Vidas > 3
						mov Vidas, 3
					.ENDIF
					mov posicionVidaDOS, 600
				.ENDIF
				mov flagChoque, 0

				;Checar Colisiones con METEORITOS
				;Colision Meteorito 1
				invoke Colision, posX, posY, 100, 100, 0, posicionMeteoritoUNO, 65, 100
				.IF flagChoque == 1
					mov posicionMeteoritoUNO, 600
					mov flagHumo, 1
					dec Vidas
				.ENDIF
				mov flagChoque, 0

				;Colision Meteorito 2
				invoke Colision, posX, posY, 100, 100, 180, posicionMeteoritoDOS, 80, 100
				.IF flagChoque == 1
					mov posicionMeteoritoDOS, 600
					mov flagHumo, 1
					sub Vidas, 2
				.ENDIF
				mov flagChoque, 0

				;Colision Meteorito 3
				invoke Colision, posX, posY, 100, 100, 350, posicionMeteoritoTRES, 65, 100
				.IF flagChoque == 1
					mov posicionMeteoritoTRES, 600
					mov flagHumo, 1
					dec Vidas
				.ENDIF
				mov flagChoque, 0

				;Colision Meteorito 4
				invoke Colision, posX, posY, 100, 100, 550, posicionMeteoritoCUATRO, 65, 100
				.IF flagChoque == 1
					mov posicionMeteoritoCUATRO, 600
					mov flagHumo, 1
					dec Vidas
				.ENDIF
				mov flagChoque, 0

				;Colision Meteorito 5
				invoke Colision, posX, posY, 100, 100, 700, posicionMeteoritoCINCO, 80, 100
				.IF flagChoque == 1
					mov posicionMeteoritoCINCO, 600
					mov flagHumo, 1
					sub Vidas, 2
				.ENDIF
				mov flagChoque, 0

				;Colision Meteorito 6
				invoke Colision, posX, posY, 100, 100, 870, posicionMeteoritoSEIS, 65, 100
				.IF flagChoque == 1
					mov posicionMeteoritoSEIS, 600
					mov flagHumo, 1
					dec Vidas
				.ENDIF
				mov flagChoque, 0

				;Humo en la nave
				.IF flagHumo == 1
					COPIAR posXHumo, posX 
					add posXHumo, 25
					mov esi, indiceHumo
					shl esi, 3
					invoke SelectObject,hMemDC,hMeteoritoB 				
					invoke BitBlt,hdc,posXHumo,posY,87,92,hMemDC,spriteHumo[esi].x,spriteHumo[esi].y,SRCAND 

					invoke SelectObject,hMemDC,hMeteoritoN				
					invoke BitBlt,hdc,posXHumo,posY,87,92,hMemDC,spriteHumo[esi].x,spriteHumo[esi].y,SRCPAINT 
				.ENDIF

			.ENDIF	
		.ENDIF	

		invoke DeleteDC,hMemDC 
		
	;el end paint cierra el proceso de dibujado 
        invoke EndPaint,hWnd, ADDR ps  
		
	;Se agrega el WM_TIMER a todo el proceso, aqui se atiende el movimiento del indice de
	;los sprites  
	.ELSEIF  uMsg==WM_TIMER
		;Cuando entremos a la escena del juego MENU_OPEN == 2 empieza a dibujar todo
		.IF Menu_open == 2
			inc TimerUNO
			inc TimerDOS
			inc TimerTRES
			inc TimerCUATRO
			inc TimerCINCO
			inc TimerSEIS
			inc timerVidaUNO
			inc timerVidaDOS
			inc TimerShoot
			inc TimerInactividad

			.IF TimerInactividad > 600
				inc Vidas
				.if Vidas >= 3
					mov Vidas,3 
				.endif
				mov TimerInactividad, 0
			.ENDIF



			.IF TimerShoot > 100
				mov flagShootKD, 1		
			.ENDIF

			.IF TimerUNO > 3	
				;Mover el meteorito
				add posicionMeteoritoUNO, 10
				.IF posicionMeteoritoUNO >= 600 
					mov posicionMeteoritoUNO, 50
					mov TimerUNO, 0		
					mov flagMeteoritoUNO, 0
				.ENDIF
				mov flagMeteoritoUNO, 1 ;Prender bandera de dibujado
				;Tiempo de cada dibujado de sprite de meteorito
				inc indiceMeteUNO
				.IF indiceMeteUNO > 2
					inc indiceMeteorito
					.IF indiceMeteorito > 3
						mov indiceMeteorito, 0
					.ENDIF
					mov indiceMeteUNO, 0
				.ENDIF
				mov flagMinaUNO, 0
			.ENDIF

			.IF TimerDOS > 5	
				mov flagMeteoritoDOS, 1 ;Prender bandera de dibujado
				;Mover el meteorito
				add posicionMeteoritoDOS, 15
				.IF posicionMeteoritoDOS >= 600 
					mov posicionMeteoritoDOS, 50
					mov TimerDOS, 0		
					mov flagMeteoritoDOS, 0
				.ENDIF
				;Tiempo de cada dibujado de sprite de meteorito
				inc indiceMeteDOS
				.IF indiceMeteDOS > 3
					inc indiceMinas
					.IF indiceMinas > 1
						mov indiceMinas, 0
					.ENDIF
					mov indiceMeteDOS, 0
				.ENDIF
			.ENDIF

			.IF TimerTRES > 25	
				mov flagMeteoritoTRES, 1 ;Prender bandera de dibujado
				;Mover el meteorito
				add posicionMeteoritoTRES, 15
				.IF posicionMeteoritoTRES >= 600 
					mov posicionMeteoritoTRES, 50
					mov TimerTRES, 0
					mov flagMeteoritoTRES,0
				.ENDIF
				;Tiempo de cada dibujado de sprite de meteorito
				inc indiceMeteTRES
				.IF indiceMeteTRES > 3
					inc indiceMeteorito
					.IF indiceMeteorito > 3
						mov indiceMeteorito, 0
					.ENDIF
					mov indiceMeteTRES, 0
				.ENDIF
			.ENDIF

			.IF TimerCUATRO > 15	
				mov flagMeteoritoCUATRO, 1 ;Prender bandera de dibujado
				;Mover el meteorito
				add posicionMeteoritoCUATRO, 15
				.IF posicionMeteoritoCUATRO >= 600 
					mov posicionMeteoritoCUATRO, 50
					mov TimerCUATRO, 0		
					mov flagMeteoritoCUATRO, 0
				.ENDIF
				;Tiempo de cada dibujado de sprite de meteorito
				inc indiceMeteCUATRO
				.IF indiceMeteCUATRO > 2
					inc indiceMeteorito
					.IF indiceMeteorito > 3
						mov indiceMeteorito, 0
					.ENDIF
					mov indiceMeteCUATRO, 0
				.ENDIF
			.ENDIF

			.IF TimerCINCO > 30
				mov flagMeteoritoCINCO, 1 ;Prender bandera de dibujado
				;Mover el meteorito
				add posicionMeteoritoCINCO, 15
				.IF posicionMeteoritoCINCO >= 600 
					mov posicionMeteoritoCINCO, 50
					mov TimerCINCO, 0			
					mov flagMeteoritoCINCO, 0
				.ENDIF
				;Tiempo de cada dibujado de sprite de meteorito
				inc indiceMeteCINCO
				.IF indiceMeteCINCO > 3
					inc indiceMinasDOS
					.IF indiceMinasDOS > 1
						mov indiceMinasDOS, 0
					.ENDIF
					mov indiceMeteCINCO, 0
				.ENDIF
			.ENDIF

			.IF TimerSEIS > 20	
				mov flagMeteoritoSEIS, 1 ;Prender bandera de dibujado
				;Mover el meteorito
				add posicionMeteoritoSEIS, 15

				.IF posicionMeteoritoSEIS >= 600 
					mov posicionMeteoritoSEIS, 50
					mov TimerSEIS, 0		
					mov flagMeteoritoSEIS, 0
				.ENDIF
				;Tiempo de cada dibujado de sprite de meteorito
				inc indiceMeteSEIS
				.IF indiceMeteSEIS > 2
					inc indiceMeteorito
					.IF indiceMeteorito > 3
						mov indiceMeteorito, 0
					.ENDIF
					mov indiceMeteSEIS, 0
				.ENDIF
			.ENDIF

			;Disparo 
			.IF flagShootDRAW == 1
				sub posYDisparo, 25
 				.IF posYDisparo <= 50
					mov flagShootDRAW, 0
					mov flagShootKD, 0
				.ENDIF

				inc indiceShoot
				.IF indiceShoot > 3
					mov indiceShoot, 0
				.ENDIF
			.ENDIF

			;Vidas obtenibles
			.IF timerVidaUNO > 550
				mov flagVidaUNO, 1 ;Prende bandeja de dibujado
				;Mover la vida
				add posicionVidaUNO, 5
				.IF posicionVidaUNO >= 600
					mov posicionVidaUNO, 50
					mov timerVidaUNO, 0
					mov flagVidaUNO,0
				.ENDIF

				inc velocidadVidadUNO
				.IF velocidadVidadUNO > 3
					inc indiceVidaUNO
					.IF indiceVidaUNO > 3
						mov indiceVidaUNO, 0
					.ENDIF
					mov velocidadVidadUNO, 0
				.ENDIF
			.ENDIF

			.IF timerVidaDOS > 500
				mov flagVidaDOS, 1 ;Prende bandeja de dibujado
				;Mover la vida
				add posicionVidaDOS, 5
				.IF posicionVidaDOS >= 600
					mov posicionVidaDOS, 50
					mov timerVidaDOS, 0
					mov flagVidaDOS,0
				.ENDIF

				inc velocidadVidadDOS
				.IF velocidadVidadDOS > 3
					inc indiceVidaDOS
					.IF indiceVidaDOS > 3
						mov indiceVidaDOS, 0
					.ENDIF
					mov velocidadVidadDOS, 0
				.ENDIF
			.ENDIF

			;Colisiones
			;Colision disparo - meteorito 1
			.IF flagColsionMeteUNO == 1
				;mov flagShootKD, 0				;Apagamos la bandera de dibujado del disparo 
				mov posicionMeteoritoUNO, 600	;y la del meteorito
				inc velocidadExplosion
				.IF velocidadExplosion > 2
					inc indiceExplosion
					.IF indiceExplosion > 3
						mov indiceExplosion, 0
						mov flagColsionMeteUNO, 0
					.ENDIF
					mov velocidadExplosion, 0
				.ENDIF
			.ENDIF

			;Colision disparo - meteorito 2
			.IF flagColsionMeteDOS == 1
				;mov flagShootKD, 0				;Apagamos la bandera de dibujado del disparo 
				mov posicionMeteoritoDOS, 600	;y la del meteorito
				inc velocidadExplosion
				.IF velocidadExplosion > 2
					inc indiceExplosion
					.IF indiceExplosion > 3
						mov indiceExplosion, 0
						mov flagColsionMeteDOS, 0
					.ENDIF
					mov velocidadExplosion, 0
				.ENDIF
			.ENDIF

			;Colision disparo - meteorito 3
			.IF flagColsionMeteTRES == 1
				;mov flagShootKD, 0				;Apagamos la bandera de dibujado del disparo 
				mov posicionMeteoritoTRES, 600	;y la del meteorito
				inc velocidadExplosion
				.IF velocidadExplosion > 2
					inc indiceExplosion
					.IF indiceExplosion > 3
						mov indiceExplosion, 0
						mov flagColsionMeteTRES, 0
					.ENDIF
					mov velocidadExplosion, 0
				.ENDIF		
			.ENDIF

			
			;Colision disparo - meteorito 4
			.IF flagColsionMeteCUATRO == 1
				;mov flagShootKD, 0					;Apagamos la bandera de dibujado del disparo 
				mov posicionMeteoritoCUATRO, 600	;y la del meteorito
				inc velocidadExplosion
				.IF velocidadExplosion > 2
					inc indiceExplosion
					.IF indiceExplosion > 3
						mov indiceExplosion, 0
						mov flagColsionMeteCUATRO, 0
					.ENDIF
					mov velocidadExplosion, 0
				.ENDIF
			.ENDIF

			;Colision disparo - meteorito 5
			.IF flagColsionMeteCINCO == 1
				;mov flagShootKD, 0					;Apagamos la bandera de dibujado del disparo 
				mov posicionMeteoritoCINCO, 600	;y la del meteorito
				inc velocidadExplosion
				.IF velocidadExplosion > 2
					inc indiceExplosion
					.IF indiceExplosion > 3
						mov indiceExplosion, 0
						mov flagColsionMeteCINCO, 0
					.ENDIF
					mov velocidadExplosion, 0
				.ENDIF
			.ENDIF

			;Colision disparo - meteorito 6
			.IF flagColsionMeteSEIS == 1
				;mov flagShootKD, 0					;Apagamos la bandera de dibujado del disparo 
				mov posicionMeteoritoSEIS, 600	;y la del meteorito
				inc velocidadExplosion
				.IF velocidadExplosion > 2
					inc indiceExplosion
					.IF indiceExplosion > 3
						mov indiceExplosion, 0
						mov flagColsionMeteSEIS, 0
					.ENDIF
					mov velocidadExplosion, 0
				.ENDIF
			.ENDIF

			;Humo de la nave al colisionar
			.IF flagHumo == 1
				inc velocidadHumo
				.IF velocidadHumo > 2
					inc indiceHumo
					.IF indiceHumo > 2
						mov indiceHumo, 0
						mov flagHumo, 0
					.ENDIF
					mov velocidadHumo,0
				.ENDIF
			.ENDIF

			;Mover el fondo
			.IF posFondoY > 100
				sub posFondoY, 3
			.ELSEIF
				mov posFondoY, 3000
			.ENDIF
		.ENDIF


			
	    mov dibuja, 0h ; que limpie la bandera de redibujado
		invoke XInputGetState, 0, addr entrada
		mov estado, eax
		mov bl, entrada.Gamepad.bLeftTrigger
		;Derecha
		mov ax, entrada.Gamepad.wButtons
		test ax, XINPUT_GAMEPAD_DPAD_RIGHT
		jnz  derecha
		;Izquierda
		test ax, XINPUT_GAMEPAD_DPAD_LEFT
		jnz	izquierda
		;Arriba
		test ax, XINPUT_GAMEPAD_DPAD_UP
		jnz	arriba
		;Abajo
		test ax, XINPUT_GAMEPAD_DPAD_DOWN
		jnz	abajo
		;Start
		test ax, XINPUT_GAMEPAD_START
		jnz	start
		;A
		test ax, XINPUT_GAMEPAD_A
		jnz	Disparo
		;Back
		test ax, XINPUT_GAMEPAD_BACK
		jnz	Back
		test ax, 1
		jz keyup
		jmp salta2

derecha:
		inc indice
		mov flagTWO, 1
		mov flagONE, 0
		mov ebx, 5
		add posX, 10
		.IF posX == 850  ;es el limite de ventana internamente para que se mueva la nave
			sub Vidas, 1
		.ELSEIF posX > 850
			sub posX, 10
		.ENDIF

		mov dibuja, 0ffh
		jmp salta2

izquierda:
		inc indice
		mov flagONE, 1
		mov flagTWO, 0
		mov ebx, 5
		sub posX, 10
		.IF posX == 20  ;es el limite de ventana internamente para que se mueva la nave
			sub Vidas, 1
		.ELSEIF posX < 5
			add posX, 10			
		.ENDIF

		mov dibuja, 0ffh
		jmp salta2

arriba:
		mov ebx, 5
		sub posY, 10

		.IF posY < 50
			add posY, 10
		.ENDIF
			
		mov dibuja, 0ffh	
		jmp salta2

abajo:
		mov ebx, 5
		add posY, 10

		.IF posY > 425
			sub posY, 10
		.ENDIF
		mov dibuja, 0ffh	
		jmp salta2

start:
		inc Menu_open
		.IF Menu_open > 2
			mov Menu_open, 2
		.ENDIF

		.IF Menu_Open == 2 
			.IF Vidas > 3
				mov GO, 1
			.ENDIF
		.ENDIF
		mov dibuja, 0ffh	
		jmp salta2

Disparo:
		.IF flagShootKD == 1
			COPIAR posXDisparo, posX
			COPIAR posYDisparo, posY
			add posXDisparo, 40
			mov flagShootDRAW, 1
			MOV TimerShoot, 0
			mov flagShootKD, 0
		.ENDIF

		mov dibuja, 0ffh
		jmp salta2
Back:
		call ExitProcess@4
keyup:
		.IF indice != 0
				dec indice
		.ENDIF

salta2: ;Break			
		
	;con esto provocamos que se vuelva dibujar la ventana
	;esta sera la principal area de trabajo en su proyecto
;	.IF indiceTimer < 5 &&  flagControl == 0
;		.IF indice != 0
;			dec indice
;		.ENDIF
;		mov indiceTimer, 0
;	.ENDIF
	
	invoke InvalidateRect, hWnd, NULL, FALSE
	invoke UpdateWindow, hWnd

	.ELSEIF  uMsg==WM_KEYDOWN
		mov eax, wParam

		.IF (ax == 'D')
			inc indice
			mov flagTWO, 1
			mov ebx, 5
			add posX, 10
			.IF posX == 850  ;es el limite de ventana internamente para que se mueva la nave
				sub Vidas, 1
			.ELSEIF posX > 850
				sub posX, 10
			.ENDIF

			mov dibuja, 0ffh
			jmp salta2
		.ELSEIF (ax == 'A')
			inc indice
			mov flagONE, 1
			mov ebx, 5
			sub posX, 10
			.IF posX == 20  ;es el limite de ventana internamente para que se mueva la nave
				sub Vidas, 1
			.ELSEIF posX < 5
				add posX, 10			
			.ENDIF

			mov dibuja, 0ffh
			jmp salta2

		.ELSEIF (ax == 'W')
			mov ebx, 5
			sub posY, 10

			.IF posY < 50
				add posY, 10
			.ENDIF
				
			mov dibuja, 0ffh	
			jmp salta2

		.ELSEIF (ax == 'S')
			mov ebx, 5
			add posY, 10

			.IF posY > 425
				sub posY, 10
			.ENDIF
			mov dibuja, 0ffh	
			jmp salta2
			
		.ELSEIF (ax == 13) ;Enter
			inc Menu_open
			.IF Menu_open > 2
				mov Menu_open, 2
			.ENDIF

			.IF Menu_Open == 2 
				.IF Vidas > 3
					mov GO, 1
				.ENDIF
			.ENDIF

			.if flagMB == 1
				;invoke MessageBoxA, hWnd, SCORE, addr Puntuacion, MB_OK
				mov flagMB, 0
			.endif
			mov dibuja, 0ffh	
			jmp salta2

		.ELSEIF (ax == 32) ;Espacio
			;inc flagShootKD
		
			.IF flagShootKD == 1
				COPIAR posXDisparo, posX
				COPIAR posYDisparo, posY
				add posXDisparo, 40
				mov flagShootDRAW, 1
				MOV TimerShoot, 0
				mov flagShootKD, 0
			.ENDIF

			mov dibuja, 0ffh
			jmp salta2

		.ELSEIF (ax == 27); ESC
			
			call ExitProcess@4
		.ENDIF
		
    .ELSE 	
        invoke DefWindowProcA,hWnd2,uMsg,wParam,lParam   
	
        ret 
    .ENDIF 
	
    xor eax,eax 
	ret 
WndProc endp

Colision proc puntoUNOx:DWORD, puntoUNOy:DWORD, anchoUNO:DWORD, altoUNO:DWORD, puntoDOSx:DWORD, puntoDOSy:DWORD, anchoDOS:DWORD, altoDOS:DWORD
	push eax
	push ebx
	push ecx
	push edx

	xor eax, eax
	xor ebx, ebx
	xor ecx, ecx
	xor edx, edx

	;ASSUME eax: DWORD
	;ASSUME ebx: DWORD

	mov eax, puntoUNOx
	mov ebx, puntoDOSx

	cmp eax, ebx ;p1x >= p2x
	jge segundoAND
	jmp quintoAND

	segundoAND:
		mov ecx, anchoDOS
		add ecx, ebx
		cmp eax, ecx ;p1x < p2x + ancho2
		jb tercerAND
		jmp quintoAND

	tercerAND:
		mov eax, puntoUNOy
		mov ebx, puntoDOSy

		cmp eax, ebx ;p1y >= p2y
		jge cuartoAND
		jmp quintoAND

	cuartoAND:
		mov edx, altoDOS
		add edx, ebx 
		cmp eax, edx ;p1y < p2y + alto2
		jb Choque
		jmp quintoAND

	quintoAND: ;OR
		mov eax, puntoUNOx
		mov ebx, puntoDOSx

		cmp ebx, eax ;p2x >= p1x
		jge sextoAND
		jmp novenoAND

	sextoAND:
		mov ecx, anchoUNO
		add ecx, eax
		cmp ebx, ecx ;p2x < p1x+ ancho1
		jb septimoAND
		jmp novenoAND

	septimoAND:
		mov eax, puntoUNOy
		mov ebx, puntoDOSy

		cmp ebx, eax ;p2y >= p1y
		jge octavoAND
		jmp novenoAND

	octavoAND:
		mov edx, altoUNO
		add edx, eax
		cmp ebx, edx ;p2y < p1y + alto1
		jb Choque
		jmp novenoAND

	novenoAND:
		mov eax, puntoUNOx
		mov ebx, puntoDOSx

		cmp eax, ebx
		jge decimoAND
		jmp terceavoAND

	decimoAND:
		mov ecx, anchoDOS
		add ecx, ebx
		cmp eax, ecx
		jb onceavoAND
		jmp terceavoAND

	onceavoAND:
		mov eax, puntoUNOy
		mov ebx, puntoDOSy

		cmp ebx, eax
		jge doceavoAND
		jmp terceavoAND

	doceavoAND:
		mov edx, altoUNO
		add edx, eax
		cmp ebx, edx
		jb Choque
		jmp terceavoAND

	terceavoAND:
		mov eax, puntoUNOx
		mov ebx, puntoDOSx

		cmp ebx, eax
		jge catorceavoAND
		jmp noChoque

	catorceavoAND:
		mov ecx, anchoUNO
		add ecx, eax
		cmp ebx, ecx
		jb quinceavoAND
		jmp noChoque

	quinceavoAND:
		mov eax, puntoUNOy
		mov ebx, puntoDOSy

		cmp eax, ebx
		jge diesisexeavoAND
		jmp noChoque

	diesisexeavoAND:
		mov edx, altoDOS
		add edx, ebx
		cmp eax, edx
		jb Choque
		jmp noChoque

	Choque:
		mov flagChoque, 1
	noChoque:
		pop eax
		pop ebx
		pop ecx
		pop edx
	ret
Colision endp

end main

