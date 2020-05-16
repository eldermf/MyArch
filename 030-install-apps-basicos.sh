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

sudo pacman -S --noconfirm --needed dosfstools
sudo pacman -S --noconfirm --needed os-prober
sudo pacman -S --noconfirm --needed mtools
sudo pacman -S --noconfirm --needed xdo
sudo pacman -S --noconfirm --needed xdotool
sudo pacman -S --noconfirm --needed dialog
sudo pacman -S --noconfirm --needed zenity
sudo pacman -S --noconfirm --needed bash-completion
sudo pacman -S --noconfirm --needed cronie
sudo pacman -S --noconfirm --needed galculator
sudo pacman -S --noconfirm --needed dmenu
sudo pacman -S --noconfirm --needed gmrun
sudo pacman -S --noconfirm --needed rofi
sudo pacman -S --noconfirm --needed firefox
sudo pacman -S --noconfirm --needed firefox-i18n-pt-br
sudo pacman -S --noconfirm --needed flashplugin
sudo pacman -S --noconfirm --needed youtube-dl
sudo pacman -S --noconfirm --needed cmatrix
sudo pacman -S --noconfirm --needed neofetch
sudo pacman -S --noconfirm --needed thunar
sudo pacman -S --noconfirm --needed thunar-archive-plugin
sudo pacman -S --noconfirm --needed thunar-volman
sudo pacman -S --noconfirm --needed gvfs
sudo pacman -S --noconfirm --needed gvfs-mtp
sudo pacman -S --noconfirm --needed numlockx
sudo pacman -S --noconfirm --needed unace 
sudo pacman -S --noconfirm --needed p7zip
sudo pacman -S --noconfirm --needed unrar
sudo pacman -S --noconfirm --needed zip
sudo pacman -S --noconfirm --needed unzip
sudo pacman -S --noconfirm --needed sharutils
sudo pacman -S --noconfirm --needed uudeview
sudo pacman -S --noconfirm --needed arj
sudo pacman -S --noconfirm --needed cabextract
sudo pacman -S --noconfirm --needed file-roller
sudo pacman -S --noconfirm --needed mlocate
sudo pacman -S --noconfirm --needed sshfs
sudo pacman -S --noconfirm --needed gparted
sudo pacman -S --noconfirm --needed grsync
sudo pacman -S --noconfirm --needed gtk-engine-murrine
sudo pacman -S --noconfirm --needed hardinfo
sudo pacman -S --noconfirm --needed hddtemp
sudo pacman -S --noconfirm --needed htop



echo "################################################################"
echo "###                  software installed                     ####"
echo "################################################################"
