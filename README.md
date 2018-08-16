# Consumo-de-Combustivel

Anotações 

<nome> .space <valor> #fazer um vetor


=============================////\\\\========================================

Precisamos aprender

receber valor do teclado 




printar valores



criar / manipular vetores




operaçoes

=============================////\\\\========================================

receber valor de teclado e somar

.text # indica que as linhas seguintes contém instruções
.globl main # define o símbolo main como sendo global
main: # indica o início do programa

li $v0, 5 # Codigo SysCall p/ ler inteiros
syscall
add $t0, $v0, $zero

li $v0, 5 # Codigo SysCall p/ ler inteiros
syscall
add $t1, $v0, $zero

add $s0, $t0, $t1

li $v0, 1 # Codigo SysCall p/ escrever inteiros
add $a0, $zero, $s0 # Parametro (inteiro a ser escrito)
syscall

li $v0, 5 # Apenas para esperar um [ENTER]
syscall
