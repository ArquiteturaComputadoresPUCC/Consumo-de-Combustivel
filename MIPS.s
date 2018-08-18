# PROJETO DE INICIO DE ARQUITETURA
# versao 1.0 17/08

# Adriano de Ovo Munin  xX420blazeitniggalol666Xx
# Fabio Seiji Irokawa   17057720
# Cesar Augusto Pinardi 17270182
# Lucas Coutinho        17776501


.data

	msgInicio:  	.asciiz "PROJETO ARQUITETURA DE COMPUTADORES:\n\nCONTROLE DE ABASTECIMENTO\n"
	msgDev:				.asciiz "\nDesenvolvido por:\n Adriano\n Cesar\n Fabio\n Lucas\n"

.text
main:
	#mensagens de introdução
	li $v0, 4								# Codigo SysCall p/ escrever strings
	la $a0, msgInicio				# Parametro (string a ser escrita)
	syscall

	li $v0, 4
	la $a0, msgDev
	syscall

exit:
	#avisar que acabou
	li $v0, 10
	syscall
