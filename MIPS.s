# PROJETO DE INICIO DE ARQUITETURA
# versao 0.2 26/08

# Adriano de Oliveira Munin  	17066960
# Fabio Seiji Irokawa   	17057720
# Cesar Augusto Pinardi 	17270182
# Lucas Rodrigues Coutinho      17776501
# Fabio Luis Dumont     	17049461


.data

	cadastro:     	.space 32000
	indice:		.byte 0
	zeroFloat: 	.float 0.0
	
	pulaLinha: 		.asciiz "\n"
	msgInicio:  		.asciiz "PROJETO ARQUITETURA DE COMPUTADORES:\n\nCONTROLE DE ABASTECIMENTO\n"
	msgMenu: 		.asciiz "\nMenu:\n 1) Cadastro \n 2) Excluir abastecimento \n 3) Exibir abastecimento \n 4) Exibir consumo medio \n 5) Exibir preco medio por posto \n 6) Creditos \n 0) Sair \n"
	msgCadastroData:	.asciiz "\nInsira a data do abastecimento:"
	msgDia: 	   	.asciiz "\nDigite o dia: "
	msgMes: 	   	.asciiz "Digite o mes(ex. abril = 4): "
	msgAno: 	   	.asciiz "Digite o ano(ex. 2018 = 18): "
	msgCadastroPosto:	.asciiz	"\nInsira o nome do posto: "
	msgCadastroKm:		.asciiz	"\nInsira a km atual do veiculo: "
	msgCadastroQtd:		.asciiz "\nInsira a quantidade de combustivel: "
	msgCadastroPreco:	.asciiz	"\nInsira o preco por litro (ex: R$3,99/L = 3.99): "
	msgCadastroConcluido:	.asciiz	"\nCadastro realizado com sucesso!\n "
	msgCreditos: 	  	.asciiz "\nAdriano de Oliveira Munin 17066960 \n Cesar Augusto Pinardi 17270182 \n Fabio Luis Dumont 17049461 \n Fabio Seiji Irokawa 17057720 \n Lucas Rodrigues Coutinho 17776501 \n "
	msgExcluir:		.asciiz "\nInsira a data que deseja excluir: "
	msgConsumoMedio:	.asciiz "\nConsumo medio do veiculo: "
	msgControle:		.asciiz "\nInsira um valor de 0 a 6\n"
	msgQtdCadastro:		.asciiz "\nQuantidade de cadastros: "
	msgMesInvalido:		.asciiz "\nO mes digitado eh invalido"
	
		
	msgIdicaTeste:		.asciiz "\n**********************************\n"			
.text
main:
	#mensagens de introducao
		li $v0, 4					# Codigo SysCall p/ escrever strings
		la $a0, msgInicio				# Parametro (string a ser escrita)
		syscall
		
		addi $t0, $t0, 0	# Zera t0
		addi $t1, $t0, -1	# Seta t1 com -1 (ira indicar bloco livre para gravacao)
						
	setaVetor:
		sw $t1, cadastro($t0)	# Grava -1 em todas as primeiras posicoes dos blocos
		addi $t0, $t0, 32	# incrementa indice
		bne $t0, 32000, setaVetor
		
	menu:	
	li $v0, 1		# 
	addi $a0, $t0, 0	# TESTE
	syscall			#
	addi $t0, $zero, 0	# TESTE
	lw $t1, cadastro($t0)	#
	li $v0, 1		# Imprime primeira posicao do vetor
	addi $a0, $t1, 0	# TESTE
	syscall			#
		
		
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

# Inicio Cadastro****************************************************************************************
# Inicio procura posicao livre pra gravacao--------------------------------------------------------------
	cadastrar:
		addi $t0, $t0, 0	# Zera t0 usado como indice 	#
	percorreVetor:			#
		lw $t1, cadastro($t0)
		beq $t1, -1, inicioGrav
		addi $t0, $t0, 32
		j percorreVetor		
# Fim procura posicao livre pra gravacao-----------------------------------------------------------------

								
# Inicio leitura da data --------------------------------------------------------------------------------
	inicioGrav:	
		li $v0, 4
		la $a0, msgCadastroData 
		syscall
		
		li $v0, 4		#
		la $a0, msgDia		# Msg dia
		syscall			#
			
		li $v0, 5 		# 	 
		syscall 		# Le inteiro dia
		add $a1, $v0, $zero	# Armazena o dia em a1 ($a1 registrador para passagem de parametros)
	
		li $v0, 4		#
		la $a0, msgMes		# Msg mes
		syscall			#
		
		li $v0, 5 		# 	 
		syscall 		# Le inteiro mes
		add $a2, $v0, $zero	# Armazena o mes em a2 ($a2 registrador para passagem de parametros)
		
		li $v0, 4		#
		la $a0, msgAno		# Msg ano
		syscall			#

		li $v0, 5 		#
		syscall 		# Le inteiro ano
		add $a3, $v0, $zero	# Armazena o ano em a3 ($a3 registrador para passagem de parametros)
		sub $a3, $a3, 18	#		
		
		jal conveteData		# Parametros passado para funcao a0, a1, a2, a3
					# Parametro retornado em v1
									
														
		li $v0, 4
		la $a0, msgIdicaTeste
		syscall
		
		li $v0, 1		# Codigo de impressao de inteiro
		addi $a0, $v1, 0	# Imprime qtd de cadastros
		syscall			#
		
		li $v0, 4
		la $a0, msgIdicaTeste
		syscall		
		
		addi $t0, $t0, 0	# Zera t0 usado como indice
		sw $v1, cadastro($t0)	# Grava os dias no vetor cadastro
