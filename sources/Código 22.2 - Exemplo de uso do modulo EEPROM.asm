    ; CONFIGURACOES INICIAS
    ; D:\Program Files (x86)\Microchip\MPLABX\v5.30\mpasmx\p16f628a.inc
    ; D:\Program Files (x86)\Microchip\xc8\v2.10\mpasmx\p16f628a.inc
    #INCLUDE <P16F628A.INC>
    LIST P=16F628A
    ; REGISTER 14-1: CONFIGURATION WORD REGISTER
    ;    CP: Flash Program Memory Code Protection bit
    ;   LVP: Low-Voltage Programming Enable bit
    ; BOREN: Brown-out Reset Enable bit
    ; MCLRE: RA5/MCLR/V PP Pin Function Select bit
    ; PWRTE: Power-up Timer Enable bit
    ;  WDTE: Watchdog Timer Enable bit
    ;    XT: Max 4 MHz crystal
    __CONFIG _BODEN_ON & _MCLRE_ON & _LVP_OFF & _WDT_OFF & _XT_OSC & _CP_OFF & _PWRTE_ON
    
    #DEFINE W_TEMP      0x20
    #DEFINE STATUS_TEMP 0x21
    #DEFINE END_EEPROM  0x22
    #DEFINE VAL_EEPROM  0x23
    #DEFINE CONTADOR1   0x24
    #DEFINE CONTADOR2   0x25
    #DEFINE CONTADOR3   0x26

    ORG     0x00        ; TRATAMENTO DO RESET
    GOTO    INICIAPARAMETROS

    ORG     0x04        ; TRATAMENTO DAS INTERRUPCOES
    MOVWF   W_TEMP
    SWAPF   STATUS, 0
    MOVWF   STATUS_TEMP

    BTFSS   INTCON, T0IF ; INTERRUPCAO MUD. ESTADOS TRATADA NA SECAO 6.0
    GOTO    TEST_INT_EEPROM
    BCF     INTCON, T0IF
    INCFSZ  CONTADOR1, 1
    GOTO    SAIDA_INTERRUPCAO
    INCFSZ  CONTADOR2, 1
    GOTO    SAIDA_INTERRUPCAO
    INCF    CONTADOR3, 1
    GOTO    SAIDA_INTERRUPCAO

TEST_INT_EEPROM:
    ; demorou para processar a escrita em
    ; CONTADOR1 * "16^2" + TMR0 = 23 * 256 + 160 = 6048 ciclos
    ;                                            = 6.048 ms (usando OSC 4 MHz)
    BTFSS   PIR1, EEIF ; INTERRUPCAO MUD. ESTADOS TRATADA NA SECAO 13.0
    GOTO    SAIDA_INTERRUPCAO
    BCF     PIR1, EEIF
    ; The user should keep the WREN bit clear at all times, except when updating
    ; EEPROM. The WREN bit is not cleared by hardware.
    ; After a write sequence has been initiated, clearing the WREN bit will not 
    ; affect this write cycle. The WR bit will be inhibited from being set 
    ; unless the WREN bit is set.
    BCF     STATUS, RP1
    BSF     STATUS, RP0  ; SELECIONA O BANCO 1 DE MEMORIA
    BCF     EECON1, WREN ; LIMPA BIT PARA ESCRITA NA EEPROM
    BCF     STATUS, RP1
    BCF     STATUS, RP0  ; SELECIONA O BANCO 0 DE MEMORIA

    CALL    LE_EEPROM
    NOP
    ;
    ; LINHAS PARA TRATAMENTO DA INTERRUPCAO
    ;
SAIDA_INTERRUPCAO:
    SWAPF   STATUS_TEMP, 0
    MOVWF   STATUS
    MOVF    W_TEMP, 0
    RETFIE

