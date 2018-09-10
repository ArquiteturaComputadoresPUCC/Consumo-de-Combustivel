# PROJETO DE INICIO DE ARQUITETURA
# versao 0.2 26/08

# Adriano de Oliveira Munin  	17066960
# Fabio Seiji Irokawa   	17057720
# Cesar Augusto Pinardi 	17270182
# Lucas Rodrigues Coutinho      17776501
# Fabio Luis Dumont     	17049461


.data

	cadastro:     				.space 320
	indice:					.byte 0
	zeroFloat: 				.float 0.0
	umFloat: 				.float 1.0
	precoMedio:				.space 200

	pulaLinha: 				.asciiz "\n"
	msgInicio:  				.asciiz "PROJETO ARQUITETURA DE COMPUTADORES:\n\nCONTROLE DE ABASTECIMENTO\n"
	msgMenu: 				.asciiz "\nMenu:\n 1) Cadastro \n 2) Excluir abastecimento \n 3) Exibir abastecimento \n 4) Exibir consumo medio \n 5) Exibir preco medio por posto \n 6) Creditos \n 0) Sair \n"
	msgCadastroData:			.asciiz "\nInsira a data do abastecimento:"
	msgDia: 	   			.asciiz "\nDigite o dia: "
	msgMes: 	   			.asciiz "Digite o mes(ex. abril = 4): "
	msgAno: 	   			.asciiz "Digite o ano(ex. 2018 = 2018): "
	msgCadastroPosto:			.asciiz	"\nInsira o nome do posto: "
	msgCadastroKm:				.asciiz	"\nInsira a km atual do veiculo: "
	msgCadastroQtd:				.asciiz "\nInsira a quantidade de combustivel: "
	msgCadastroPreco:			.asciiz	"\nInsira o preco por litro (ex: R$3,99/L = 3.99): "
	msgCadastroConcluido:			.asciiz	"\nCadastro realizado com sucesso!\n "
	msgCreditos: 	  			.asciiz "\nAdriano de Oliveira Munin 17066960 \n Cesar Augusto Pinardi 17270182 \n Fabio Luis Dumont 17049461 \n Fabio Seiji Irokawa 17057720 \n Lucas Rodrigues Coutinho 17776501 \n "
	msgExcluir:				.asciiz "\nInsira a data que deseja excluir: "
	msgConsumoMedio:			.asciiz "\nConsumo medio do veiculo: "
	msgControle:				.asciiz "\nInsira um valor de 0 a 6\n"
	msgQtdCadastro:				.asciiz "\nQuantidade de cadastros: "
	msgMesInvalido:				.asciiz "\nO mes digitado eh invalido!"
	msgExclusaoErro:			.asciiz "\nA data digitada nao foi encontrada!"
	msgExclusaoSucesso:			.asciiz "\nExclusao feita com Sucesso!"
	msgBarra:				.asciiz "/"

	msgIdicaTeste:				.asciiz "\n**********************************\n"

.text
main:
	#mensagens de introducao
		li $v0, 4					# Codigo SysCall p/ escrever strings
		la $a0, msgInicio				# Parametro (string a ser escrita)
		syscall

		addi $t0, $zero, 0	# Zera t0
		#addi $t2, $zero, 0	# Zera t0
		addi $t1, $zero, -1	# Seta t1 com -1 (ira indicar bloco livre para gravacao)
	setaVetor:
		sw $t1, cadastro($t0)	# Grava -1 em todas as primeiras posicoes dos blocos
		#sw $t1, precoMedio($t2)
		addi $t0, $t0, 32	# incrementa indice
		#addi $t2, $t2, 20	# incrementa indice
		
		bne $t0, 320, setaVetor

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

		jal converteData		# Parametros que podem ser passados para funcao a0, a1, a2, a3
					# Parametro retornado em v1

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

		j menu
# Fim conclusao cadastro---------------------------------------------------------------------------------
# Fim Cadastro*******************************************************************************************


