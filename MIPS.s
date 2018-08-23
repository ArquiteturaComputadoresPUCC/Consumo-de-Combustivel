# PROJETO DE INICIO DE ARQUITETURA
# versao 1.0 23/08

# Adriano de Oliveira Munin  	17066960
# Fabio Seiji Irokawa   	17057720
# Cesar Augusto Pinardi 	17270182
# Lucas Rodrigues Coutinho      17776501
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
	msgCadastroConcluido:	.asciiz	"\n Cadastro realizado com sucesso!\n "
	msgCreditos: 	  	.asciiz "\n Adriano de Oliveira Munin 17066960 \n Cesar Augusto Pinardi 17270182 \n Fabio Luis Dumont 17049461 \n Fabio Seiji Irokawa 17057720 \n Lucas Rodrigues Coutinho 17776501 \n "
	msgExcluir:		.asciiz "\n Insira a data que deseja excluir: "
	msgConsumoMedio:	.asciiz "\n Consumo medio do veiculo: "
	msgControle:		.asciiz "\n Insira um valor de 0 a 6\n"

.text
main:
	#mensagens de introdu??o
		li $v0, 4					# Codigo SysCall p/ escrever strings
		la $a0, msgInicio				# Parametro (string a ser escrita)
		syscall
	menu:
		li $v0, 4
		la $a0, msgMenu
		syscall

		li $v0, 5 					# Codigo SysCall p/ ler inteiros
		syscall 					# Inteiro lido vai ficar em $v0


		beq $v0, 0, exit
		beq $v0, 1, cadastrar
		beq $v0, 2, excluir_abastecimento
		beq $v0, 3, exibir_abastecimento
		beq $v0, 4, exibir_consumo_medio
		beq $v0, 5, exibir_preco_medio_posto
		beq $v0, 6, creditos

		li $v0, 4
		la $a0, msgControle
		syscall
		j menu


	cadastrar:
		li $v0, 4
		la $a0, msgCadastroData
		syscall

		li $v0, 5
		syscall

		li $v0, 4
		la $a0, msgCadastroPosto
		syscall

		li $v0, 5
		syscall

		li $v0, 4
		la $a0, msgCadastroKm
		syscall

		li $v0, 5
		syscall

		li $v0, 4
		la $a0, msgCadastroQtd
		syscall

		li $v0, 5
		syscall

		li $v0, 4
		la $a0, msgCadastroPreco
		syscall

		li $v0, 5
		syscall

		li $v0, 4
		la $a0, msgCadastroConcluido
		syscall

		j menu

	excluir_abastecimento:
		li $v0, 4
		la $a0, msgExcluir
		syscall

		li $v0, 5
		syscall

		j menu

	exibir_abastecimento:

		j menu

	exibir_consumo_medio:

		j menu

	exibir_preco_medio_posto:

		j menu

	creditos:
		li $v0, 4
		la $a0, msgCreditos
		syscall


	exit:
		#avisar que acabou
		li $v0, 10
		syscall
