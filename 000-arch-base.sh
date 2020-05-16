#!/bin/bash

###################################################
#												  #
# ==> Autor: Elder M. Fouraux                     #
# 												  #
# ==> Descrição: instala a base do sistema        #
#												  #
###################################################

tput reset
__Y=$(echo -e "\e[33;1m");__A=$(echo -e "\e[36;1m");__R=$(echo -e "\e[31;1m");__O=$(echo -e "\e[m");

cat <<EOL
		
		
			
			====================================================
			
				        ${__Y}INSTALADOR ARCH LINUX${__O}
					   
			====================================================
			
			==> Autor: leo.arch <leo.arch@bol.com.br>
			==> Adaptação: Elder M. Fouraux <eldermf@bsd.com.br>
			==> Script: arch.sh v1.0
			==> Descrição: Instalador Automático Arch Linux
			
					    ${__Y}INFORMAÇÔES${__O}
					   
			Nesse script será necessário você escolher sua par-
			tição Swap, Root e Home (Swap/Home não obrigatórias)
		
			Utilizaremos o particionador CFDISK
			Código das Partições para quem quiser usar GDISK:
			==> EF02 BIOS
			==> EF00 EFI
			==> 8200 SWAP
			==> 8304 /
			==> 8302 /home
			
			====================================================
			
				     ${__Y}CONTINUAR COM A INSTALAÇÃO?${__O}
					
			   Digite s/S para continuar ou n/N para cancelar
			   DESEJA REALMENTE INICIAR A INSTALAÇÃO ? ${__Y}[S/n]${__O}
			   
			====================================================
EOL

setterm -cursor off

# cores
_n="\e[36;1m";_w="\e[37;1m";_g="\e[32;1m";_am="\e[33;1m";_o="\e[m";_r="\e[31;1m";

echo -ne "\n "
read -n 1 INSTALAR

tput reset

if [[ "$INSTALAR" != @(S|s) ]]; then
	exit $?
fi

echo

lsblk -l | grep disk # comando para listar os discos

echo -en "\n${_g}	Logo acima estão listados os seus discos${_o}\n"
echo -en "\n${_g}	Informe o nome do seu disco${_o} (Ex: ${_r}sda${_o}):${_w} "
read  _hd
_hd="/dev/${_hd}"
export _hd

echo

cfdisk $_hd # entrando no particionador cfdisk

if [ $? -eq 0 ]; then
    echo
else
    echo -e "\n${_r} ATENÇÃO:${_o} Disco ${_am}$_hd${_o} não existe! Execute novamente o script e insira o número corretamente\n"; exit 1
fi

tput reset
setterm -cursor off

echo -e "\n${_n} OK, você definiu as partições, caso deseje cancelar, precione${_w}: Ctrl+c"
echo -e "\n${_n} Use os número das partições nas perguntas abaixo${_w}\n"

echo "==========================================================="
fdisk -l $_hd
echo "==========================================================="

echo -e "\n${_n} CONSULTE ACIMA O NÚMERO DAS SUAS PARTIÇÕES${_o}"

echo -en "\n${_g} Modo de instalação EFI?${_o} (Digite o NÚMERO, ex: ${_r}1${_o} para sda1) ou tecle ${_am}ENTER${_o} caso não tenha:${_w} "
read _efi

if [ -n "$_efi" ]; then
	_efi="/dev/sda${_efi}"
	export _efi
fi

echo -en "\n${_g} Caso tenha partição SWAP${_o} (Digite o NÚMERO, ex: ${_r}2${_o} para sda2) ou tecle ${_am}ENTER${_o} caso não tenha:${_w} "
read _swap

if [ -n "$_swap" ]; then
	_swap="/dev/sda${_swap}"
	export _swap
fi

echo -en "\n${_g} Informe o NÚMERO da partição ROOT${_o} (Digite o NÚMERO, ex: ${_r}3${_o} para sda3):${_w} "
read  _root

if [ "$_root" == "" ]; then
	cat <<STI
	
	${__R}=====================================
	Atenção: Partição ROOT é obrigatória!
	=====================================${__O}