# Inicio exclusao****************************************************************************************
	excluir_abastecimento:
		li $v0, 4				#Setando Syscall para exibir Msg
		la $a0, msgExcluir			#Setando string a ser printada
		syscall					#Execucao

		jal converteData			#Insercao da data e retorno em Qtd de dias em v1

		add $t0, $zero, $zero			#Zerando t0 p/ ser usado como indice de cadastro
		addi $t1, $zero, -1			#Setando t1 em -1 p/ setar o valor de exclusao(-1)
		addi $t2, $zero, 320			#Valor limite do inice

	procura_excluir:
		lw   $t3, cadastro($t0)			#Passando p/ t3 info do cadastro desejado
		beq  $t3, $v1, exclusao			#Comparando a data informada com o dado cadastrado, caso sejam iguais jump p/ exclusao
		addi $t0, $t0, 32			#Incremento do indice p/ prox endereco de comparacao
		beq  $t0, $t2, exclusaoErro		#Se indice == 3200(setado anteriormente) jump p/ exclusaoErro
		j 	 procura_excluir		#Jump de laco

	exclusao:
		sw $t1, cadastro($t0)			#Setando data da posicao desejada em -1
		j exclusaoSucesso			#Jump p exclusaoSucesso

	exclusaoErro:
		li $v0, 4				#Setando Syscall para exibir Msg
		la $a0, msgExclusaoErro			#Setando string a ser printada
		syscall					#Execucao

		j menu					#Jump p menu

	exclusaoSucesso:
		li $v0, 4				#Setando Syscall para exibir Msg
		la $a0, msgExclusaoSucesso		#Setando string a ser printada
		syscall					#Execucao

		j menu					#Jump p menu
# Fim exclusao****************************************************************************************
	
	
# Inicio exibir abastecimento*************************************************************************
	exibir_abastecimento:
		add $t0, $zero, $zero			#Zerando t0 p/ ser usado como indice externo
		add $t7 $zero, $zero			#Zerando t8 p/ ser usado como indice interno
		
	loopExterno:
		beq $t0, 288, fim
			
	loopInterno:		
		lw $t2, cadastro($t0)
		lw $t3, cadastro($t7)
		bgt $t3, $t2, troca
		addi $t7, $t7, 32	
		beq $t7, 320, fimInterno
		j loopInterno
# Inicio troca de posicoes----------------------------------------------------------------------------		
	troca:
		addi $t4, $zero, 32
	loopTroca:	
		lw $t2, cadastro($t0)
		lw $t3, cadastro($t7)
		
		sw $t3, cadastro($t0)
		sw $t2, cadastro($t7)

		subi $t4, $t4, 4
		
		addi $t0, $t0, 4
		addi $t7, $t7, 4
		
		bne $t4, 0, loopTroca	
		
		j loopInterno
# Fim troca de posicoes-------------------------------------------------------------------------------	
	fimInterno:
		addi $t0, $t0, 32
		addi $t7, $t0, 32
		j loopExterno
	
	fim:	
		jal imprimeCadastros
		j menu		
# Fim exibir abastecimento****************************************************************************	


# Inicio consumo medio********************************************************************************	
	exibir_consumo_medio:
	jal consumoMedio		
		
		j menu
# Fim consumo medio***********************************************************************************


# Inicio preco medio**********************************************************************************
exibir_preco_medio_posto:
	addi $t2, $zero, 0	# Zera t0
	addi $t1, $zero, -1	# Seta t1 com -1 (ira indicar bloco livre para gravacao)
	add $t0, $zero, $zero			# Seta t0 para pasicao do byte de status no nome
	add $t3, $zero, 15
	
zeraVetor:# Zera vetor a cada impressao de media de preco 
	lb $t0, cadastro($t3)
	sw $t1, precoMedio($t2)
	addi $t3, $t3, 32
	addi $t2, $t2, 20		# incrementa indice		
	bne $t2, 200, zeraVetor
	
