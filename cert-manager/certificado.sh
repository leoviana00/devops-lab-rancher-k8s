#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Data de criação: 25/05/2021
# Data de atualização: 07/06/2021
# Versão: 0.09
# Testado e homologado para a versão do Ubuntu Server 18.04.x LTS x64
# Kernel >= 4.15.x
# Testado e homologado para a versão do OpenSSL 1.1.x
#
# OpenSSL é uma implementação de código aberto dos protocolos SSL e TLS. A biblioteca (escrita na 
# linguagem C) implementa as funções básicas de criptografia e disponibiliza várias funções utilitárias.
# Também estão disponíveis wrappers que permitem o uso desta biblioteca em várias outras linguagens. 
#
# O OpenSSL está disponível para a maioria dos sistemas do tipo Unix, incluindo Linux, Mac OS X, as 
# quatro versões do BSD de código aberto e também para o Microsoft Windows. O OpenSSL é baseado no 
# SSLeay de Eric Young e Tim Hudson. O OpenSSL é utilizado para gerar certificados de autenticação 
# de serviços/protocolos em servidores (servers).
#
# O Transport Layer Security (TLS), assim como o seu antecessor Secure Sockets Layer (SSL), é um 
# protocolo de segurança projetado para fornecer segurança nas comunicações sobre uma rede de 
# computadores. Várias versões do protocolo encontram amplo uso em aplicativos como navegação na web, 
# email, mensagens instantâneas e voz sobre IP (VoIP). Os sites podem usar o TLS para proteger todas 
# as comunicações entre seus servidores e navegadores web.
#
# Instalação da Autoridade Certificadora CA no Mozilla Firefox (GNU/Linux ou Microsoft Windows)
# Abrir menu de Aplicativo
#	Preferências ou Opções ou Configurações
#		Pesquisar em preferências: Ver certificados
#			Autoridades
#				Importar: ca-pticrt.crt
#					Yes: Confiar nesta CA para identificar sites
#					Yes: Confiar nesta autoridade certificadora para identificar usuários de email
#				Bora para Pratica
#					ptispo01ws01.pti.intra
#
# Instalação da Autoridade Certificadora CA no Google Chrome (GNU/Linux)
# chrome://settings/certificates
#	Autoridades
#		Importar: ca-pticrt.crt
#			Yes: Confiar neste certificado para a identificação de websites.
#			Yes: Confiar neste certificado para identificar usuários de e-mail
#			Yes: Confiar neste certificado para a identificação de criadores de software
#		org-Bora para Pratica
#			ptispo01ws01.pti.intra
#	chrome://restart
#
# Instalação da Autoridade Certificadora CA no Microsoft Edge (GNU/Linux)
# Abrir menu de Aplicativo
#	Configurações
#		Gerenciar Certificados
#			Autoridades
#				Importar
#
# Instalação da Autoridade Certificadora CA no Opera (GNU/Linux)
# Abrir o Easy Setup
#	Go to full browser settings
#		Search settings: manage certificates
#			Security
#				Manage Certificates
#					Authorities
#						Imports

