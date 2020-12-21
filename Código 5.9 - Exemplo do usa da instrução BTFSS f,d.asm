; INSTRUCAO: BTFSS
; TESTA SE O BIT b DO REGISTRADOR f ESTA setado (valor 1)
; SE ESTIVER setado (valor 1) SALTA A PROXIMA INSTRUCAO
MOVLW   .197      ; (1) 197 DECIMAL = 1100.0101 BINARIO
MOVWF   0x0C      ; (2)
                  ; (3)
BTFSS   0x0C, 5   ; (4) BIT NA POSICAO 5 EH ZERO >--+
                  ; (5)                             |
NOP               ; (6) <---------------------------+
                  ; (7)
NOP               ; (8)
