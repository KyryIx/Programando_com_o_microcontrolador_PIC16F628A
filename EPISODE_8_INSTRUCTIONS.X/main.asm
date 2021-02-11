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
; INSTRUCAO: ADDLW                                                             ;
; ADICIONA UM LITERAL (NUMERO) AO CONTEUDO DO REG. W                           ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  MOVLW   .5
  ADDLW   .4 ; O RESULTADO ARMAZENADO EM W SERA 9

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INSTRUCAO: ADDLW                                                             ;
; ADICIONA UM LITERAL (NUMERO) AO CONTEUDO DO REG. W                           ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  MOVLW   .254
  ADDLW   .4 ; O RESULTADO ARMAZENADO EM W SERA 2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INSTRUCAO: ADDLW                                                             ;
; ADICIONA UM LITERAL (NUMERO) AO CONTEUDO DO REG. W                           ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  MOVLW   .253
  ADDLW   .3 ; O RESULTADO ARMAZENADO EM W SERA 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INSTRUCAO: ADDLW                                                             ;
; ADICIONA UM LITERAL (NUMERO) AO CONTEUDO DO REG. W                           ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  MOVLW   .31
  ADDLW   .1 ; O RESULTADO ARMAZENADO EM W SERA 32

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INSTRUCAO: ADDWF                                                             ;
; ADICIONA O CONTEUDO DO REG. W AO CONTEUDO DO REG. f E COLOCA EM d            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  MOVLW   .5
  MOVWF   0x0C
  MOVLW   .4
  ADDWF   0x0C, 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INSTRUCAO: SUBLW                                                             ;
; SUBTRAI CONTEUDO DO REG. W DO LITERAL (NUMERO) E  ARMAZENA NO REG. W         ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  MOVLW   .15
  SUBLW   .7

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INSTRUCAO: SUBLW                                                             ;
; SUBTRAI CONTEUDO DO REG. W DO LITERAL (NUMERO) E  ARMAZENA NO REG. W         ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  MOVLW   .7
  SUBLW   .15

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INSTRUCAO: SUBWF                                                             ;
; SUBTRAI CONTEUDO DO REG. W DO CONTEUDO DO REG. f E COLOCA EM d               ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  MOVLW   .15
  MOVWF   0x0C
  MOVLW   .7
  SUBWF   0x0C, 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INSTRUCAO: ANDLW                                                             ;
; APLICA O OPERADOR 'AND' AO LITERAL (NUMERO) E TAMBEM                         ;
; AO CONTEUDO DO REG. W E O RESULTADO ARMAZENA NO REG. W                       ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  MOVLW   .7
  ANDLW   .10

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INSTRUCAO: ANDWF                                                             ;
; APLICA O OPERADOR 'AND' AO CONTEUDO DO REG. W E                              ;
; CONTEUDO DO REG. f E COLOCA EM d                                             ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  MOVLW   .7
  MOVWF   0x0C
  MOVLW   .10
  ANDWF   0x0C, 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INSTRUCAO: IORLW                                                             ;
; APLICA O OPERADOR 'OR' INCLUSIVO AO LITERAL (NUMERO)                         ;
; E TAMBEM AO CONTEUDO DO REG. W E O RESULTADO ARMAZENA NO REG. W              ;
  MOVLW   .7
  IORLW   .10

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INSTRUCAO: IORWF                                                             ;
; APLICA O OPERADOR OR (inclusivo) AO CONTEUDO DO REG. W                       ;
; E CONTEUDO DO REG. f E COLOCA EM d                                           ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  MOVLW   .7
  MOVWF   0x0C
  MOVLW   .10
  IORWF   0x0C, 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INSTRUCAO: XORLW                                                             ;
; APLICA O OPERADOR OR (exclusivo) NO LITERAL (NUMERO)                         ;
; E NO CONTEUDO DO REG. W E ARMAZENA EM REG. W                                 ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  MOVLW   .7
  XORLW   .10

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INSTRUCAO: XORWF                                                             ;
; APLICA O OPERADOR OR (exclusivo) AO CONTEUDO DO REG. W                       ;
; E CONTEUDO DO REG. f E COLOCA EM d                                           ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  MOVLW   .7
  MOVWF   0x0C
  MOVLW   .10
  XORWF   0x0C, 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INSTRUCAO: COMF                                                              ;
; APLICA O OPERADOR COMPLEMENTO AO CONTEUDO DO REG. f E COLOCA EM d            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  MOVLW   .7
  MOVWF   0x0C
  COMF    0x0C, 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INSTRUCAO: INCFSZ                                                            ;
; INCREMENTA O CONTEUDO DO REGISTRADOR f E ARMAZENA EM d                       ;
; SALTA UMA INSTRUCAO SER FOR ZERO                                             ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  MOVLW   .254      ;
  MOVWF   0x0C      ;
  INCFSZ  0x0C, 0   ; >---+
                    ;     |
  CLRW              ; <---+
                    ;
  CLRF    0x0C      ;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INSTRUCAO: INCFSZ                                                            ;
; INCREMENTA O CONTEUDO DO REGISTRADOR f E ARMAZENA EM d                       ;
; SALTA UMA INSTRUCAO SER FOR ZERO                                             ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  MOVLW   .255      ;
  MOVWF   0x0C      ;
  INCFSZ  0x0C, 0   ; >---+
                    ;     |
  CLRW              ;     |
                    ;     |
  CLRF    0x0C      ; <---+

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INSTRUCAO: DECF                                                              ;
; DECREMENTA O CONTEUDO DO REGISTRADOR f E ARMAZENA EM d                       ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  MOVLW   .7
  MOVWF   0x0C
  DECF    0x0C, 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INSTRUCAO: DECFSZ                                                            ;
; DECREMENTA O CONTEUDO DO REGISTRADOR f E ARMAZENA EM d                       ;
; SALTA UMA INSTRUCAO SER FOR ZERO                                             ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  MOVLW   .9        ;
  MOVWF   0x0C      ;
  DECFSZ  0x0C, 0   ; >---+
                    ;     |
  CLRW              ; <---+
                    ;
  CLRF    0x0C      ;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INSTRUCAO: DECFSZ                                                            ;
; DECREMENTA O CONTEUDO DO REGISTRADOR f E ARMAZENA EM d                       ;
; SALTA UMA INSTRUCAO SER FOR ZERO                                             ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  MOVLW   .1        ;
  MOVWF   0x0C      ;
  DECFSZ  0x0C, 0   ; >---+
                    ;     |
  CLRW              ;     |
                    ;     |
  CLRF    0x0C      ; <---+

    
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