INICIAPARAMETROS:
    BCF     STATUS, RP1
    BSF     STATUS, RP0  ; SELECIONA O BANCO 1 DE MEMORIA

    MOVLW   B'10001000' ; CONFIGURACOES DO REGISTRADOR OPTION
    ;       1 - 'RBPU       -> DESATIVA RESISTORES PULL-UP
    ;       0 - INTDEG      -> INT. ATIV. BORDA DE DESCIDA RB0
    ;       0 - TOCS        -> O CLOCK DO TIMER 0 EH INTERNO
    ;       0 - TOSE        -> BORDA DE SUBIDA NO TIMER 0, RA4
    ;      (0)- PSA         -> PRESCALER ASSOCIADO AO TIMER 0
    ;      (1)              -> PRESCALER ASSOCIADO AO WDT
    ;       0 - PS2,PS1,PS0 -> TIMER 0 COM RAZAO 1:1
    MOVWF   OPTION_REG

    MOVLW   B'10000000' ; CONFIGURACOES REG. DE INTERRUPCAO DE PERIFERICOS
    ;       0 - EEIE   -> ATIVA INT. ESCRITA COMPLETA EEPROM
    ;       0 - CMIE   -> DESATIVA INT. DO COMPARADOR
    ;       0 - RCIE   -> DESATIVA INT. DO USART
    ;       0 - TXIE   -> DESATIVA INT. DE TRASMISSAO DO USART
    ;       0 -        -> Unimplemented: Read as ?0?
    ;       0 - CCP1IE -> DESATIVA INT. NO MODULO CCP1
    ;       0 - TMR2IE -> DESATIVA INT. TMR2 PARA PR2
    ;       0 - TMR1IE -> DESATIVA INT POR OVERFLOW EM TMR1
    MOVWF   PIE1

    MOVLW   B'11111111' ; CONFIGURAÇÕES DO TRISA
    ;       1 - PINO RA7 COMO ENTRADA
    ;       1 - PINO RA6 COMO ENTRADA
    ;       1 - PINO RA5 COMO ENTRADA
    ;       1 - PINO RA4 COMO ENTRADA
    ;       1 - PINO RA3 COMO ENTRADA
    ;       1 - PINO RA2 COMO ENTRADA
    ;       1 - PINO RA1 COMO ENTRADA
    ;       1 - PINO RA0 COMO ENTRADA
    MOVWF   TRISA  ; MODIFICA O COMPORTAMENTO DA PORTA

    MOVLW   B'11111111' ; CONFIGURAÇÕES DO TRISB
    ;       1 - PINO RB7 COMO ENTRADA
    ;       1 - PINO RB6 COMO ENTRADA
    ;       1 - PINO RB5 COMO ENTRADA
    ;       1 - PINO RB4 COMO ENTRADA
    ;       1 - PINO RB3 COMO ENTRADA
    ;       1 - PINO RB2 COMO ENTRADA
    ;       1 - PINO RB1 COMO ENTRADA
    ;       1 - PINO RB0 COMO ENTRADA
    MOVWF   TRISB  ; MODIFICA O COMPORTAMENTO DA PORTB

    BCF     STATUS, RP1
    BCF     STATUS, RP0  ; SELECIONA O BANCO 0 DE MEMORIA

    ; CMCON - COMPARATOR CONFIGURATION REGISTER
    ;         C2OUT   -> ESTADO DO BIT DA SAIDA DO COMPARADOR 2
    ;         C1OUT   -> ESTADO DO BIT DA SAIDA DO COMPARADOR 1
    ;         C2INV   -> ESTADO INVERSO DO BIT DA SAIDA DO COMPARADOR 2
    ;         C1INV   -> ESTADO INVERSO DO BIT DA SAIDA DO COMPARADOR 1
    ;         CIS     -> COMUTA A ENTRADA DO COMPARADOR DEPENDENDO DA CONFIGURACAO
    ;         CM<2:0> -> BITS DE CONFIGURACAO DOS MODOS DOS COMPARADOES
    ;            000 - Comparators Reset (POR Default Value)
    ;            111 - Comparators Off
    ;            100 - Two Independent Comparators
    ;            010 - Four Inputs Multiplexed to Two Comparators
    ;            011 - Two Common Reference Comparators
    ;            110 - Two Common Reference Comparators with Outputs
    ;            101 - One Independent Comparator
    ;            001 - Three Inputs Multiplexed to Two Comparators
    MOVLW   B'00000111'  ; DEFINE O COMPORTAMENTO DOS COMPARADORES
    MOVWF   CMCON

    MOVLW   B'11100000'  ; CONFIGURACOES DE INTERRUPCOES
    ;       1 - GIE  -> ATIVA INT./CHAVE GERAL
    ;       1 - PEIE -> ATIVA INT. DOS PERIFERICOS
    ;       1 - T0IE -> ATIVA INT. NO TMR0
    ;       0 - INTE -> DESATIVA INT. NO RB0/INT
    ;       0 - RBIE -> DESATIVA INT. MUDANCA RB<7:4>
    ;       0 - T0IF -> FLAG DE TRANSBORDO DO TMR0
    ;       0 - INTF -> FLAG DE RESPOSTA INT. RB0/INT
    ;       0 - RBIF -> FLAG DE RESPOSTA INT EM RB<7:4>
    MOVWF   INTCON

    CLRF    END_EEPROM
    CLRF    VAL_EEPROM

    MOVLW   0xDB
    MOVWF   VAL_EEPROM

    CALL    ESCREVE_EEPROM
PROGRAMAPRINCIPAL:
    NOP
    GOTO    PROGRAMAPRINCIPAL

