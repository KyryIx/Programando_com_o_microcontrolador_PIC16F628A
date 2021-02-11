; INSTRUCAO: INCFSZ
; INCREMENTA O CONTEUDO DO REGISTRADOR f E ARMAZENA EM d
; SALTA UMA INSTRUCAO SER FOR ZERO
MOVLW   .255      ;
MOVWF   0x0C      ;
INCFSZ  0x0C, 0   ; >---+
                  ;     |
CLRW              ;     |
                  ;     |
CLRF    0x0C      ; <---+