vetorCadastro:# Faz um ciclo por posto (percorre vetor de cadastro)
	lwc1 $f0, zeroFloat		#Setando f0 com0 numero 0 
	lwc1 $f1, umFloat		#Setando f3 como numero 1
	lwc1 $f2, zeroFloat		#Zerando qtd de preços somados
	lwc1 $f3, zeroFloat		#Zerando somatorio dos preços
	add $t1, $zero, $zero			# Indice vetor media
	#add $t3, $zero, $zero


	
	beq $t0, 320, ordena 
	addi $t3, $t0, 15	 		# 15 = indice do status
	lb $s1, cadastro($t3)			# Le o status de media
	bne $s1, -1, media			# Se o status for diferente -1 (posto ja feita media), faz a media
	add $t0, $t0, 32			# se nao vai para proximo nome
	j vetorCadastro

media:
	lw $t5, cadastro($t0)		#le nome do posto a ser feita media
	bne $t5, -1, percorreVetor2
	add $t0, $t0, 32
	j vetorCadastro
# Inicio copia nome-----------------------------------------------------------------------------------	

percorreVetor2:				# Procura posicao vazia no vetor de media
	lw $t2, precoMedio($t1)
	beq $t2, -1, copia
	addi $t1, $t1, 20
	j percorreVetor2

copia:
	addi $t5, $zero, 15		# Qtd de repeticoes loop (Qtd letras)
	add $t3, $t0, 4			# Salva indice cadastro, pois nao pode ser perdido
	add $t4, $t1, 4			# Salva indice precoMedio, pois nao pode ser perdido

copiaLetra:	
	lb $s1, cadastro($t3)			# Le letra do cadastro
	sb $s1, precoMedio($t4)			# Salva letra no precoMedio
	subi $t5, $t5, 1			# Decrementa loop
	addi $t3, $t3, 1			# Incrementa indices
	addi $t4, $t4, 1		
	bne $t5, 0, copiaLetra	   		# Condicao de parada
	
	addi $t3, $t0, 28 
	lwc1 $f3, cadastro($t3)			# Move para f3 o preço			
	#add.s $f3, $f3, $f0 			# Soma preço no somatorio de preços
	
# Fim copia nome--------------------------------------------------------------------------------------		        
# Inicio soma media-----------------------------------------------------------------------------------
#	addi $t3, $t0, 19			# Seta t3 para pasicao do byte de status no nome
#	#add $t1, $zero, $zero			# Indice vetor media
#vetorCadastro2:
#	lb $s1, cadastro($t0)			# Le o status de media
#	bne $s1, -1, comparaNome			# Se o status for diferente -1 (posto ja feita media), faz a media
#	add $t0, $t0, 32			# se nao vai para proximo nome
#	j vetorCadastro2

# Inicio compara nomes---------------------------------------------------------------------------------
#t0 e t2 estao no mesmo nome em vetores diferentes
comparaNome:
	add.s $f2, $f2, $f1			# Soma 1 a qtd de postos somados	
	addi $t5, $zero, 15			# Qtd de repeticoes loop (Qtd letras)
	addi $s3, $t0, 32			# Salva indice cadastro, +32 para proximo nome
	#add $t4, $t1, 4			# Salva indice precoMedio, pois nao pode ser perdido
percorreCadastro:
	beq $s3, 320, fimMedia
	lw $t2, cadastro($s3)
	beq $t2, -1, loopCadastro
	addi $t3, $s3, 4
	addi $t5, $zero, 15
	add $t4, $t1, 4			# Salva indice precoMedio, (nao movimenta)
strcmp:	#Compara as strings letra por letra
	lb $s1, cadastro($t3)					
	lb $s2, precoMedio($t4)			
	subi $t5, $t5, 1			# Decrementa loop
	addi $t3, $t3, 1			# Incrementa indices
	addi $t4, $t4, 1
	bne $s1, $s2, loopCadastro		# Se letras diferentes pula para proximo nome
	bne $t5, 0, strcmp			