STI
	echo -en "${_am} Execute novamente o script e crie a partição Root.${_o}\n\n"; exit 1;
else
	_root="/dev/sda${_root}"
	export _root
fi

echo -en "\n${_g} Caso tenha partição HOME${_o} (Digite o NÚMERO, ex: ${_r}4${_o} para sda4) ou tecle ${_am}ENTER${_o} caso não tenha:${_w} "
read _home

if [ -n "$_home" ]; then
	_home="/dev/sda${_home}"
	export _home
fi

tput reset
cat <<STI
 ${__A}======================
 Iniciando a Instalação
 ======================${__O}

STI

echo -e " Suas partições definidas foram:\n"

if [ "$_efi" != "" ]; then
	echo -e " ${_g}EFI${_o}  = $_efi"
else
	echo -e " ${_g}EFI${_o} = SEM EFI"
fi

if [ "$_swap" != "" ]; then
	echo -e " ${_g}Swap${_o} = $_swap"
else
	echo -e " ${_g}Swap${_o} = SEM SWAP"
fi

echo -e " ${_g}Root${_o} = $_root"

if [ "$_home" != "" ]; then
	echo -e " ${_g}Home${_o} = $_home\n"
else
	echo -e " ${_g}Home${_o} = SEM HOME\n"
fi
echo "==========================================================="
fdisk -l $_hd
echo "==========================================================="

echo -ne "\n Verifique se as informações estão corretas comparando com os dados acima.\n"
echo -ne "\n Se tudo estiver certo, Digite ${_g}s/S${_o} para continuar ou ${_g}n/N${_o} para cancelar: "
read -n 1 comecar

if [[ "$comecar" != @(S|s) ]]; then
	exit $?
fi

echo -e "\n\n ${_n}Continuando com a instalação ...${_o}\n"

# swap
if [ "$_swap" != "" ]; then
	echo -e "${_g}===> Criando e ligando Swap${_o}"
	mkswap $_swap && swapon $_swap
fi

# root
echo -e "\n${_g}===> Formatando e Montando Root${_o}"
mkfs.ext4 -F $_root && mount $_root /mnt

# home
if [ "$_home" != "" ]; then
	echo -e "\n${_g}===> Formatando, Criando e Montando Home${_o}"
	mkfs.ext4 -F $_home && mkdir /mnt/home && mount $_home /mnt/home	
fi

# efi
if [ "$_efi" != "" ]; then
	echo -e "${_g}Formatando, Criando e Montando EFI${_o}"
	mkfs.fat -F32 $_efi && mkdir /mnt/boot && mount $_efi /mnt/boot
fi

# set mirrorlist br (opcional)
# echo -e "${_g}===> Setando mirrorlist BR${_o}"
# wget "https://raw.githubusercontent.com/leoarch/arch-install/master/mirror-br" -O /etc/pacman.d/mirrorlist 2>/dev/null

# instalando base e base-devel
echo -e "${_g}===> Instalando base/base-devel${_o}"
pacstrap /mnt base base-devel linux linux-firmware nano

# gerando fstab
echo -e "${_g}===> Gerando FSTAB${_o}"
genfstab -U -p /mnt >> /mnt/etc/fstab

# download script mode chroot
#echo -e "${_g}===> Baixando script para ser executado como chroot ...${_o}"
#wget https://raw.githubusercontent.com/leoarch/arch-install/master/chroot.sh && chmod +x chroot.sh && mv chroot.sh /mnt
chmod +x 001-chroot.sh && mv 001-chroot.sh /mnt

# run script
echo -e "${_g}===> Executando script ...${_o}"
arch-chroot /mnt 

# variables user and pass root/user
echo "Digite um nome de usuário:   "
echo
read _user
echo
sleep 0,7

echo "Digite a senha de usuário:   "
echo
read _puser
echo
sleep 0,7

echo "Digite a senha de root:   "
echo
read _proot
echo
sleep 0,7

echo
echo

echo "O nome do usuário é: $_puser"
echo
echo
sleep 0,7

echo "A senha de usuário é: $_puser"
echo
echo
sleep 0,7

echo "A senha de root é: $_proot"
echo
echo
sleep 0,7

