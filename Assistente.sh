#!/bin/sh
#---------------------------------------------------------------------#
#  SECAO DE INFORMATICA DO 3ºBECmb                                    #
#  Criação: 25/09/2019                                                #
#  Automatizar algumas das tarefas referentes a manutenção            #
#  				                                      #
#                                              Sd Arend v1.6 laranja  #
#Bugs conhecidos: Instalador de token				      #
#---------------------------------------------------------------------#

#---------------------------------------------------------#
# Declaração das Variáveis
#---------------------------------------------------------#
Terminal=true
HostName=$(hostname)


Menu(){
   clear
   echo "------------------------------------------"
   echo "+					   +"
   echo "+		Assistente		   +"
   echo "+    		          		   +"
   echo "------------------------------------------"
   echo
   echo "[ 1 ] Habilitar Internet para o terminal(apt.conf)"
   echo "[ 2 ] Remover apt.conf"
   echo "[ 3 ] Instalar servidor de impressora"
   echo "[ 4 ] Desinstalar Servidor de impressora"
   echo "[ 5 ] Instalar Token"
   echo "[ 6 ] Instalar ntp.date"
   echo "[ 7 ] Atualizar"
   echo "[ 8 ] Sair"
   echo -n "Qual a opcao desejada ? "
   read opcao
   case $opcao in
	1) Internet ;;
	2) Remover ;;
	3) Impressao ;;
	4) Desinstalar ;;
	5) Token ;;
	6) ntp ;;
	7) Atualizar ;;

      8) exit ;;
      *) "Opcao desconhecida." ; echo ; Principal ;;
   esac
}
    #"------------------------------------------"
    #"+						 +"
    #"+		 Adicionar apt.conf		 +"
    #"+    		          		 +"
    #"------------------------------------------"

AptConf(){

echo "Verificando integridade de arquivos\n"

if [ -w "apt.conf" ]
then
    echo "apt.conf possui permissão de gravação para o usuário $USER. Continuando...\n"
    sleep 1
else
    echo "apt.conf NÃO possui permissão de gravação para o usuário $USER. Saindo..."
    exit
fi

echo "apt.confando"
cp apt.conf /etc/apt/
sleep 1
echo "apt.confado"

}

    #"------------------------------------------"
    #"+						 +"
    #"+		 executando AptConf		 +"
    #"+    		          		 +"
    #"------------------------------------------"
Internet() {

AptConf
Menu

}
#---------------------------------------------------Fim-------------------------------------------------------#
    #"------------------------------------------"
    #"+						 +"
    #"+		 Remover apt.conf		 +"
    #"+    		          		 +"
    #"------------------------------------------"
Remover() {

echo "Removendo apt.conf"
rm /etc/apt/apt.conf
Menu
}
#---------------------------------------------------Fim-------------------------------------------------------#
    #"------------------------------------------"
    #"+						 +"
    #"+		 Servidor de impressao		 +"
    #"+    		          		 +"
    #"------------------------------------------"
Impressao() {
echo "Iniciando configuração do servidor de impressão\n"
#---------------------------------------------------------------------------------#
echo "Parando cups"
/etc/init.d/cups stop
#---------------------------------------------------------------------------------#

#cups-browsed.conf
echo "Movendo cups-browsed.conf\n"
rm /etc/cups/cups-browsed.conf
cp cups-browsed.conf /etc/cups/
sleep 1

#Permissão cups-browsed.conf
echo "Modificando permissoes de cups-browsed.conf\n"
chmod 777 /etc/cups/cups-browsed.conf
sleep 1

#Teste permissão cups-browsed.conf
if [ -x "/etc/cups/cups-browsed.conf" ]
then
    echo "cups-browsed.conf possui permissão de execução. Continuando...\n"
    echo "--------------------------------------------------------------------------------"
    sleep 1
else
    echo "cups-browsed.conf NÃO possui permissão de execução. Saindo..."
    exit
fi

#---------------------------------------------------------------------------------#

#cupsd.conf
echo "Modificando cupsd.conf\n"
rm /etc/cups/cupsd.conf
cp cupsd.conf /etc/cups/
sleep 1

#Permissão cupsd.conf
echo "Modificando permissoes cupsd.conf\n"
chmod 777 /etc/cups/cupsd.conf
sleep 1

#Teste permissão cupsd.conf
if [ -x "/etc/cups/cupsd.conf" ]
then
    echo "cupsd.conf possui permissão de execução. Continuando...\n"
    echo "--------------------------------------------------------------------------------"
    sleep 1
else
    echo "cupsd.conf NÃO possui permissão de execução. Saindo..."
    exit
fi

#---------------------------------------------------------------------------------#

#avahi-daemon
echo "Movendo avahi-daemon\n"
rm /etc/default/avahi-daemon
cp avahi-daemon /etc/default/
sleep 1

#Permissão avahi-daemon
echo "Modificando permissoes avahi-daemon\n"
chmod 644 /etc/default/avahi-daemon

#Verificar se foi copiado avahi-daemon
if [ -e "/etc/default/avahi-daemon" ]
then
    echo "avahi-daemon foi movido corretamente. Continuando...\n"
    echo "--------------------------------------------------------------------------------"
    sleep 1
else
    echo "avahi-daemon NÃO existe. Saindo..."
    exit
fi


#---------------------------------------------------------------------------------#

#avahi-daemon.conf
echo "Movendo avahi-daemon.conf\n"
rm /etc/avahi/avahi-daemon.conf
cp avahi-daemon.conf /etc/avahi/
sleep 1

#Permissão avahi-daemon.conf
chmod 644 /etc/avahi/avahi-daemon.conf

#Verificar se foi copiado avahi-daemon
if [ -e "/etc/avahi/avahi-daemon.conf" ]
then
    echo "avahi-daemon.conf foi movido corretamente. Continuando...\n"
    echo "--------------------------------------------------------------------------------"
    sleep 1
else
    echo "avahi-daemon.conf NÃO existe. Saindo..."
    exit
fi

#---------------------------------------------------------------------------------#

#client.conf
echo "Movendo client.conf\n"
rm /etc/cups/client.conf
cp client.conf /etc/cups/
sleep 1

#Permissão Cliente.conf
echo "Modificando permissoes Client.conf\n"
chmod 644 /etc/cups/client.conf
sleep 1

#Verificar se foi copiado client.conf
if [ -e "/etc/cups/client.conf" ]
then
    echo "client.conf foi movido corretamente. Continuando...\n"
    echo "--------------------------------------------------------------------------------"
    sleep 1
else
    echo "client.conf NÃO existe. Saindo..."
    exit
fi


#---------------------------------------------------------------------------------#

echo "Arquivos verificados com exito, continuando para o assistente\n"
sleep 2
#Reiniciar Cups
/etc/init.d/cups restart

Menu
}
#---------------------------------------------------Fim-------------------------------------------------------#

    #"-------------------------------------------------------------"
    #"+						                  +"
    #"+		 Desinstalar servidor de impressao		  +"
    #"+    		          	                          +"
    #"-------------------------------------------------------------"
