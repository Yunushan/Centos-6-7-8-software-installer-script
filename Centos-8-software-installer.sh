#!/bin/bash

# Select Which Softwares to be Installed

choice () {
    local choice=$1
    if [[ ${opts[choice]} ]] # toggle
    then
        opts[choice]=
    else
        opts[choice]=+
    fi
}
PS3='
Please enter your choice(s): '
while :
do
clear
options=("PHP7.4 ${opts[1]}" "Nginx ${opts[2]}" "FFMPEG ${opts[3]}" "GCC8.3 - 9.2 From Source ${opts[4]}" "G++ ${opts[5]}" "Cmake ${opts[6]}" "VLC ${opts[7]}"
"Apache2 ${opts[8]}" "Monitoring Tools ${opts[9]}" "Transmission-cli ${opts[10]}" "Nmap ${opts[11]}" "Irssi (IRC) ${opts[12]}" "Timeshift ${opts[13]}" 
"Jenkins ${opts[14]}" "Docker (Temporarily Inactive) ${opts[15]}" "Weechat 2.6 (IRC) ${opts[16]}" "Quassel (IRC) ${opts[17]}" "Neofetch ${opts[18]}" "GNU Emacs ${opts[19]}" 
"Kubectl ${opts[20]}" "Magic Wormhole ${opts[21]}" "Neovim ${opts[22]}" "OpenJDK 8 JDK ${opts[23]}" "OpenJDK 11 JDK ${opts[24]}" "DVBlast3.4 ${opts[25]}" 
"Deluge ${opts[26]}" "Done ${opts[29]}")
    select opt in "${options[@]}"
    do
        case $opt in
            "PHP7.4 ${opts[1]}")
                choice 1
                break
                ;;
            "Nginx ${opts[2]}")
                choice 2
                break
                ;;
            "FFMPEG ${opts[3]}")
                choice 3
                break
                ;;
            "GCC8.3 - 9.2 From Source ${opts[4]}")
                choice 4
                break
                ;;
            "G++ ${opts[5]}")
                choice 5
                break
                ;;
            "Cmake ${opts[6]}")
                choice 6
                break
                ;;
            "VLC ${opts[7]}")
                choice 7
                break
                ;;
            "Apache2 ${opts[8]}")
                choice 8
                break
                ;;
            "Monitoring Tools ${opts[9]}")
                choice 9
                break
                ;;
            "Transmission-cli ${opts[10]}")
                choice 10
                break
                ;;
            "Nmap ${opts[11]}")
                choice 11
                break
                ;;
            "Irssi (IRC) ${opts[12]}")
                choice 12
                break
                ;;
            "Timeshift ${opts[13]}")
                choice 13
                break
                ;;
            "Jenkins ${opts[14]}")
                choice 14
                break
                ;;
            "Docker (Temporarily Inactive) ${opts[15]}")
                choice 15
                break
                ;;
            "Weechat 2.6 (IRC) ${opts[16]}")
                choice 16
                break
                ;;
            "Quassel (IRC) ${opts[17]}")
                choice 17
                break
                ;;
            "Neofetch ${opts[18]}")
                choice 18
                break
                ;;
            "GNU Emacs ${opts[19]}")
                choice 19
                break
                ;;
            "Kubectl ${opts[20]}")
                choice 20
                break
                ;;
            "Magic Wormhole ${opts[21]}")
                choice 21
                break
                ;;
            "Neovim ${opts[22]}")
                choice 22
                break
                ;;
            "OpenJDK 8 JDK ${opts[23]}")
                choice 23
                break
                ;;
            "OpenJDK 11 JDK ${opts[24]}")
                choice 24
                break
                ;;
            "DVBlast3.4 ${opts[25]}")
                choice 25
                break
                ;;
            "Deluge ${opts[26]}")
                choice 26
                break
                ;;
            "Done ${opts[27]}")
                break 2
                ;;
            *) printf '%s\n' 'Please Choose Between 1-27';;
        esac
    done
done

printf '%s\n\n' 'Options chosen:'
for opt in "${!opts[@]}"
do
    if [[ ${opts[opt]} ]]
    then
        printf '%s\n' "Option $opt"
        fi
done

if [ "${opts[opt]}" = "" ];then
exit
fi



# Loading Bar

printf "Installation starting"
value=0
while [ $value -lt 600 ]
do
value=$((value+20))
printf "."
sleep 0.05
done
printf "\n"


