; INSTRUCAO: SWAPF
; TROCA OS NIBBLES (GRUPO DE 4 BITS) MAIS SIGNIFICATIVO
; PARA O MENOS SIGNIFICATIVO SOBRE O CONTEUDO DO REG. f
; E COLOCA EM d
MOVLW   .197
MOVWF   0x0C
SWAPF   0x0C, 0
