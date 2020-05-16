#!/bin/bash

###################################################
#												  #
# ==> Autor: Elder M. Fouraux                     #
#                                                 #
# ==> Descrição: executa arch-chroot              #
#												  #
###################################################

{
echo -e "Vamos instalar os pacotes básicos xorg. Podemos prosseguir (s/N)?"
read answer
    if [[ $answer = [sSyY] ]]; then
        echo -e "\nInstalando...\n"

        sudo pacman -S --noconfirm --needed xorg
        sudo pacman -S --noconfirm --needed xorg-server
        sudo pacman -S --noconfirm --needed xorg-xinit
        sudo pacman -S --noconfirm --needed xorg-xset
        sudo pacman -S --noconfirm --needed xorg-xset root
        sudo pacman -S --noconfirm --needed xorg-xrandr
        sudo pacman -S --noconfirm --needed xorg-xkill
        sudo pacman -S --noconfirm --needed xorg-apps
        sudo pacman -S --noconfirm --needed mesa
        sudo pacman -S --noconfirm --needed xf86-video-fbde
        sudo pacman -S --noconfirm --needed xf86-video-intel
        sudo pacman -S --noconfirm --needed xf86-video-nouveau
        sudo pacman -S --noconfirm --needed virtualbox-guest-utils
        sudo pacman -S --noconfirm --needed virtualbox-guest-modules-arch
        sudo pacman -S --noconfirm --needed gvfs-mtp
        sudo pacman -S --noconfirm --needed alsa-utils
        sudo pacman -S --noconfirm --needed alsa-lib
        sudo pacman -S --noconfirm --needed pulseaudio
        sudo pacman -S --noconfirm --needed pulseaudio-alsa
        sudo pacman -S --noconfirm --needed pavucontrol
        sudo pacman -S --noconfirm --needed paprefs
        sudo pacman -S --noconfirm --needed volumeicon
        sudo pacman -S --noconfirm --needed terminus-font
        sudo pacman -S --noconfirm --needed ttf-dejavu
        sudo pacman -S --noconfirm --needed ttf-fira-code
        sudo pacman -S --noconfirm --needed noto-fonts
        sudo pacman -S --noconfirm --needed noto-fonts-emoji
        sudo pacman -S --noconfirm --needed ttf-ubuntu-font-family
        sudo pacman -S --noconfirm --needed ttf-droid
        sudo pacman -S --noconfirm --needed arc-gtk-theme
        sudo pacman -S --noconfirm --needed curl
        sudo pacman -S --noconfirm --needed wget
        sudo pacman -S --noconfirm --needed git
        sudo pacman -S --noconfirm --needed lynx
        #sudo pacman -S --noconfirm --needed w3m
        cd /home/$USER
        sudo pacman -S --noconfirm --needed xdg-user-dirs
        xdg-user-dirs-update

    else
        sair
    fi
}

sair() {
    echo -e "\nSaindo...\n"
    exit 0
}