#Necessary Packages
sudo yum -y update
sudo yum -y --enablerepo=PowerTools install lynx
sudo yum -y install epel-release
sudo yum -y install wget curl mlocate nano snapd git
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap
sudo echo 'export PATH="$PATH:/snap/bin/"' >> /etc/profile
source /etc/profile
printf "\n"

# Epel and Remi Repositories Folder
if [ -d "/root/Downloads/epel-and-remi-repositories/" ];then
:
else
sudo mkdir -pv /root/Downloads/epel-and-remi-repositories/
fi
# Downloaded tmp files
if [ -d "/root/Downloads/TempDL/" ];then
:
else
sudo mkdir -pv /root/Downloads/TempDL/
fi

# INSTALLATION BY SELECTION

for opt in "${!opts[@]}"
do
    if [[ ${opts[opt]} ]]
    then
        case $opt in 

1)
# 1) PHP 7.2 - 7.4
sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
sudo yum -y install https://rpms.remirepo.net/enterprise/remi-release-8.rpm
sudo yum -y install yum-utils 
printf "\nPlease Choose Your Desired PHP Version\n\n1-)PHP7.2\n2-)PHP7.3\n3-)PHP7.4\n"
read phpversion
if [ "$phpversion" = "1" ];then
    sudo yum -y module install php:remi-7.2
elif [ "$phpversion" = "2" ];then
    sudo yum -y module install php:remi-7.3
elif [ "$phpversion" = "3" ];then
    sudo yum -y module install php:remi-7.4
    else
    echo "Out of option(s) please choose between 1-3"
    :
fi
printf "\nPHP 7 installation Has Finished\n\n"
;;

2)
#NGINX 
sudo yum install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
sudo firewall-cmd --permanent --zone=public --add-service=http 
sudo firewall-cmd --permanent --zone=public --add-service=https
sudo firewall-cmd --reload

printf "\nNginx installation Has Finished\n\n"
;;

3)
#FFMPEG
printf "\nPlease Choose Your Desired FFmpeg Version\n\n1-)FFmpeg Stable\n2-)FFmpeg Latest (Edge)\n"
read ffmpegversion
if [ "$ffmpegversion" = "1" ];then
    sudo snap install ffmpeg
    printf "\nFFmpeg Stable installation Has Finished\n\n"
elif [ "$ffmpegversion" = "2" ];then
    sudo snap install ffmpeg --edge
    printf "\nFFmpeg Latest (Edge) installation Has Finished\n\n"
else
    echo "Out of option(s) please choose between 1-2"
    :
fi
;;

4)
#GCC8.3 - 9.2 From Source
printf "\nPlease Choose Your Desired GCC Version\n\n1-)GCC 8.3\n2-)GCC 9.2\n"
read gccversion
if [ "$gccversion" = "1" ];then
    sudo yum install gcc -y
    printf "\nGCC 8.3 installation Has Finished\n\n"
elif [ "$gccversion" = "2" ];then
    sudo yum install gcc gcc-c++ -y
    sudo wget -O /root/Downloads/TempDL/gcc-9.2.0.tar.gz https://ftp.gnu.org/gnu/gcc/gcc-9.2.0/gcc-9.2.0.tar.gz
    sudo mkdir -pv /root/Downloads/TempDL/gcc-9.2.0
    sudo tar xvf /root/Downloads/TempDL/gcc-9.2.0.tar.gz -C /root/Downloads/TempDL/gcc-9.2.0 --strip-components 1
    cd /root/Downloads/TempDL/gcc-8.2.0
    contrib/download_prerequisites
    sudo mkdir -pv gcc-9.2.0-build
    cd gcc-9.2.0-build
    ../gcc-9.2.0/configure --enable-languages=c,c++ --disable-multilib
    make -j8
    make install
    export PATH=/usr/local/bin:$PATH
    export LD_LIBRARY_PATH=/usr/local/lib64:$LD_LIBRARY_PATH
    printf "\nGCC 9.2 installation Has Finished\n\n"
fi
;;

5)
#G++
sudo yum install gcc-c++ -y
printf "\nG++ installation Has Finished\n\n"
;;

