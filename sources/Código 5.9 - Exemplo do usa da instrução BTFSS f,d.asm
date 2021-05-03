; INSTRUCAO: BTFSS
; TESTA SE O BIT b DO REGISTRADOR f ESTA setado (valor 1)
; SE ESTIVER setado (valor 1) SALTA A PROXIMA INSTRUCAO
MOVLW   .197      ; 197 DECIMAL = 1100.0101 BINARIO
MOVWF   0x0C      ;
                  ;
BTFSS   0x0C, 5   ; BIT NA POSICAO 5 EH ZERO >--+
                  ;                             |
NOP               ; <---------------------------+
                  ;
NOP               ;
