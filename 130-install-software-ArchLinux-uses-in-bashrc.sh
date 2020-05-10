#!/bin/bash
set -e

#############################################################
#												  		    #
# ==> Autor: Elder M. Fouraux                               #
# 														    #	
# ==> Descrição: Instala programas necessários ao .bashrc   #
#												            #
############################################################# 

##################################################################################################################
#
#   Execute por sua conta e risco.
#
##################################################################################################################

echo "Installing the software ArcoLinux uses in .bashrc"

sudo pacman -S --noconfirm --needed expac
sudo pacman -S --noconfirm --needed hwinfo
sudo pacman -S --noconfirm --needed reflector
sudo pacman -S --noconfirm --needed youtube-dl


echo "################################################################"
echo "###                  software installed                     ####"
echo "################################################################"