# Instalação da Autoridade Certificadora CA no GNU/Linux
# Pasta: Download
#		Abrir como Root (Botão direito do Mouse: Abrir como root)
#			Copiar: ca-pticrt.crt
#			Para: /usr/local/share/ca-certificates/
#		Terminal
#			sudo update-ca-certificates
#
# Instalação da Autoridade Certificadora CA no Microsoft Windows
# Pasta: Download
#		ca-pticrt.crt (clicar duas vezes em cima do certificado)
#			Abrir
#				Instalar Certificado...
#					Assistente para Importação de Certificados
#						Máquina Local <Avançar>
#							Deseja permitir que este aplicativo faça alterações no seu dispositivo? <sim>
#								Colocar todos os certificados no repositório a seguir
#									Repositório de Certificados <Procurar>
#										Autoridades de Certificação Raiz Confiáveis <OK>
#										<Avançar>
#										<Concluir>
#										<OK>
#										<OK>
#
# Pesquisa do Windows
#	Gerenciar Certificados de Computador <Sim>
#		Autoridades de Certificação Raiz Confiáveis
#			Certificados
#				Emitido para:
#					ptispo01ws01.pti.intra
#
# Site Oficial do Projeto: https://www.openssl.org/
# Manual do OpenSSL: https://man.openbsd.org/openssl.1
#
# Vídeo de instalação do GNU/Linux Ubuntu Server 18.04.x LTS: https://www.youtube.com/watch?v=zDdCrqNhIXI
# Vídeo de configuração do OpenSSH no GNU/Linux Ubuntu Server 18.04.x LTS: https://www.youtube.com/watch?v=ecuol8Uf1EE&t
# Vídeo de instalação do LAMP Server no Ubuntu Server 18.04.x LTS: https://www.youtube.com/watch?v=6EFUu-I3
# Vídeo de instalação do Bind9 DNS e ISC DHCP Server no Ubuntu Server 18.04.x LTS: https://www.youtube.com/watch?v=NvD9Vchsvbk
#
# Variável da Data Inicial para calcular o tempo de execução do script (VARIÁVEL MELHORADA)
# opção do comando date: +%T (Time)
HORAINICIAL=$(date +%T)
#
# Variáveis para validar o ambiente, verificando se o usuário e "root", versão do ubuntu e kernel
# opções do comando id: -u (user)
# opções do comando: lsb_release: -r (release), -s (short), 
# opões do comando uname: -r (kernel release)
# opções do comando cut: -d (delimiter), -f (fields)
# opção do shell script: piper | = Conecta a saída padrão com a entrada padrão de outro comando
# opção do shell script: acento crase ` ` = Executa comandos numa subshell, retornando o resultado
# opção do shell script: aspas simples ' ' = Protege uma string completamente (nenhum caractere é especial)
# opção do shell script: aspas duplas " " = Protege uma string, mas reconhece $, \ e ` como especiais
USUARIO=$(id -u)
UBUNTU=$(lsb_release -rs)
KERNEL=$(uname -r | cut -d'.' -f1,2)
#
# Variável do caminho do Log dos Script utilizado nesse curso (VARIÁVEL MELHORADA)
# opções do comando cut: -d (delimiter), -f (fields)
# $0 (variável de ambiente do nome do comando)
LOG="/var/log/$(echo $0 | cut -d'/' -f2)"
#
# Declarando as variáveis utilizadas na geração da chave privada/pública e dos certificados do OpenSSL
PASSPHRASE="vaamonde"
CRIPTOKEY="aes256" #opções: -aes128, -aes192, -aes256 (padrão), -camellia128, -camellia192, -camellia256, -des, -des3 ou -idea)
BITS="2048" #opções: 1024, 2048 (padrão), 3072 ou 4096)
CRIPTOCERT="sha256" #opções: md5, -sha1, sha224, sha256 (padrão), sha384 ou sha512)
#
# Exportando o recurso de Noninteractive do Debconf para não solicitar telas de configuração
export DEBIAN_FRONTEND="noninteractive"
#
# Verificando se o usuário é Root, Distribuição é >=18.04 e o Kernel é >=4.15 <IF MELHORADO)
# [ ] = teste de expressão, && = operador lógico AND, == comparação de string, exit 1 = A maioria dos erros comuns na execução
clear
if [ "$USUARIO" == "0" ] 
	then
		echo -e "O usuário é Root, continuando com o script..."
		sleep 5
	else
		echo -e "Usuário não é Root ($USUARIO)"
		exit 1
fi
#
# Verificando se as dependências do OpenSSL estão instaladas
# opção do dpkg: -s (status), opção do echo: -e (interpretador de escapes de barra invertida), -n (permite nova linha)
# || (operador lógico OU), 2> (redirecionar de saída de erro STDERR), && = operador lógico AND, { } = agrupa comandos em blocos
# [ ] = testa uma expressão, retornando 0 ou 1, -ne = é diferente (NotEqual)
echo -n "Verificando as dependências do OpenSSL, aguarde... "
	for name in openssl apache2 bind9
	do
  		[[ $(dpkg -s $name 2> /dev/null) ]] || { 
              echo -en "\n\nO software: $name precisa ser instalado. \nUse o comando 'apt install $name'\n";
              deps=1; 
              }
	done
		[[ $deps -ne 1 ]] && echo "Dependências.: OK" || { 
            echo -en "\nInstale as dependências acima e execute novamente este script\n";
			echo -en "Recomendo utilizar o script: lamp.sh para resolver as dependências."
			echo -en "Recomendo utilizar o script: dnsdhcp.sh para resolver as dependências."
            exit 1; 
            }
		sleep 5
