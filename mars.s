# PROJETO DE INICIO DE ARQUITETURA
# versao 0.2 26/08

# Adriano de Oliveira Munin  	17066960
# Fabio Seiji Irokawa   	17057720
# Cesar Augusto Pinardi 	17270182
# Lucas Rodrigues Coutinho      17776501
# Fabio Luis Dumont     	17049461


.data

	cadastro:     				.space 32000
	indice:								.byte 0
	zeroFloat: 						.float 0.0

	pulaLinha: 						.asciiz "\n"
	msgInicio:  					.asciiz "PROJETO ARQUITETURA DE COMPUTADORES:\n\nCONTROLE DE ABASTECIMENTO\n"
	msgMenu: 							.asciiz "\nMenu:\n 1) Cadastro \n 2) Excluir abastecimento \n 3) Exibir abastecimento \n 4) Exibir consumo medio \n 5) Exibir preco medio por posto \n 6) Creditos \n 0) Sair \n"
	msgCadastroData:			.asciiz "\nInsira a data do abastecimento:"
	msgDia: 	   					.asciiz "\nDigite o dia: "
	msgMes: 	   					.asciiz "Digite o mes(ex. abril = 4): "
	msgAno: 	   					.asciiz "Digite o ano(ex. 2018 = 2018): "
	msgCadastroPosto:			.asciiz	"\nInsira o nome do posto: "
	msgCadastroKm:				.asciiz	"\nInsira a km atual do veiculo: "
	msgCadastroQtd:				.asciiz "\nInsira a quantidade de combustivel: "
	msgCadastroPreco:			.asciiz	"\nInsira o preco por litro (ex: R$3,99/L = 3.99): "
	msgCadastroConcluido:	.asciiz	"\nCadastro realizado com sucesso!\n "
	msgCreditos: 	  			.asciiz "\nAdriano de Oliveira Munin 17066960 \n Cesar Augusto Pinardi 17270182 \n Fabio Luis Dumont 17049461 \n Fabio Seiji Irokawa 17057720 \n Lucas Rodrigues Coutinho 17776501 \n "
	msgExcluir:						.asciiz "\nInsira a data que deseja excluir: "
	msgConsumoMedio:			.asciiz "\nConsumo medio do veiculo: "
	msgControle:					.asciiz "\nInsira um valor de 0 a 6\n"
	msgQtdCadastro:				.asciiz "\nQuantidade de cadastros: "
	msgMesInvalido:				.asciiz "\nO mes digitado eh invalido!"
	msgExclusaoErro:			.asciiz "\nA data digitada nao foi encontrada!"
	msgExclusaoSucesso:		.asciiz "\nExclusao feita com Sucesso!"


	msgIdicaTeste:				.asciiz "\n**********************************\n"

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

		addi $t0, $zero, 0 # Zera o indice

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

		jal conveteData		# Parametros que podem ser passados para funcao a0, a1, a2, a3
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

#Inicio exclusao*****************************************************************************************
	excluir_abastecimento:
		li $v0, 4														#Setando Syscall para exibir Msg
		la $a0, msgExcluir									#Setando string a ser printada
		syscall															#Execucao

		jal conveteData											#Insercao da data e retorno em Qtd de dias em v1

		add	 $t0, $zero, $zero							#Zerando t0 p/ ser usado como indice de cadastro
		addi $t1, $zero, -1									#Setando t1 em -1 p/ setar o valor de exclusao(-1)
		addi $t2, $zero, 32000							#Valor limite do inice

		procura_excluir:
			lw   $t3, cadastro($t0)						#Passando p/ t3 info do cadastro desejado
			beq  $t3, $v1, exclusao						#Comparando a data informada com o dado cadastrado, caso sejam iguais jump p/ exclusao
			addi $t0, $t0, 32									#Incremento do indice p/ prox endereco de comparacao
			beq  $t0, $t2, exclusaoErro				#Se indice == 3200(setado anteriormente) jump p/ exclusaoErro
			j 	 procura_excluir							#Jump de laco

		exclusao:
			sw $t1, cadastro($t0)							#Setando data da posicao desejada em -1
			j exclusaoSucesso									#Jump p exclusaoSucesso

		exclusaoErro:
			li $v0, 4													#Setando Syscall para exibir Msg
			la $a0, msgExclusaoErro						#Setando string a ser printada
			syscall														#Execucao

			j menu														#Jump p menu

		exclusaoSucesso:
			li $v0, 4													#Setando Syscall para exibir Msg
			la $a0, msgExclusaoSucesso				#Setando string a ser printada
			syscall														#Execucao

			j menu														#Jump p menu


#Fim exclusao*****************************************************************************************
	exibir_abastecimento:
		jal imprimeCadastros
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
# Inicio conversao de data*******************************************************************************
	conveteData:
	li $v0, 4		#
	la $a0, msgDia		# Msg dia
	syscall			#

	li $v0, 5 		#
	syscall 		# Le inteiro dia
	add $t5, $v0, $zero	# Armazena o dia em t5

	li $v0, 4		#
	la $a0, msgMes		# Msg mes
	syscall			#

	li $v0, 5 		#
	syscall 		# Le inteiro mes
	add $t1, $v0, $zero	# Armazena o mes em t1

	li $v0, 4		#
	la $a0, msgAno		# Msg ano
	syscall			#

	li $v0, 5 		#
	syscall 		# Le inteiro ano
	add $t2, $v0, $zero	# Armazena o ano em t2

	addi $t1, $t1, -1   #Subtrair um mes p/ nao contar o mes incompleto
  addi $t4, $zero, 0  #Zerar de qtd de dias parcial dos meses

