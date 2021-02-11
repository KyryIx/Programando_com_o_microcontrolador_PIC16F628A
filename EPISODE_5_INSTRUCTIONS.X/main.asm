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
; INSTRUCAO: GOTO                                                              ;
; VAI PARA UM ENDERECO/ROTULO DE MEMORIA DE PROGRAMA                           ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TESTEBOTAOPRESSIONADO:           ; <-----------+
                                 ;             |
  BTFSS   PORTA, RA0             ; >--+--+     |
                                 ;    |  |     |
  GOTO    TESTEBOTAOPRESSIONADO  ; <--+  |  >--+
                                 ;       |
  NOP                            ; <-----+
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INSTRUCAO: MOVLW                                                             ;
; MOVE (COLOCA) O LITERAL (NUMERO) NO REGISTRADOR W OU MELHOR DIZENDO          ;
; ARMAZENA O LITERAL (NUMERO) NO REGISTRADOR W                                 ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  MOVLW  B'00001011' ; ARMAZENA O LITERAL 13 (1011) NO REGISTRADOR W
  MOVLW  O'14'       ; SOBRESCREVE O VALOR 11 PELO VALOR 12 NO REG. W
  MOVLW  D'10'       ; SOBRESCREVE O VALOR 12 PELO VALOR 10 NO REG. W
  MOVLW  .10         ; SOBRESCREVE O VALOR 10 PELO VALOR 10 NO REG. W
  MOVLW  H'0B'       ; SOBRESCREVE O VALOR 10 PELO VALOR 11 NO REG. W
  MOVLW  0x0B        ; SOBRESCREVE O VALOR 11 PELO VALOR 11 NO REG. W
  MOVLW  A'%'        ; SOBRESCREVE O VALOR 12 PELO CARACTER % NO REG. W
                     ; O CARACTER EH SUBSTITUIDO PELO BYTE DA TAB. ASCII
  MOVLW  '#'         ; SOBRESCREVE CARACTER % POR CARACTER # NO REG. W
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INSTRUCAO: MOVWF                                                             ;
; MOVE O CONTEUDO DE W P/ O REGISTRADOR DE ENDERECO 0x0C                       ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  MOVWF   0x0C

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INSTRUCAO: MOVF                                                              ;
; MOVE O CONTEUDO DO REGISTRADOR STATUS PARA W                                 ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  MOVF   STATUS, 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INSTRUCAO: BCF                                                               ;
; LIMPA O BIT b DO REGISTRADOR f                                               ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  MOVLW   .197
  MOVWF   0x0C
  BCF     0x0C, 6 ; LIMPA O SEXTO BIT DO REGISTRADOR DE ENDERECO 0x0C
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INSTRUCAO: BSF                                                               ;
; SETA O BIT b DO REGISTRADOR f                                                ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  MOVLW   .197
  MOVWF   0x0C
  BSF     0x0C, 4 ; SETA O QUARTO BIT DO REGISTRADOR DE ENDERECO 0x0C

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INSTRUCAO: BTFSC                                                             ;
; TESTA SE O BIT b DO REGISTRADOR f ESTA limpo (valor 0)                       ;
; SE ESTIVER limpo (valor 0) SALTA A PROXIMA INSTRUCAO                         ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  MOVLW   .197      ; 197 DECIMAL = 1100.0101 BINARIO
  MOVWF   0x0C      ; 
                    ; 
  BTFSC   0x0C, 5   ; BIT NA POSICAO 5 EH ZERO >---+
                    ;                              |
  NOP               ;                              |
                    ;                              |
  NOP               ; <----------------------------+

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INSTRUCAO: BTFSC                                                             ;
; TESTA SE O BIT b DO REGISTRADOR f ESTA limpo (valor 0)                       ;
; SE ESTIVER limpo (valor 0) SALTA A PROXIMA INSTRUCAO                         ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  MOVLW   .197      ; 197 DECIMAL = 1100.0101 BINARIO
  MOVWF   0x0C      ; 
                    ; 
  BTFSC   0x0C, 2   ; BIT NA POSICAO 2 EH UM >----+
                    ;                             |
  NOP               ; <---------------------------+
                    ; 
  NOP               ;
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INSTRUCAO: BTFSS                                                             ;
; TESTA SE O BIT b DO REGISTRADOR f ESTA setado (valor 1)                      ;
; SE ESTIVER setado (valor 1) SALTA A PROXIMA INSTRUCAO                        ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  MOVLW   .197      ; 197 DECIMAL = 1100.0101 BINARIO
  MOVWF   0x0C      ;
                    ;
  BTFSS   0x0C, 5   ; BIT NA POSICAO 5 EH ZERO >--+
                    ;                             |
  NOP               ; <---------------------------+
                    ;
  NOP               ;
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INSTRUCAO: BTFSC                                                             ;
; TESTA SE O BIT b DO REGISTRADOR f ESTA setado (valor 1)                      ;
; SE ESTIVER setado (valor 1) SALTA A PROXIMA INSTRUCAO                        ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  MOVLW   .197      ; 197 DECIMAL = 1100.0101 BINARIO
  MOVWF   0x0C      ;
                    ;
  BTFSS   0x0C, 2   ; BIT NA POSICAO 2 EH UM >----+
                    ;                             |
  NOP               ;                             |
                    ;                             |
  NOP               ; <---------------------------+
  
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