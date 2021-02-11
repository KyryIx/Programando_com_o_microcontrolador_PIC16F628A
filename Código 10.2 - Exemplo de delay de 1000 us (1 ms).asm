; inicia registrador de uso geral 0x20 com o valor 250 em decimal
     MOVLW       .250       ; 1 ciclo
     MOVWF       0x20       ; 1 ciclo
loop:
     NOP                    ; 1 ciclo    <--------------+
                            ;                           |
     DECFSZ      0x20       ; 1 ciclo;   >---+--+       |
                            ;                |  |       |
     GOTO        loop       ; 2 ciclos   <---+  |    >--+
                            ;                   |
     NOP                    ;            <------+