# Fim compara nomes---------------------------------------------------------------------------------	
	#---Nomes iguais---
	addi $t6, $zero, -1
	addi $t3, $s3, 15			# Adiciona 1 no indice para chegar no status do nome (16)	
	sb $t6, cadastro($t3)			# Marca com -1 o nome somado
	
	addi $t3, $s3, 28			# Incrementa indice para chegar no preco (15+13=28)

	lwc1 $f4, cadastro($t3)			# Move para f4 o preço
			
	add.s $f3, $f3, $f4 			# Soma preço no somatorio de preços
	add.s $f2, $f2, $f1			# Soma 1 a qtd de postos somados
	
	addi $s3, $s3, 32			# Completa o indice para chegar na proxima posicao	
	j percorreCadastro		 			 	 

loopCadastro:
	addi $s3, $s3, 32
	j percorreCadastro
	
fimMedia:
	div.s $f3, $f3, $f2
 	add $t4, $t1, $zero
 	swc1 $f3, precoMedio($t4)	# Grava o preco no vetor precoMedio 
	add $t0, $t0, 32	
	j vetorCadastro	


# Fim soma media------------------------------------------------------------------------------------	                
 
 ordena:                            



# Inicio impressao----------------------------------------------------------------------------------                                                                  
	addi $t4, $zero, 0 
	li $v0, 4		# Codigo de impressao de string
	la $a0, msgIdicaTeste	# Separacao dos dados
	syscall			#

imprimeMedia:

	#lw $t2, precoMedio($t0)	# Le a qtd de dias do vetor e salva em t2
	#beq $t2, -1, fimSemPrimt2

	lwc1 $f2, precoMedio($t4)# Le o preco vetor e salva em f0
	li $v0, 2		# Codigo de impressao de float
	add.s $f12, $f2, $f0 	# Imprime o preco por litros
	syscall			#
		
	li $v0, 4		# Codigo de impressao de string
	la $a0, pulaLinha	# Pula linha
	syscall			#
		
	addi $t4, $t4, 4	# Indice 16 do vetor
	li $v0, 4		# Codigo de impressao de string
	la $a0, precoMedio($t4)	# Imprime nome do posto
	syscall			#
	

	li $v0, 4		# Codigo de impressao de string
	la $a0, msgIdicaTeste	# Separacao dos dados
	syscall			#

	addi $t4, $t4, 16

	addi $t2, $zero, 200		#Valor limite do inice

	bne $t4, $t2, imprimeMedia

#fimSemPrimt2:
#	addi $t0, $t0, 20
#	addi $t2, $zero, 200		#Valor limite do inice

#	bne $t0, $t2, imprimeMedia
	
# Fim impressao-------------------------------------------------------------------------------------
	j menu	


		
			
# Fim preco medio*************************************************************************************

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
converteData:
	li $v0, 4		#
	la $a0, msgDia		# Msg dia
	syscall			#

	li $v0, 5 		#
	syscall 		# Le inteiro dia
	add $t1, $v0, $zero	# Armazena o dia em t1

	li $v0, 4		#
	la $a0, msgMes		# Msg mes
	syscall			#

	li $v0, 5 		#
	syscall 		# Le inteiro mes
	add $t2, $v0, $zero	# Armazena o mes em t2

	li $v0, 4		#
	la $a0, msgAno		# Msg ano
	syscall			#

	li $v0, 5 		#
	syscall 		# Le inteiro ano
	add $t3, $v0, $zero	# Armazena o ano em t3

	mul $t3, $t3, 10000	# Multiplica ano por 10000, abre espaco para adicionar mes e dia ex: 20180000 = 2018mmdd
	mul $t2, $t2, 100	# Multiplica mes por 100, abre espaco para adicionar dia ex: 0400 = 04dd
	
	add $t3, $t3, $t2
	add $t3, $t3, $t1
	
	add $v1, $t3, $zero	# Salva data convertida no reg v1 de passagem de parametros
	
	jr $ra
