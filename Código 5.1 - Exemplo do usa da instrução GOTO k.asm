; INSTRUCAO: GOTO
; VAI PARA UM ENDERECO/ROTULO DE MEMORIA DE PROGRAMA
TESTEBOTAOPRESSIONADO:              ; <-----------+
                                    ;             |
     BTFSS   PORTA, RA0             ; >--+--+     |
                                    ;    |  |     |
     GOTO    TESTEBOTAOPRESSIONADO  ; <--+  |  >--+
                                    ;       |
     NOP                            ; <-----+   
