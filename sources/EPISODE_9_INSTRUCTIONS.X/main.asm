  ; DESENVOLVIDO POR EVERTON P. CRUZ
  ; COM O PROPOSITO DE USO BASE PARA OS EPISODIOS
  ; DA SERIE CONHECENDO O MICROCONTROLADOR PIC16F628A
  #INCLUDE <P16F628A.INC>
  LIST P=16F628A
  __CONFIG _BOREN_ON & _CP_OFF & _PWRTE_ON & _WDT_OFF & _LVP_OFF & _MCLRE_OFF & _INTRC_OSC_NOCLKOUT
    
  ORG     0x00       ; TRATAMENTO DO RESET
  GOTO    SETUP_PROCESSO

  ORG     0x04       ; TRATAMENTO DAS INTERRUPCOES
  RETFIE
    
SETUP_PROCESSO:
  BCF     STATUS, RP1
  BSF     STATUS, RP0 ; SELECIONA O BANCO 1 DE MEMORIA

  BSF	PCON, OSCF    ; CONF. FREQÜÊNCIA DO OSCILADOR INTERNO EM 4 MHz
  
  MOVLW	B'10000000'
  ; 1 - NOT_RBPU    -> DESATIVA RESISTORES PULL-UP
  ; 0 - INTDEG      -> INT. ATIV. BORDA DE DESCIDA RB0
  ; 0 - TOCS        -> O CLOCK DO TIMER 0 EH INTERNO
  ; 0 - TOSE        -> BORDA DE SUBIDA NO TIMER 0, RA4
  ; 0 - PSA         -> PRESCALER ASSOCIADO AO TIMER 0
  ; 0 - PS2,PS1,PS0 -> TIMER 0 COM RAZAO 1:2
  MOVWF   OPTION_REG ; CONFIGURACOES DO REGISTRADOR OPTION
    
  MOVLW   B'11111111'
  ; 1 - PINO RA7 COMO ENTRADA
  ; 1 - PINO RA6 COMO ENTRADA
  ; 1 - PINO RA5 COMO ENTRADA
  ; 1 - PINO RA4 COMO ENTRADA
  ; 1 - PINO RA3 COMO ENTRADA
  ; 1 - PINO RA2 COMO ENTRADA
  ; 1 - PINO RA1 COMO ENTRADA
  ; 1 - PINO RA0 COMO ENTRADA
  MOVWF   TRISA ; MODIFICA O COMPORTAMENTO DA PORTA
    
  MOVLW   B'11111111'
  ; 1 - PINO RB7 COMO ENTRADA
  ; 1 - PINO RB6 COMO ENTRADA
  ; 1 - PINO RB5 COMO ENTRADA
  ; 1 - PINO RB4 COMO ENTRADA
  ; 1 - PINO RB3 COMO ENTRADA
  ; 1 - PINO RB2 COMO ENTRADA
  ; 1 - PINO RB1 COMO ENTRADA
  ; 1 - PINO RB0 COMO ENTRADA
  MOVWF   TRISB ; MODIFICA O COMPORTAMENTO DA PORTB    
    
  BCF     STATUS, RP1
  BCF     STATUS, RP0 ; SELECIONA O BANCO 0 DE MEMORIA
    
  MOVLW   B'00000111'
  MOVWF   CMCON ; DEFINE O MODO DE OPERACAO DO COMP. ANALOG. DESLIGADOS
    
  MOVLW   B'00000000'  
  ; 0 - GIE  -> DESATIVA INT./CHAVE GERAL
  ; 0 - EEIE -> DESATIVA INT. DA EEPROM
  ; 0 - T0IE -> DESATIVA INT. NO TMR0
  ; 0 - INTE -> DESATIVA INT. NO RB0/INT
  ; 0 - RBIE -> DESATIVA INT. MUDANCA RB<7:4>
  ; 0 - T0IF -> FLAG DE TRANSBORDO DO TMR0
  ; 0 - INTF -> FLAG DE RESPOSTA INT. RB0/INT
  ; 0 - RBIF -> FLAG DE RESPOSTA INT EM RB<7:4>
  MOVWF   INTCON ; CONFIGURACOES DE INTERRUPCOES
    
PROGRAMAPRINCIPAL:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INSTRUCAO: CLRF                                                              ;
; LIMPA O REGISTRADOR f                                                        ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  MOVLW   .7
  MOVWF   0x0C
  CLRF    0x0C

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INSTRUCAO: CLRW                                                              ;
; LIMPA O REGISTRADOR W                                                        ;
  MOVLW   .7
  MOVWF   0x0C
  CLRF    0x0C
  CLRW

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INSTRUCAO: RLF                                                               ;
; APLICA O OPERADOR DE ROTACAO A ESQUERDA SOBRE O                              ;
; CONTEUDO DO REG. f E COLOCA EM d                                             ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  BCF     STATUS, C
  MOVLW   .197
  MOVWF   0x0C
  RLF     0x0C, 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INSTRUCAO: RRF                                                               ;
; APLICA O OPERADOR DE ROTACAO A DIREITA SOBRE O                               ;
; CONTEUDO DO REG. f E COLOCA EM d                                             ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  BCF     STATUS, C
  MOVLW   .197
  MOVWF   0x0C
  RRF     0x0C, 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INSTRUCAO: SWAPF                                                             ;
; TROCA OS NIBBLES (GRUPO DE 4 BITS) MAIS SIGNIFICATIVO                        ;
; PARA O MENOS SIGNIFICATIVO SOBRE O CONTEUDO DO REG. f E COLOCA EM d          ;
  MOVLW   .197
  MOVWF   0x0C
  SWAPF   0x0C, 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INSTRUCAO: NOP                                                               ;
; EXECUTA UM CICLO DE MAQUINA. NAO PROCESSA NENHUM                             ;
; CALCULO ARITMETICO OU LOGICO                                                 ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  NOP

  
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  GOTO    PROGRAMAPRINCIPAL  
  END