Desinstalar() {
echo "Iniciando desinstalacao do servidor de impressão\n"
#---------------------------------------------------------------------------------#
echo "Parando cups"
/etc/init.d/cups stop
#---------------------------------------------------------------------------------#

#cupsd.conf
echo "Modificando cupsd.conf\n"
rm /etc/cups/cupsd.conf
cp cupsdPadrao.conf /etc/cups/cupsd.conf
sleep 1

#Permissão cupsd.conf
echo "Modificando permissoes cupsd.conf\n"
chmod 777 /etc/cups/cupsd.conf
sleep 1

#Teste permissão cupsd.conf
if [ -x "/etc/cups/cupsd.conf" ]
then
    echo "cupsd.conf possui permissão de execução. Continuando...\n"
    echo "--------------------------------------------------------------------------------"
    sleep 1
else
    echo "cupsd.conf NÃO possui permissão de execução. Saindo..."
    exit
fi

#---------------------------------------------------------------------------------#

#client.conf
echo "Movendo client.conf\n"
rm /etc/cups/client.conf
cp clientPadrao.conf /etc/cups/client.conf
sleep 1

#Permissão Cliente.conf
echo "Modificando permissoes Client.conf\n"
chmod 644 /etc/cups/client.conf
sleep 1

#Verificar se foi copiado client.conf
if [ -e "/etc/cups/client.conf" ]
then
    echo "client.conf foi movido corretamente. Continuando...\n"
    echo "--------------------------------------------------------------------------------"
    sleep 1
else
    echo "client.conf NÃO existe. Saindo..."
    exit
fi


#---------------------------------------------------------------------------------#
#Reiniciar Cups
/etc/init.d/cups restart

Menu
}
#---------------------------------------------------Fim-------------------------------------------------------#

    #"-------------------------------------"
    #"+					  +"
    #"+		 Instalar Token		  +"
    #"+    		                  +"
    #"-------------------------------------"

Token() {


echo "Intalando Token Admin"
dpkg -i SafeSign.deb
sleep 1

#---------------------------------------------------------------------------------#


echo "Intalando Token Admin"
dkpg -i libgdbm3_1.8.3-14_amd64.deb
sleep 1

#---------------------------------------------------------------------------------#


echo "Intalando Token Admin"
dpkg -i libpng12-0_1.2.54-1ubuntu1.1_amd64.deb
sleep 1

#---------------------------------------------------------------------------------#


echo "Intalando Token Admin"
dpkg -i libjpeg62-turbo_1.5.2-2+b1_amd64.deb
sleep 1

#---------------------------------------------------------------------------------#

echo "Intalando Token Admin"
dpkg -i libwxbase2.8-0_2.8.12.1+dfsg2-dmo4_amd64.deb
sleep 1

#---------------------------------------------------------------------------------#

echo "Intalando Token Admin"
dpkg -i libwxgtk2.8-0_2.8.12.1+dfsg2-dmo4_amd64.deb
sleep 1

#---------------------------------------------------------------------------------#

echo "Token instalada com sucesso"
Menu
}
#---------------------------------------------------Fim-------------------------------------------------------#

    #"-------------------------------------"
    #"+					  +"
    #"+		 Instalar ntp		  +"
    #"+    		                  +"
    #"-------------------------------------"

ntp(){
#---------------------------------------------------------------------------------#
AptConf
#---------------------------------------------------------------------------------#
echo "Instalando ntpdate"
yes | apt-get install ntpdate
sleep 1
#---------------------------------------------------------------------------------#
echo "Ajustando horario"
./ntp.date
sleep 1
#---------------------------------------------------------------------------------#
echo "movendo ntp.date"
mv ntp.date /etc/cron.hourly/
sleep 1
#---------------------------------------------------------------------------------#
echo "adicionando permição de execução"
chmod +x /etc/cron.hourly/ntp.date
sleep 1
#---------------------------------------------------------------------------------#
}

#---------------------------------------------------Fim-------------------------------------------------------#

    #"-------------------------------------"
    #"+					  +"
    #"+		    Atualizar		  +"
    #"+    		                  +"
    #"-------------------------------------"

Atualizar(){

AptConf

yes | apt-get update
yes | apt get install gnome-panel 
yes | apt-get install flashplugin-installer
yes | apt-get upgrade

}
#---------------------------------------------------Fim-------------------------------------------------------#
Menu