6)
#Cmake
printf "\nPlease Choose Your Desired Installation Version\n\n1-)Cmake (From Official Repository) \n2-)Cmake (snap)(Newer version)\n"
read cmakeversion
if [ "$cmakeversion" = "1" ];then
    sudo yum install cmake -y
    printf "\nCmake installation Has Finished\n\n"
elif [ "$cmakeversion" = "2" ];then
    sudo snap install cmake --classic
    printf "\nCmake installation Has Finished\n\n"
fi
;;

7)
#VLC
sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
sudo yum -y install https://download1.rpmfusion.org/free/el/rpmfusion-free-release-8.noarch.rpm
printf "\nPlease Choose Your Desired VLC Version\n\n1-)VLC\n2-)VLC Core(Terminal Only)\n"
read vlcversion
if [ "$vlcversion" = "1" ];then
    sudo yum -y install vlc python-vlc
    sudo sed -i 's/geteuid/getppid/' /usr/bin/vlc
    printf "\nVLC installation Has Finished\n\n"
elif [ "$vlcversion" = "2" ];then
    sudo yum -y install vlc-core
    sudo sed -i 's/geteuid/getppid/' /usr/bin/vlc
    printf "\nVLC Core installation Has Finished\n\n"
fi
;;

8)
#Apache2
sudo yum -y install httpd
sudo systemctl start httpd
sudo systemctl enable httpd
sudo firewall-cmd --zone=public --permanent --add-service=http
sudo firewall-cmd --zone=public --permanent --add-service=https
sudo firewall-cmd --reload
printf "\nApache2 installation Has Finished\n\n"
;;

9)
#Monitoring Tools
sudo yum -y install htop iftop atop powertop iotop apachetop
printf "\nMonitoring Tools installation Has Finished\n\n"
;;

10)
#Transmission
sudo wget -O /root/Downloads/epel-and-remi-repositories/geekery-release-8-2.noarch.rpm http://geekery.altervista.org/geekery/el8/x86_64/geekery-release-8-2.noarch.rpm
sudo yum -y install /root/Downloads/epel-and-remi-repositories/geekery-release-8-2.noarch.rpm
sudo yum -y install transmission
sudo systemctl start transmission-daemon.service
printf "\nTransmission installation Has Finished\n\n"
;;

11)
#Nmap
sudo yum -y install
printf "\nNmap official repository installation Has Finished\n\n"
;;

12)
#Irssi (IRC)
printf "\nPlease Choose Your Desired Irssi Version\n\n1-)Irssi (From Official Repository) \n2-)Irssi (snap)(Newer version)\n"
read irssiversion
if [ "$irssiversion" = "1" ];then
    sudo yum -y install irssi
    printf "\nIrssi (From Official Repository) installation Has Finished\n\n"
elif [ "$irssiversion" = "2" ];then
    sudo snap install irssi
    printf "\nIrssi (snap)(Newer version) installation Has Finished\n\n"
fi
;;

13)
#Timeshift
timeshiftlink=`lynx -dump https://github.com/teejee2008/timeshift/releases/ | awk '{print $2}' | grep amd64.run | head -n 1`
sudo wget -O /root/Downloads/TempDL/timeshift-latest-amd64.run $timeshiftlink
sudo chmod +x /root/Downloads/TempDL/timeshift-latest-amd64.run
echo y | bash /root/Downloads/TempDL/timeshift-latest-amd64.run
printf "\nInstall Timeshift from .run file (Newer version) installation Has Finished\n\n"
;;

14)
#Jenkins
sudo yum -y install java-1.8.0-openjdk
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum install jenkins -y
sudo systemctl start jenkins.service
sudo systemctl enable jenkins.service
sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp
sudo firewall-cmd --reload
printf "\nJenkins installation Has Finished\n\n"
;;

15)
#Docker
#sudo yum -y install yum-utils device-mapper-persistent-data lvm2
#sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
#sudo yum -y install docker-ce docker-ce-cli containerd.io --nobest
#sudo systemctl start docker
#sudo systemctl enable docker
#printf "\nDocker installation Has Finished\n\n"
;;

