  ; DESENVOLVIDO POR EVERTON P. CRUZ
  ; COM O PROPOSITO DE USO BASE PARA OS EPISODIOS
  ; DA SERIE CONHECENDO O MICROCONTROLADOR PIC16F628A
  #INCLUDE <P16F628A.INC>
  LIST P=16F628A
  __CONFIG _BODEN_ON & _MCLRE_ON & _LVP_OFF & _WDT_OFF & INTOSC & _CP_OFF & _PWRTE_ON
  
  ORG   0x00
  GOTO  SETUP

  ORG   0x04
  BTFSC INTCON, T0IF       ; testa se interrupcao ocorreu por causa de Timer0
  GOTO  TRATAMENTO_TIMER0  ; se sim, salta p/ tratamento Timer0
  GOTO  SAI_INTERRUPCOES
TRATAMENTO_TIMER0:
  BCF   INTCON, T0IF       ; desliga flag
  MOVLW .219               ; 256 - 37 = 219
  MOVWF TMR0               ; atualiza TMR0
  BSF   PORTB, RB3         ; liga led em RB3 - quantidade satisfeita
  BCF   PORTB, RB2         ; desliga led em RB2
  CLRW                     ; limpa registrador W
  GOTO  SAI_INTERRUPCOES

  ;...

SAI_INTERRUPCOES:
  ; restaura valores de W e STATUS

SETUP:
  BCF  STATUS, RP1         ; episodio 3 - selecao de banco de memoria 1
  BSF  STATUS, RP0         ; episodio 3 - selecao de banco de memoria 1

  BSF  OPTION_REG, T0CS    ; fonte de incremento externo no pino RA4/T0CKI
  BCF  OPTION_REG, T0SE    ; incremento na transicao de nivel baixa 
                           ; para alto no pino RA4/T0CKI

  BSF  OPTION_REG, PSA     ; Prescaler nao atribuido ao Timer0,
                           ; entao a relacao eh 1:1

  BSF  PORTA, RA4          ; episodio 4 - RA4 eh um pino de entrada
  BCF  PORTB, RB2          ; episodio 4 - RB2 eh um pino de saida
  BCF  PORTB, RB3          ; episodio 4 - RB3 eh um pino de saida

  BCF  STATUS, RP0         ; selecao do banco de memoria 0

  MOVLW .219               ; 256 - 37 = 219
  MOVWF  TMR0              ; atualiza o registrador TMR0

  BSF  PORTB, RB2          ;  liga led de estado de não completo a contagem
  BCF  PORTB, RB3          ;  desliga led de estado de completo a contagem

  MOVLW 0x07               ; 0x07 = 0000.0111 (desliga modulo comparador)
  MOVWF CMCON              ; episodio 20 - desligando o modulo comparador

  BSF INTCON, T0IE         ; ativa a interrupcao do Timer0
  BSF INTCON, GIE          ; ativa a chave geral das interrupcoes

  CLRW

MAIN:
  XORWF   TMR0, 0         ; se igual, z=1, senao z=0
  BTFSC   STATUS, Z
  GOTO    MAIN
  BSF     PORTB, RB2
  BCF     PORTB, RB3
  GOTO    MAIN

  END