#!/usr/bin/env bash

###################################################
#												  #
# ==> Autor: Elder M. Fouraux                     #
#                                                 #
# ==> Descrição: executa arch-chroot              #
#												  #
###################################################

clear

xorg_video() {
echo -e "
Nesta etapa, vamos instalar os pacotes básicos xorg, placas de vídeo e 
pacotes básicos para iniciarmos o sistema.

· xorg 						- servidor de exibição gráfica
· xf86-video-intel			- módulo da placa de vídeo intel
· curl, git e wget          - ferramenta para transferência de dados
· lynx, w3m        			- navegador web CLI

Podemos prosseguir (s/N)? \c
"
    read answer
    if [[ $answer = [sSyY] ]]; then
        echo -e "\nInstalando...\n"

        sudo pacman -S --noconfirm --needed xorg
        sudo pacman -S --noconfirm --needed xorg-xinit
        sudo pacman -S --noconfirm --needed xorg-xrandr
        sudo pacman -S --noconfirm --needed xorg-xkill
        sudo pacman -S --noconfirm --needed virtualbox-guest-utils
        sudo pacman -S --noconfirm --needed pulseaudio-alsa
        sudo pacman -S --noconfirm --needed pavucontrol
        sudo pacman -S --noconfirm --needed ttf-fira-code
        sudo pacman -S --noconfirm --needed noto-fonts-emoji
        sudo pacman -S --noconfirm --needed curl
        sudo pacman -S --noconfirm --needed wget
        sudo pacman -S --noconfirm --needed git
        sudo pacman -S --noconfirm --needed lynx
        sudo pacman -S --noconfirm --needed w3m
      
    else
        sair
    fi
}

sair() {
    echo -e "\nSaindo...\n"
    exit 0
}

pacotes_basicos
