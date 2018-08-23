# Consumo-de-Combustivel

Anotações 

<nome> .space <valor> #fazer um vetor V
=============================////\\\\========================================
Precisamos aprender

receber valor do teclado V
printar valores V
criar V
manipular vetores 
operaçoes V
=============================////\\\\========================================
receber valor do teclado e printar V

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
=============================////\\\\========================================
qualquer operaçao feita o valor sera armazenado em $v0 e $v1
=============================////\\\\========================================
iniciar tudo com 0 
=============================////\\\\========================================
multiplicar por 0 para zerar um cadastro
=============================////\\\\========================================
converter para dia a partir da data inicial = 1/1/2018 até 2118