#
# Script de configuração do OpenSSL no GNU/Linux Ubuntu Server 18.04.x
# opção do comando echo: -e (enable interpretation of backslash escapes), \n (new line)
# opção do comando hostname: -I (all IP address), -A (all FQDN name), -d (domain)
# opções do comando cut: -d (delimiter), -f (fields)
# opção do comando date: + (format), %d (day), %m (month), %Y (year 1970), %H (hour 24), %M (minute 60)
echo -e "Início do script $0 em: `date +%d/%m/%Y-"("%H:%M")"`\n" &>> $LOG
clear
#
echo
echo -e "Configuração do OpenSSL no GNU/Linux Ubuntu Server 18.04.x\n"
echo -e "Download da Autoridade Certificadora CA na URL: https://`hostname -I | cut -d' ' -f1`/download"
echo -e "Confirmar o acesso com o Nome CNAME na URL: https://www.`hostname -d | cut -d' ' -f1`/"
echo -e "Confirmar o acesso com o Nome Domínio na URL: https://`hostname -d | cut -d' ' -f1`/"
echo -e "Confirmar o acesso com o Nome FQDN na URL: https://`hostname -A | cut -d' ' -f1`/\n"
sleep 5
#
echo -e "Adicionando o Repositório Universal do Apt, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	add-apt-repository universe &>> $LOG
echo -e "Repositório adicionado com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Adicionando o Repositório Multiversão do Apt, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	add-apt-repository multiverse &>> $LOG
echo -e "Repositório adicionado com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Atualizando as listas do Apt, aguarde..."
	#opção do comando: &>> (redirecionar a saída padrão)
	apt update &>> $LOG
echo -e "Listas atualizadas com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Atualizando o sistema, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando apt: -y (yes)
	apt -y upgrade &>> $LOG
echo -e "Sistema atualizado com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Removendo software desnecessários, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando apt: -y (yes)
	apt -y autoremove &>> $LOG
echo -e "Software removidos com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Criando a estrutura de diretórios do CA e dos Certificados, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando mkdir: -v (verbose), {} (agrupa comandos em blocos)
	mkdir -v /etc/ssl/{newcerts,certs,crl,private,requests} &>> $LOG
echo -e "Estrutura de diretórios criada com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Atualizando os arquivos de configuração da CA e dos Certificados, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão adicionando)
	# opção do comando touch: {} (agrupa comandos em blocos)
	# opção do comando cp: -v (verbose)
	touch /etc/ssl/{index.txt,index.txt.attr} &>> $LOG
	echo "1234" > /etc/ssl/serial
	cp -v conf/pti-ca.conf conf/pti-ssl.conf /etc/ssl/ &>> $LOG
echo -e "Arquivos atualizados com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Primeira Etapa: Criando a CA (Certificate Authority) Interna, aguarde...\n"
sleep 5
#
echo -e "Criando o Chave Raiz de $BITS bits da CA, senha padrão: $PASSPHRASE, aguarde..." 
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando rm: -v (verbose)
	# opção do comando openssl: genrsa (command generates an RSA private key),
	#							-criptokey (Encrypt the private key with the AES, CAMELLIA, DES, triple DES or the IDEA ciphers)
	#							-out (The output file to write to, or standard output if not specified), 
	#							-passout (The output file password source), 
	#							pass: (The actual password is password), 
	#							bits (The size of the private key to generate in bits)
	openssl genrsa -$CRIPTOKEY -out /etc/ssl/private/ca-ptikey.key.old -passout pass:$PASSPHRASE $BITS &>> $LOG
echo -e "Chave Raiz da CA criada com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Removendo a senha da Chave Raiz da CA, senha padrão: $PASSPHRASE, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando openssl: rsa (command processes RSA keys),
	#							-in (The input file to read from, or standard input if not specified),
	#							-out (The output file to write to, or standard output if not specified),
	#							-passin (The key password source),
	#							pass: (The actual password is password)
	# opção do comando rm: -v (verbose)
	openssl rsa -in /etc/ssl/private/ca-ptikey.key.old -out /etc/ssl/private/ca-ptikey.key \
	-passin pass:$PASSPHRASE &>> $LOG
	rm -v /etc/ssl/private/ca-ptikey.key.old &>> $LOG
