; INSTRUCAO: DECFSZ
; DECREMENTA O CONTEUDO DO REGISTRADOR f E ARMAZENA EM d
; SALTA UMA INSTRUCAO SER FOR ZERO
MOVLW   .1        ;
MOVWF   0x0C      ;
DECFSZ  0x0C, 0   ; >---+
                  ;     |
CLRW              ;     |
                  ;     |
CLRF    0x0C      ; <---+
