; exemplo de delay com 1 nível
  MOVLW   .250  ; (1)                  ; 1 ciclo
  MOVWF   0x20  ; (2)                  ; 1 ciclo
loop:           ; (3) <-------------+  ;
  ; ...         ; (4)               |  ; 250 por cada instrucao
                ; (5)               |  ;
  DECFSZ  0x20  ; (6) >---+---+     |  ; 250 * 1 ciclo  = 250 ciclos
                ; (7)     |   |     |  ;
  GOTO    loop  ; (8) <---+   | >---+  ; 249 * 2 ciclos = 498 ciclos
                ; (9)         |        ;
                ; (10) <------+        ; TOTAL = 750 ciclos
