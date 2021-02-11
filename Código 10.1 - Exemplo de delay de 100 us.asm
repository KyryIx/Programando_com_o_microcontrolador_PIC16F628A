; inicia registrador de uso geral 0x20 com o valor 33 em decimal
     MOVLW       .33        ; 1 ciclo
     MOVWF       0x20       ; 1 ciclo
loop:
     DECFSZ      0x20       ; 1 ciclo   >---+--+    <--+
                            ;               |  |       |
     GOTO        loop       ; 2 ciclos  <---+  |    >--+
                            ;                  |
     NOP                    ; 1 ciclo   <------+