16)
#Weechat 2.6 (IRC)
sudo yum -y install cmake make gcc libgcrypt-devel zlib-devel gnutls-devel libcurl-devel perl ncurses-devel ruby-devel tcl-devel
sudo wget -O /root/Downloads/TempDL/weechat-2.6.tar.gz https://weechat.org/files/src/weechat-2.6.tar.gz
cd /root/Downloads/
sudo mkdir -pv /root/Downloads/TempDL/weechat-2.6/
sudo tar xvf /root/Downloads/TempDL/weechat-2.6.tar.gz -C /root/Downloads/TempDL/weechat-stable/ --strip-components 1
cd /root/Downloads/TempDL/weechat-2.6/
sudo mkdir -pv build
cd build
sudo cmake ..
sudo make -j8
sudo make install
printf "\nWeechat 2.6 (IRC) installation Has Finished\n\n"
;;

17)
#Quassel (IRC)
sudo snap install quassel-kalikiana
printf "\nQuassel (IRC) installation Has Finished\n\n"
;;

18)
#Neofetch
sudo yum -y install dnf-plugins-core
curl -o /etc/yum.repos.d/konimex-neofetch-epel-7.repo https://copr.fedorainfracloud.org/coprs/konimex/neofetch/repo/epel-7/konimex-neofetch-epel-7.repo
sudo yum -y install neofetch
printf "\nNeofetch installation Has Finished\n\n"
;;

19)
#Emacs
sudo yum -y install emacs
printf "\nEmacs installation Has Finished\n\n"
;;

20)
#Kubectl
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
sudo yum install kubelet kubeadm kubectl -y
sudo systemctl start kubelet 
sudo systemctl enable kubelet
printf "\n"
kubectl version
printf "\nKubectl installation Has Finished\n\n"
;;

21)
#Magic Wormhole
sudo yum -y install python3-pip python3-devel
sudo pip3 install magic-wormhole
printf "\nMagic Wormhole installation Has Finished \n\n"
;;

22)
#Neovim
printf "\nPlease Choose Your Desired Neovim Version\n\n1-)Neovim Kalikiana (Snap) \n2-)Install Neovim From Source (Newer version)\n"
read neovimversion
if [ "$neovimversion" = "1" ];then
    sudo snap install neovim-kalikiana
    printf "\nNeovim Kalikiana (Snap)\n\n"
elif [ "$neovimversion" = "2" ];then
    sudo yum -y install gcc-c++ automake libtool gcc cmake make
    neovimstable=`lynx -dump https://github.com/neovim/neovim/releases/ | awk {'print $2'} | grep stable | grep .tar.gz | grep -v macos | grep -v linux | head -n 1`
    sudo wget -O /root/Downloads/TempDL/neovim-stable.tar.gz $neovimstable
    sudo mkdir -pv /root/Downloads/TempDL/neovim-stable/
    sudo tar xvf /root/Downloads/TempDL/neovim-stable.tar.gz -C /root/Downloads/TempDL/neovim-stable/ --strip-components 1
    cd /root/Downloads/TempDL/neovim-stable/
    mkdir -p $HOME/opt
    make CMAKE_INSTALL_PREFIX=$HOME/opt install
    make install
    printf "\n Neovim From Source (Newer version) installation Has Finished\n\n"
fi
;;

23)
#OpenJDK 8 JDK
sudo yum -y install java-1.8.0-openjdk-devel
printf "\nOpenJDK 8 JDK installation Has Finished \n\n"
;;

24)
#OpenJDK 11 JDK

sudo yum install java-11-openjdk-devel -y
printf "\nOpenJDK 11 JDK installation Has Finished \n\n"
;;

25)
#DVBlast 3.4
sudo yum install gcc make libev-devel -y
sudo git clone https://github.com/gfto/bitstream.git /root/Downloads/TempDL/bitstream
cd /root/Downloads/TempDL/bitstream/
make install
sudo wget -O /root/Downloads/TempDL/dvblast3.4.tar.gz https://github.com/videolan/dvblast/archive/3.4.tar.gz
sudo mkdir -pv /root/Downloads/TempDL/dvblast3.4
sudo tar xvf /root/Downloads/TempDL/dvblast3.4.tar.gz -C /root/Downloads/TempDL/dvblast3.4/ --strip-components 1
cd /root/Downloads/TempDL/dvblast3.4/
make
make install
;;

26)
#DELUGE
sudo wget -O /root/Downloads/TempDL/nux-dextop-release-0-5.el7.nux.noarch.rpm http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
sudo rpm -ivh /root/Downloads/TempDL/nux-dextop-release-0-5.el7.nux.noarch.rpm
sudo yum install deluge-console -y
;;

        esac
    fi
done