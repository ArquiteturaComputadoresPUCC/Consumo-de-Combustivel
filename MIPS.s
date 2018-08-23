# PROJETO DE INICIO DE ARQUITETURA
# versao 1.0 23/08

# Adriano de Oliveira Munin  	17066960
# Fabio Seiji Irokawa   	17057720
# Cesar Augusto Pinardi 	17270182
# Lucas Coutinho        	17776501
# Fabio Luis Dumont     	17049461


.data

	msgInicio:  		.asciiz "PROJETO ARQUITETURA DE COMPUTADORES:\n\nCONTROLE DE ABASTECIMENTO\n"
	cadastro: 		.space 4800 			#48b por cadastro 
	msgMenu: 		.asciiz "\n Menu:\n 1) Cadastro \n 2) Excluir abastecimento \n 3) Exibir abastecimento \n 4) Exibir consumo medio \n 5) Exibir preco medio por posto \n 6) Creditos \n 0) Sair \n"
	msgCadastroData:	.asciiz "\n Insira uma data (dd/mm/aa): "
	msgCadastroPosto:	.asciiz	"\n Insira o nome do posto (minusculo): "
	msgCadastroKm:		.asciiz	"\n Insira a km atual do veiculo: "
	msgCadastroQtd:		.asciiz "\n Insira a quantidade de combustivel: "
	msgCadastroPreco:	.asciiz	"\n Insira o preco por litro (ex: R$3,99/L = 3.99): "	
	msgCreditos: 		.asciiz "\n Adriano de Oliveira Munin 17066960 \n Cesar Augusto Pinardi 17270182 \n Fabio Luis Dumont 17049461 \n Fabio Seiji Irokawa 17057720 \n Lucas Rodrigues Coutinho 17776501 \n "

.text
main:
	#mensagens de introdução
	li $v0, 4					# Codigo SysCall p/ escrever strings
	la $a0, msgInicio				# Parametro (string a ser escrita)
	syscall
	
	li $v0, 4
	la $a0, msgMenu
	syscall
	
	
	li $v0, 4
	la $a0, msgCreditos
	syscall


exit:
	#avisar que acabou
	li $v0, 10
	syscall