contagemMes:

  beq $t1, 1, trinta1	# Satos para multiplicar qtd de dias dos meses
  beq $t1, 2, vinte8
  beq $t1, 3, trinta1
  beq $t1, 4, trinta
  beq $t1, 5, trinta1
  beq $t1, 6, trinta
  beq $t1, 7, trinta1
  beq $t1, 8, trinta1
  beq $t1, 9, trinta
  beq $t1, 10, trinta1
  beq $t1, 11, trinta
  beq $t1, 12, trinta1
  beq $t1, 0, contagemAno

trinta1:
  addi $t3, $zero, 31     #Setar t3 em 31
  add  $t4, $t4, $t3      #Adicionar t3 nas Qtds de dias contados
  addi $t1, $t1, -1       #Decrementar Qtd de mes
  j    contagemMes        #jump to contagemMes

trinta:
  addi $t3, $zero, 30     #Idem jump trinta1
  add  $t4, $t4, $t3
  addi $t1, $t1, -1
  j    contagemMes

vinte8:
  addi $t3, $zero, 28     #Idem jump trinta1
  add  $t4, $t4, $t3
  addi $t1, $t1, -1
  j    contagemMes

contagemAno:

    add $t1, $zero, $t4   #Salvando contagem dos meses em t1

    addi $t2, $t2, -2018  #Subtraindo 2018 do ano inserido, pois tal ano e o ano inicial
    addi $t3, $zero, 365  #Adicionando 365 em t3 para fazer posteriormente a multiplicacao
    mul  $t2, $t2, $t3    #Multiplicando a diferenca de anos por 365 para obter a qtd de dias

    add $t3, $t5, $t1     #Somando os resultados
    add $v1, $t3, $t2     #Resultado final em v1

	jr $ra

# Fim conversao de data**********************************************************************************


# Inicio funcao imprime cadastros************************************************************************
imprimeCadastros:
	addi $t0, $t0, 0	# Idice 0 do vetor

loopImprime:

	lw $t2, cadastro($t0)	# Le a qtd de dias do vetor e salva em t2
	beq $t2, -1, fimSemPrimt

	li $v0, 1		# Codigo de impressao de inteiro
	addi $a0, $t2, 0	# Imprime qtd de dias
	syscall			#

	li $v0, 4		# Codigo de impressao de string
	la $a0, pulaLinha	# Pula linha
	syscall			#

	addi $t0, $t0, 4	# Indice 4 do vetor
	li $v0, 4		# Codigo de impressao de string
	la $a0, cadastro($t0)	# Imprime nome do posto
	syscall			#

	addi $t0, $t0, 16	# Indice 20 do vetor
	lw $t2, cadastro($t0)	# Le a qtd de Km vetor e salva em t2
	li $v0, 1		# Codigo de impressao de inteiro
	addi $a0, $t2, 0	# Imprime qtd de Km
	syscall			#

	li $v0, 4		# Codigo de impressao de string
	la $a0, pulaLinha	# Pula linha
	syscall			#

	addi $t0, $t0, 4	# Indice 24 do vetor
	lw $t2, cadastro($t0)	# Le a qtd de litros do vetor e salva em t2
	li $v0, 1		# Codigo de impressao de inteiro
	addi $a0, $t2, 0	# Imprime qtd de litros
	syscall			#

	li $v0, 4		# Codigo de impressao de string
	la $a0, pulaLinha	# Pula linha
	syscall			#

	addi $t0, $t0, 4	# Indice 28 do vetor
	lwc1 $f0, cadastro($t0)	# Le o preco vetor e salva em t2
	li $v0, 2		# Codigo de impressao de float
	add.s $f12, $f0, $f2 	# Imprime o preco por litros
	syscall			#

	li $v0, 4		# Codigo de impressao de string
	la $a0, msgIdicaTeste	# Separacao dos dados
	syscall			#

	addi $t0, $t0, 4


	addi $t2, $zero, 32000		#Valor limite do inice

	bne $t0, $t2, loopImprime

fimSemPrimt:
	addi $t0, $t0, 32
	addi $t2, $zero, 32000		#Valor limite do inice

	bne $t0, $t2, loopImprime

	jr $ra


# Fim funcao imprime cadastros***************************************************************************

cmpString:
	addi $t6, $t6, 4		#Posicao atual do byte
	addi $t7, $t7, 4		#Marcador de posicao
	addi $t8, $t8, 
	
	j loopSetPosto
	
resetT7:
	addi $t7, $t7, 4
	
loopSetPosto:
	la $a0,cadastro($t6) #salva o nome do posto
	addi $t6, $t6, 32
	beq $t6, 32000, exitNome
	
	loopRestPosto:
		la $a1,cadastro($t7) #salva o nome do posto
		addi $t7, $t7, 32
		
		methodComp:  
		add $t0,$zero,$zero  
		add $t1,$zero,$a0  
		add $t2,$zero,$a1  
			
		loopo:  
		lb $t3($t1)         #load a byte from each string  
		lb $t4($t2)  
		beqz $t3,checkt2    #str1 end  
		beqz $t4,missmatch  
		slt $t5,$t3,$t4     #compare two bytes  
		bnez $t5,missmatch  
		addi $t1,$t1,1      #t1 points to the next byte of str1  
		addi $t2,$t2,1  
		j loopo  
		
		missmatch:   
		addi $v0,$zero,1  
		beq $t7, , 
		j loopRestPosto
		
		checkt2:  
		bnez $t4,missmatch  
		add $v0,$zero,$zero 
	
	





jr $ra













# Fim funcoes############################################################################################