echo -e "Senha da Chave Raiz da CA removida com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Verificando o arquivo de Chave Raiz da CA, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando openssl: rsa (command processes RSA keys), 
	#							-noout (Do not output the encoded version of the key), 
	#							-modulus (Print the value of the modulus of the key), 
	#							-in (The input file to read from, or standard input if not specified), 
	#							md5 (The message digest to use MD5 checksums)
	openssl rsa -noout -modulus -in /etc/ssl/private/ca-ptikey.key | openssl md5 &>> $LOG
echo -e "Arquivo de Chave Raiz da CA verificado com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Editando o arquivo de configuração da CA, pressione <Enter> para continuar."
	# opção do comando: &>> (redirecionar a saída padrão)
	read
	vim /etc/ssl/pti-ca.conf
echo -e "Arquivo editado com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Criando o arquivo CSR (Certificate Signing Request), confirme as mensagens do arquivo: pti-ca.conf, aguarde...\n"
	# opção do comando openssl: req (command primarily creates and processes certificate requests in PKCS#10 format), 
	#							-new (Generate a new certificate request),
	#							-criptocert (The message digest to sign the request with)
	#							-nodes (Do not encrypt the private key),
	# 							-key (The file to read the private key from), 
	#							-out (The output file to write to, or standard output if not specified),
	#							-extensions (Specify alternative sections to include certificate extensions), 
	#							-config (Specify an alternative configuration file)
	# Criando o arquivo CSR, mensagens que serão solicitadas na criação do CSR
	# 	Country Name (2 letter code): BR <-- pressione <Enter>
	# 	State or Province Name (full name): Brasil <-- pressione <Enter>
	# 	Locality Name (eg, city): Sao Paulo <-- pressione <Enter>
	# 	Organization Name (eg, company): Bora para Pratica <-- pressione <Enter>
	# 	Organization Unit Name (eg, section): Procedimentos em TI <-- pressione <Enter>
	# 	Common Name (eg, server FQDN or YOUR name): ptispo01ws01.pti.intra <-- pressione <Enter>
	# 	Email Address: pti@pti.intra <-- pressione <Enter>
	openssl req -new -$CRIPTOCERT -nodes -key /etc/ssl/private/ca-ptikey.key -out \
	/etc/ssl/requests/ca-pticsr.csr -config /etc/ssl/pti-ca.conf
	echo