# variables user and pass root/user
#_user="arch"
#_proot="123"
#_puser="123"

# cores
_r="\e[31;1m";_w="\e[37;1m";_g="\e[32;1m";_o="\e[m";

# start script

# password
echo -e "${_g}===> Criando senha root${_o}"
passwd << EOF
$_proot
$_proot
EOF
sleep 0.8

echo -e "${_g}===> Criando senha user${_o}"
useradd -m -g users -G wheel,audio,video,daemon,dbus,disk,rfkill,games,power,lp,optical,scanner,storage,input -s /bin/bash $_user
passwd $_user << EOF
$_puser
$_puser
EOF
sleep 0.8

# language, keyboard, hour, hostname, hosts, multilib ...
echo -e "${_g}===> Idioma, Teclado, Hora, Hostname, Hosts, Multilib, Sudoers${_o}"

echo -e "${_g}===> Inserindo pt_BR.UTF-8 em locale.gen${_o}"
echo "pt_BR.UTF-8 UTF-8" >> /etc/locale.gen

echo -e "${_g}===> Inserindo pt_BR.UTF-8 em /etc/locale.conf${_o}"
echo LANG=pt_BR.UTF-8 > /etc/locale.conf

echo -e "${_g}===> Exportando LANG=pt_BR.UTF-8${_o}"
export LANG=pt_BR.UTF-8

echo -e "${_g}===> Inserindo KEYMAP=br-abnt2 em /etc/vconsole.conf${_o}"
echo "KEYMAP=br-abnt2" > /etc/vconsole.conf

echo -e "${_g}===> Configurando Horário America/Sao_Paulo${_o}"
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && hwclock --systohc --utc

echo -e "${_g}===> Inserindo hostname arch em /etc/hostname${_o}"
echo "jarwis" > /etc/hostname

echo -e "${_g}===> Inserindo dados em /etc/hosts${_o}"
echo -e "127.0.0.1\tlocalhost.localdomain\tlocalhost\n::1\tlocalhost.localdomain\tlocalhost\n127.0.1.1\tjarwis.localdomain\tjarwis\n" > /etc/hosts

echo -e "${_g}===> Habilitando Multilib${_o}"
sed -i  '/multilib\]/,+1 s/^#//' /etc/pacman.conf

echo -e "\nwheel ALL=(ALL) ALL\n" >> /etc/sudoers

echo -e "${_g}===> Gerando Locale${_o}"
locale-gen

# Caso tenha outro SO instalado (ntfs-3g é bom para reconhecer o windows)
pacman -S os-prober ntfs-3g --noconfirm

# grub configuration
if [ "$_efi" != "" ]; then
	echo -e "${_g}===> bootctl UEFI mode${_o}"
	bootctl --path=/boot install
	echo -e "default arch\ntimeout 5\n" > /boot/loader/loader.conf
	echo -e "title Arch Linux\nlinux /vmlinuz-linux\ninitrd /initramfs-linux.img\noptions root=${_root} rw\n" > /boot/loader/entries/arch.conf
else
	echo -e "${_g}===> Instalando e Configurando o GRUB${_o}"
	pacman -S grub --noconfirm
	grub-install --target=i386-pc --recheck /dev/sda
	cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
	grub-mkconfig -o /boot/grub/grub.cfg
fi


echo -e "${_g}===> mkinitcpio${_o}"
mkinitcpio -p linux

echo -e "${_g}===> Sincronizando a base de dados de pacotes${_o}"
pacman -Syu

# no meu caso, o dhclient funciona pro meu roteador e dhcpcd não (altere a vontade)
#echo -e "${_g}===> Instalando dhclient${_o}"
#pacman -S dhclient dhcpcd --noconfirm

echo -e "${_g}===> Instalando networkmanager${_o}"
pacman -S networkmanager network-manager-applet net-tools
systemctl enable NetworkManager.service

echo -e "${_g}===> Fim do script chroot.sh${_o}"

# umount
echo -e "${_g}===> Desmontando partições${_o}"
umount -R /mnt

cat <<EOI

 ${__A}=============
      FIM!    
 =============${__O}
EOI

exit 0