# Fim leitura da data------------------------------------------------------------------------------------					

		
# Inicio leitura do nome do posto------------------------------------------------------------------------												
		li $v0, 4
		la $a0, msgCadastroPosto
		syscall
	
		addi $t0, $t0, 4	# Seta t0 para 4 (Posicao do nome do posto)
		li $v0, 8		# Codigo de leitura de string	
		la $a0, cadastro($t0)	#
		li $a1, 16		#
		syscall			#
# Fim leitura do nome do posto---------------------------------------------------------------------------																				


# Inicio leitura km--------------------------------------------------------------------------------------
		li $v0, 4
		la $a0, msgCadastroKm
		syscall
	
		li $v0, 5 		# Codigo para leitura de inteiro	 
		syscall 		# Le inteiro km
		add $t1, $v0, $zero	# Armazena em t1
	
		addi $t0, $t0, 16	# Seta t0 para 20 (Posicao valor Km)
		sw $t1, cadastro($t0)	# Grava os kms no vetor cadastro
# Fim leitura km-----------------------------------------------------------------------------------------


# Inicio leitura qtd combustivel-------------------------------------------------------------------------
		li $v0, 4
		la $a0, msgCadastroQtd
		syscall
		
		li $v0, 5 		# Codigo para leitura de inteiro	 
		syscall 		# Le qtd combustivel
		add $t1, $v0, $zero	# Armazena o dia em t1
	
		addi $t0, $t0, 4	# Seta t0 para 24 (Posicao qtd combustivel)
		sw $t1, cadastro($t0)	# Grava a qtd de combustivel no vetor cadastro
# Fim leitura qtd combustivel----------------------------------------------------------------------------


# Inicio leitura preco por litro-------------------------------------------------------------------------
		li $v0, 4
		la $a0, msgCadastroPreco
		syscall
	
		lwc1 $f2, zeroFloat
		li $v0, 6 		# Codigo para leitura de float	 
		syscall 		# Le float preco
		add.s $f1, $f0, $f2	# Armazena em t1
	
		addi $t0, $t0, 4	# Seta t0 para 28 (Posicao do preco por litro)
		swc1 $f1, cadastro($t0)	# Grava o preco no vetor cadastro
# Fim leitura preco por litro----------------------------------------------------------------------------
	
	
# Inicio conclusao cadastro------------------------------------------------------------------------------
		addi $t0, $t0, 4	# Pula para proximo bloco de cadastro
		sw $t0, indice		# Atualiza valor do indice
		
		li $v0, 4
		la $a0, msgCadastroConcluido
		syscall
		
		li $v0, 4
		la $a0, msgQtdCadastro
		syscall	
		
		addi $t1, $zero, 32
		div $t0, $t0, $t1						
		
		li $v0, 1		# Codigo de impressao de inteiro
		addi $a0, $t0, 0	# Imprime qtd de cadastros
		syscall			#

		j menu
# Fim conclusao cadastro---------------------------------------------------------------------------------
# Fim Cadastro*******************************************************************************************
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



# Inicio funcoes#########################################################################################
# Inicio conversao de data-------------------------------------------------------------------------------
	conveteData:			#a1=dia, a2=mes, a3=ano
		
		beq $a2, 1, trinta1	# Satos para multiplicar qtd de dias dos meses
		beq $a2, 2, vinte8
		beq $a2, 3, trinta1
		beq $a2, 4, trinta
		beq $a2, 5, trinta1
		beq $a2, 6, trinta
		beq $a2, 7, trinta1
		beq $a2, 8, trinta1
		beq $a2, 9, trinta
		beq $a2, 10, trinta1
		beq $a2, 11, trinta
		beq $a2, 12, trinta1

		li $v0, 4		#
		la $a0, msgMesInvalido	# Msg mes invalido
		syscall			#

		j menu

	vinte8:
		addi $t4, $zero, 28	# Seta o t4 para 28
		mul $t5, $a2, $t4	# Multiplica o mes por 28
		j ano

	trinta:
		addi $t4, $zero, 30	# Seta o t4 para 30
		mul $t5, $a2, $t4	# Multiplica o mes por 30
		j ano

	trinta1:
		addi $t4, $zero, 31	# Seta o t4 para 31
		mul $t5, $a2, $t4	# Multiplica o mes por 31

	ano:
		addi $t4, $zero, 365	# Seta o t4 para 365
		mul $t6, $a3, $t4	# Multiplica o ano por 365

		add $v1, $t5, $a1	# Soma dias com mes
		add $v1, $v1, $t6	# Soma total de dias
	
	jr $ra	
		
# Fim conversao de data----------------------------------------------------------------------------------
# Fim funcoes############################################################################################