# Fim conversao de data**********************************************************************************
	
			
# Inicio  desconversao de data***************************************************************************
desconverteData: 		# Data a ser desconvertida recebida em a1
	div $a1, $a1, 100	# Divide data por 100 e salva o resto t1, resto = dia
	mfhi $t1
	
	div $a1, $a1, 100	# Divide data por 100 e salva o resto t2, resto = mes, sobra o ano em a1
	mfhi $t2
	
	
	li $v0, 1		# Codigo de impressao de inteiro
	addi $a0, $t1, 0	# Imprime qtd de dias
	syscall			#
	
	li $v0, 4		# Codigo de impressao de string
	la $a0, msgBarra	# Imprime barra para separar dias
	syscall			#
	
	li $v0, 1		# Codigo de impressao de inteiro
	addi $a0, $t2, 0	# Imprime qtd de dias
	syscall			#
	
	li $v0, 4		# Codigo de impressao de string
	la $a0, msgBarra	# Imprime barra para separar dias
	syscall			#
	
	li $v0, 1		# Codigo de impressao de inteiro
	addi $a0, $a1, 0	# Imprime qtd de dias
	syscall			#

	jr $ra
# Fim desconversao de data*******************************************************************************


# Inicio funcao imprime cadastros************************************************************************
imprimeCadastros:
	addi $t0, $zero, 0	# Idice 0 do vetor
	
	li $v0, 4		# Codigo de impressao de string
	la $a0, msgIdicaTeste	# Separacao dos dados
	syscall			#


loopImprime:

	lw $t2, cadastro($t0)	# Le a qtd de dias do vetor e salva em t2
	beq $t2, -1, fimSemPrimt

	add $t9, $ra, $zero	# Salva endereco de retorno desta funcao

	addi $a1, $t2, 0	# Salva data a ser convertida em a1 
	jal desconverteData	# Passa a1 como parametro para desconvercao da data

	add $ra, $t9, $zero	# Restaura endereco de retorno desta funcao

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
	lwc1 $f0, cadastro($t0)	# Le o preco vetor e salva em f0
	li $v0, 2		# Codigo de impressao de float
	add.s $f12, $f0, $f2 	# Imprime o preco por litros
	syscall			#

	li $v0, 4		# Codigo de impressao de string
	la $a0, msgIdicaTeste	# Separacao dos dados
	syscall			#

	addi $t0, $t0, 4


	addi $t2, $zero, 320		#Valor limite do inice

	bne $t0, $t2, loopImprime

fimSemPrimt:
	addi $t0, $t0, 32
	addi $t2, $zero, 320		#Valor limite do inice
	
	bne $t0, $t2, loopImprime

	jr $ra
# Fim funcao imprime cadastros***************************************************************************

# Inicio funcao consumo medio************************************************************************
	consumoMedio:
	addi $t0, $t0, 0	# Idice 0 do vetor
	
	addi $t0, $t0, 20	# Idice 0 do vetor
	lw $t1, cadastro($t0)	# Le a qtd de Km vetor e salva em t2
	addi $t7, $t1, 0
	
	loopMaior:
	beq $t0, 308, resposta
	addi $t0, $t0, 32
	lw $t1, cadastro($t0)	# Le a qtd de Km vetor e salva em t2
	bgt $t1, $t7, swap
	j loopMaior

	swap:
	addi $t7, $t1, 0
	j loopMaior
	
	resposta:
	li $v0, 1		# Codigo de impressao de inteiro
	addi $a0, $t7, 0	# Imprime qtd de km
	syscall	
	
		
	jr $ra
# Fim funcao consumo medio***************************************************************************
# Fim funcoes############################################################################################