;;;
; EEDATA ? EEPROM DATA REGISTER (ADDRESS: 9Ah)
; bit 7-0 EEDATn:
;         Byte value to Write to or Read from data EEPROM memory location.
;
; EEADR ? EEPROM ADDRESS REGISTER (ADDRESS: 9Bh)
; bit 7 PIC16F627A/628A
;         Unimplemented Address: Must be set to '0'
; bit 6-0 EEADR:
;         Specifies one of 128 locations of EEPROM Read/Write Operation
;    
; EECON1 ? EEPROM CONTROL REGISTER 1 (ADDRESS: 9Ch)
; bit 7-4 Unimplemented: Read as '0'
; bit 3 WRERR:
;       EEPROM Error Flag bit
;       1 = A write operation is prematurely terminated (any MCLR Reset, any WDT
;           Reset during normal operation or BOR Reset)
;       0 = The write operation completed
; bit 2 WREN:
;       EEPROM Write Enable bit
;       1 = Allows write cycles
;       0 = Inhibits write to the data EEPROM
; bit 1 WR:
;       Write Control bit
;       1 = initiates a write cycle. (The bit is cleared by hardware once write 
;           is complete. The WR bit can only be set (not cleared) in software.
;       0 = Write cycle to the data EEPROM is complete
; bit 0 RD:
;       Read Control bit
;       1 = Initiates an EEPROM read (read takes one cycle. RD is cleared in 
;           hardware. The RD bit can only be set (not cleared) in software).
;       0 = Does not initiate an EEPROM read
LE_EEPROM:
    ; 13.3 Reading the EEPROM Data Memory
    BCF     STATUS, RP1
    BCF     STATUS, RP0   ; SELECIONA BANCO 0

    MOVF    END_EEPROM, 0 ; COLOCA ENDERECO EM W

    BCF     STATUS, RP1
    BSF     STATUS, RP0   ; SELECIONA BANCO 1

    MOVWF   EEADR         ; COLOCA O ENDERECO NO REG. EEADR
    CLRF    EEDATA        ; LIMPA O REGISTRADOR EEDATA
    BSF     EECON1, RD    ; CONFIGURA A LEITURA DO DADO NO ENDERECO EM EEADR
    MOVF    EEDATA, 0     ; COLOCA O DADO LIDO NO REG. W

    BCF     STATUS, RP1
    BCF     STATUS, RP0   ; SELECIONA BANCO 0

    RETURN

ESCREVE_EEPROM:
    ; https://www.microchip.com/wwwappnotes/appnotes.aspx?appnote=en027642
    ;       Title: Techniques to Disable Global Interrupts
    ;        Name: AN576
    ;        Date: 08/01/2006
    ;      Author: Mark Palmer
    ; Description: This application note discusses four methods for disabling 
    ;              global interrupts. All discussion will be specific to the 
    ;              PIC16CXXX family of products, but these concepts are also 
    ;              applicable to the PIC17C42.
    ;    Keywords: interrupts, global, PIC16CXXX, PIC17C42, global interrupt 
    ;              enable, GIE,
    
    ; 13.4 Writing to the EEPROM Data Memory
    BCF     STATUS, RP1
    BCF     STATUS, RP0     ; SELECIONA BANCO 0

    MOVF    END_EEPROM, 0   ; COLOCA ENDERECO EM W

    BCF     STATUS, RP1
    BSF     STATUS, RP0     ; SELECIONA BANCO 1

    MOVWF   EEADR           ; COLOCA O ENDERECO NO REG. EEADR

    BCF     STATUS, RP1
    BCF     STATUS, RP0     ; SELECIONA BANCO 0

    MOVF    VAL_EEPROM, 0   ; COLOCA O VALOR A SER ESCRITO EM W

    BCF     STATUS, RP1
    BSF     STATUS, RP0     ; SELECIONA BANCO 1

    MOVWF   EEDATA          ; COLOCA O DADO NO REG. EEDATA

    BSF     EECON1, WREN    ; PERMISSAO PARA CICLO DE ESCRITA NA EEPROM
    BCF     INTCON, GIE     ; Disable INTs.
    BTFSC   INTCON, GIE     ; See AN576
    GOTO    $-2

    MOVLW   0x55            ; The write will not initiate if the above sequence 
                            ; is not followed exactly (write 55h to EECON2,
                            ; write AAh to EECON2, then set WR bit) for each byte.
    MOVWF   EECON2          ; Write 55h
    MOVLW   0xAA
    MOVWF   EECON2          ; Write AAh
    BSF     EECON1, WR      ; BIT CONTROLE ESCRITA - INICIA O CICLO DE ESCRITA

    BSF     INTCON, GIE

    BCF     STATUS, RP1
    BCF     STATUS, RP0    ; SELECIONA BANCO 0

    RETURN

    END