#!/bin/bash
set -e

##########################################################
#												  		 #
# ==> Autor: Elder M. Fouraux                            #
# 														 #	
# ==> Descrição: Habilita todos os cores do processador  #
#												         #
##########################################################

##################################################################################################################
#
#   Execute por sua conta e risco.
#
##################################################################################################################

numberofcores=$(grep -c ^processor /proc/cpuinfo)

if [ $numberofcores -gt 1 ]
then
        echo "You have " $numberofcores" cores."
        echo "Changing the makeflags for "$numberofcores" cores."
        sudo sed -i 's/#MAKEFLAGS="-j2"/MAKEFLAGS="-j'$(($numberofcores+1))'"/g' /etc/makepkg.conf;
        echo "Changing the compression settings for "$numberofcores" cores."
        sudo sed -i 's/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -T '"$numberofcores"' -z -)/g' /etc/makepkg.conf
else
        echo "No change."
fi


echo "######################################################################"
echo "###  Todos os cores serão usados durante o building e compression ####"
echo "######################################################################"