echo -e "Criação do arquivo CSR feito com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Criando o arquivo CRT (Certificate Request Trust), confirme as mensagens do arquivo: pti-ca.conf, aguarde...\n"
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando openssl: req (command primarily creates and processes certificate requests in PKCS#10 format),
	#							-new (Generate a new certificate request),
	#							-x509 (Output a self-signed certificate instead of a certificate request),
	#							-criptocert (The message digest to sign the request with)
	#							-days (Specify the number of days to certify the certificate for),
	#							-in (The input file to read from, or standard input if not specified)
	#							-key (The file to read the private key from),
	#							-out (The output file to write to, or standard output if not specified),
	#							-set_serial (Serial number to use when outputting a self-signed certificate),
	#							-extensions (Specify alternative sections to include certificate extensions),
	#							-config (Specify an alternative configuration file).
	# Criando o arquivo CRT, mensagens que serão solicitadas na criação da CA
	# 	Country Name (2 letter code): BR <-- pressione <Enter>
	# 	State or Province Name (full name): Brasil <-- pressione <Enter>
	# 	Locality Name (eg, city): Sao Paulo <-- pressione <Enter>
	# 	Organization Name (eg, company): Bora para Pratica <-- pressione <Enter>
	# 	Organization Unit Name (eg, section): Procedimentos em TI <-- pressione <Enter>
	# 	Common Name (eg, server FQDN or YOUR name): pti.intra <-- pressione <Enter>
	# 	Email Address: pti@pti.intra <-- pressione <Enter>
	#
	openssl req -new -x509 -$CRIPTOCERT -days 3650 -in /etc/ssl/requests/ca-pticsr.csr -key \
	/etc/ssl/private/ca-ptikey.key -out /etc/ssl/newcerts/ca-pticrt.crt -config /etc/ssl/pti-ca.conf
	echo
echo -e "Criação do arquivo CRT feito com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Verificando o arquivo CRT (Certificate Request Trust) da CA, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando openssl: x509 (command is a multi-purpose certificate utility), 
	#							-noout (Do not output the encoded version of the request), 
	#							-modulus (Print the value of the modulus of the public key contained in the certificate),
	#							-text (Print the full certificate in text form), 
	#							-in (The input file to read from, or standard input if not specified), 
	#							md5 (The message digest to use MD5 checksums)
	openssl x509 -noout -modulus -in /etc/ssl/newcerts/ca-pticrt.crt | openssl md5 &>> $LOG
	openssl x509 -noout -text -in /etc/ssl/newcerts/ca-pticrt.crt &>> $LOG
echo -e "Arquivo CRT da CA verificado com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Habilitando o arquivo CRT (Certificate Request Trust) da CA, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando cp: -v (verbose)
	# opção do comando ls: -l (list), -h (human-readable), -a (all)
	cp -v /etc/ssl/newcerts/ca-pticrt.crt /usr/local/share/ca-certificates/ &>> $LOG
	update-ca-certificates &>> $LOG
	ls -lha /etc/ssl/certs/ca-pticrt* &>> $LOG
echo -e "Arquivo CRT da CA habilitado com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Segunda Etapa: Criando o Certificado de Servidor Assinado do Apache2, aguarde...\n"
sleep 5
#
echo -e "Criando o Chave Privada de $BITS do Apache2, senha padrão: $PASSPHRASE, aguarde..." 
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando openssl: genrsa (command generates an RSA private key),
	#							-criptokey (Encrypt the private key with the AES, CAMELLIA, DES, triple DES or the IDEA ciphers)
	#							-out (The output file to write to, or standard output if not specified), 
	#							-passout (The output file password source), 
	#							pass: (The actual password is password), 
	#							bits (The size of the private key to generate in bits)
	openssl genrsa -$CRIPTOKEY -out /etc/ssl/private/apache2-ptikey.key.old -passout pass:$PASSPHRASE $BITS &>> $LOG
echo -e "Chave Privada do Apache2 criada com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Removendo a senha da Chave Privada do Apache2, senha padrão: $PASSPHRASE, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando openssl: rsa (command processes RSA keys),
	#							-in (The input file to read from, or standard input if not specified),
	#							-out (The output file to write to, or standard output if not specified),
	#							-passin (The key password source),
	#							pass: (The actual password is password)
	# opção do comando rm: -v (verbose)
	openssl rsa -in /etc/ssl/private/apache2-ptikey.key.old -out /etc/ssl/private/apache2-ptikey.key \
	-passin pass:$PASSPHRASE &>> $LOG
	rm -v /etc/ssl/private/apache2-ptikey.key.old &>> $LOG
echo -e "Senha da Chave Privada do Apache2 removida com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Verificando o arquivo de Chave Privada do Apache2, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando openssl: rsa (command processes RSA keys), 
	#							-noout (Do not output the encoded version of the key), 
	#							-modulus (Print the value of the modulus of the key), 
	#							-in (The input file to read from, or standard input if not specified), 
	#							md5 (The message digest to use MD5 checksums)
	openssl rsa -noout -modulus -in /etc/ssl/private/apache2-ptikey.key | openssl md5 &>> $LOG
echo -e "Arquivo de Chave Privada do Apache2 verificado com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Editando o arquivo configuração do Certificado do Apache2, pressione <Enter> para continuar."
	# opção do comando: &>> (redirecionar a saída padrão)
	read
	vim /etc/ssl/pti-ssl.conf
echo -e "Arquivo editado com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Criando o arquivo CSR (Certificate Signing Request), confirme as mensagens do arquivo: pti-ssl.conf, aguarde...\n"
	# opção do comando openssl: req (command primarily creates and processes certificate requests in PKCS#10 format), 
	#							-new (Generate a new certificate request),
	#							-criptocert (The message digest to sign the request with)
	#							-nodes (Do not encrypt the private key),
	# 							-key (The file to read the private key from), 
	#							-out (The output file to write to, or standard output if not specified),
	#							-extensions (Specify alternative sections to include certificate extensions), 
	#							-config (Specify an alternative configuration file)
	# Criando o arquivo CSR, mensagens que serão solicitadas na criação do CSR
	# 	Country Name (2 letter code): BR <-- pressione <Enter>
	# 	State or Province Name (full name): Brasil <-- pressione <Enter>
	# 	Locality Name (eg, city): Sao Paulo <-- pressione <Enter>
	# 	Organization Name (eg, company): Bora para Pratica <-- pressione <Enter>
	# 	Organization Unit Name (eg, section): Procedimentos em TI <-- pressione <Enter>
	# 	Common Name (eg, server FQDN or YOUR name): pti.intra <-- pressione <Enter>
	# 	Email Address: pti@pti.intra <-- pressione <Enter>
	openssl req -new -$CRIPTOCERT -nodes -key /etc/ssl/private/apache2-ptikey.key -out \
	/etc/ssl/requests/apache2-pticsr.csr -extensions v3_req -config /etc/ssl/pti-ssl.conf
	echo
echo -e "Criação do arquivo CSR feito com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Verificando o arquivo CSR (Certificate Signing Request) do Apache2, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando openssl: req (command primarily creates and processes certificate requests in PKCS#10 format), 
	# 							-noout (Do not output the encoded version of the request), 
	#							-text (Print the certificate request in plain text), 
	#							-in (The input file to read a request from, or standard input if not specified)
	openssl req -noout -text -in /etc/ssl/requests/apache2-pticsr.csr &>> $LOG
echo -e "Arquivo CSR verificado com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Criando o certificado assinado CRT (Certificate Request Trust), do Apache2, aguarde...\n"
	# opção do comando: &>> (redirecionar a saída padrão
	# opção do comando openssl: x509 (command is a multi-purpose certificate utility),
	#							ca (command is a minimal certificate authority (CA) application)
	#							-req (Expect a certificate request on input instead of a certificate),
	#							-days (The number of days to make a certificate valid for),
	#							-criptocert (The message digest to sign the request with),							
	#							-in (The input file to read from, or standard input if not specified),
	#							-CA (The CA certificate to be used for signing),
	#							-CAkey (Set the CA private key to sign a certificate with),
	#							-CAcreatesrial (Create the CA serial number file if it does not exist instead of generating an error),
	#							-out (The output file to write to, or standard output if none is specified)
	#							-config (Specify an alternative configuration file)
	#							-extensions (The section to add certificate extensions from),
	#							-extfile (File containing certificate extensions to use).
	#
	# Sign the certificate? [y/n]: y <Enter>
	# 1 out of 1 certificate request certified, commit? [y/n]: y <Enter>
	#
	# OPÇÃO DE ASSINATURA DO ARQUIVO CRT SEM UTILIZAR O WIZARD DO CA, CÓDIGO APENAS DE DEMONSTRAÇÃO
	#openssl x509 -req -days 3650 -$CRIPTOCERT -in /etc/ssl/requests/apache2-pticsr.csr -CA \
	#/etc/ssl/newcerts/ca-pticrt.crt -CAkey /etc/ssl/private/ca-ptikey.key -CAcreateserial \
	#-out /etc/ssl/newcerts/apache2-pticrt.crt -extensions v3_req -extfile /etc/ssl/pti-ssl.conf &>> $LOG
	#
	openssl ca -in /etc/ssl/requests/apache2-pticsr.csr -out /etc/ssl/newcerts/apache2-pticrt.crt \
	-config /etc/ssl/pti-ca.conf -extensions v3_req -extfile /etc/ssl/pti-ssl.conf
	echo
echo -e "Criação do certificado assinado CRT do Apache2 feito com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Verificando o arquivo CRT (Certificate Request Trust) do Apache2, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando openssl: x509 (command is a multi-purpose certificate utility), 
	#							-noout (Do not output the encoded version of the request),
	#							-text (Print the full certificate in text form), 
	#							-modulus (Print the value of the modulus of the public key contained in the certificate), 
	#							-in (he input file to read from, or standard input if not specified), 
	#							md5 (The message digest to use MD5 checksums)
	openssl x509 -noout -modulus -in /etc/ssl/newcerts/apache2-pticrt.crt | openssl md5 &>> $LOG
	openssl x509 -noout -text -in /etc/ssl/newcerts/apache2-pticrt.crt &>> $LOG
	cat /etc/ssl/index.txt &>> $LOG
	cat /etc/ssl/serial &>> $LOG
echo -e "Arquivo CRT do Apache2 verificado com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Terceira Etapa: Configurando o suporte TLS/SSL HTTPS no Apache2, aguarde...\n"
sleep 5
#
echo -e "Atualizando o arquivo de configuração do Apache2 HTTPS, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando mv: -v (verbose)
	# opção do comando cp: -v (verbose)
	mv -v /etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf.bkp &>> $LOG
	cp -v conf/default-ssl.conf /etc/apache2/sites-available/ &>> $LOG
echo -e "Arquivo atualizado com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Editando o arquivo de configuração do Apache2 HTTPS, pressione <Enter> para continuar"
	read
	vim /etc/apache2/sites-available/default-ssl.conf
echo -e "Arquivo editado com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Criando o diretório de Download para baixar a Unidade Certificadora CA, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando mkdir: -v (verbose)
	# opção do comando chown: -v (verbose), www-data (user), www-data (group)
	# opção do comando cp: -v (verbose)
	mkdir -v /var/www/html/download/ &>> $LOG
	chown -v www-data:www-data /var/www/html/download/ &>> $LOG
	cp -v /etc/ssl/newcerts/ca-pticrt.crt /var/www/html/download/ &>> $LOG
echo -e "Diretório criado com sucesso!!!, continuando com o script...\n"
sleep 2
#
echo -e "Habilitando o suporte ao TLS/SSL e o Site HTTPS do Apache2, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	a2enmod ssl &>> $LOG
	a2enmod headers &>> $LOG
	a2ensite default-ssl &>> $LOG
	apache2ctl configtest &>> $LOG
echo -e "Site HTTPS do Apache2 habilitado com sucesso!!!, continuando com o script...\n"
sleep 2
#
echo -e "Reinicializando o serviço do Apache2, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	systemctl restart apache2 &>> $LOG
echo -e "Serviço reinicializado com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Verificando as portas de conexões do Apache2, aguarde..."
	# opção do comando netstat: a (all), n (numeric)
	# opção do comando grep: -i (ignore case)
	netstat -an | grep ':80\|:443'
echo -e "Portas verificadas com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Testando o Certificado do Apache2, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando echo: | (piper, faz a função de Enter no comando)
	# opção do comando openssl: s_client (command implements a generic SSL/TLS client which connects to a remote host using SSL/TLS)
	#							-connect (The host and port to connect to)
	#							-servername (Include the TLS Server Name Indication (SNI) extension in the ClientHello message)
	#							-showcerts (Display the whole server certificate chain: normally only the server certificate itself is displayed)
	echo | openssl s_client -connect localhost:443 -servername www.pti.intra -showcerts &>> $LOG
echo -e "Certificado do Apache2 testando sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Configuração do OpenSSL e TLS/SSL do Apache2 feita com Sucesso!!!."
	# script para calcular o tempo gasto (SCRIPT MELHORADO, CORRIGIDO FALHA DE HORA:MINUTO:SEGUNDOS)
	# opção do comando date: +%T (Time)
	HORAFINAL=$(date +%T)
	# opção do comando date: -u (utc), -d (date), +%s (second since 1970)
	HORAINICIAL01=$(date -u -d "$HORAINICIAL" +"%s")
	HORAFINAL01=$(date -u -d "$HORAFINAL" +"%s")
	# opção do comando date: -u (utc), -d (date), 0 (string command), sec (force second), +%H (hour), %M (minute), %S (second), 
	TEMPO=$(date -u -d "0 $HORAFINAL01 sec - $HORAINICIAL01 sec" +"%H:%M:%S")
	# $0 (variável de ambiente do nome do comando)
	echo -e "Tempo gasto para execução do script $0: $TEMPO"
echo -e "Pressione <Enter> para concluir o processo."
# opção do comando date: + (format), %d (day), %m (month), %Y (year 1970), %H (hour 24), %M (minute 60)
echo -e "Fim do script $0 em: `date +%d/%m/%Y-"("%H:%M")"`\n" &>> $LOG
read
exit 1