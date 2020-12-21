; INSTRUCAO: BTFSC
; TESTA SE O BIT b DO REGISTRADOR f ESTA limpo (valor 0)
; SE ESTIVER limpo (valor 0) SALTA A PROXIMA INSTRUCAO
MOVLW   .197      ; 197 DECIMAL = 1100.0101 BINARIO
MOVWF   0x0C      ; 
                  ; 
BTFSC   0x0C, 2   ; BIT NA POSICAO 2 EH UM >----+
                  ;                             |
NOP               ; <---------------------------+
                  ; 
NOP               ;
