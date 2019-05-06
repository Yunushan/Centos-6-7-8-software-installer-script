#!/bin/bash

# Variables
cpuarch=`uname -m`
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
options=("PHP7.1 ${opts[1]}" "Nginx ${opts[2]}" "FFMPEG 3.4 ${opts[3]}" "GCC4.8 - 8.2 From Source ${opts[4]}" "G++ ${opts[5]}" "Cmake ${opts[6]}" "VLC ${opts[7]}"
"Apache2 ${opts[8]}" "Monitoring Tools ${opts[9]}" "Transmission-cli ${opts[10]}" "Nmap ${opts[11]}" "Irssi (IRC) ${opts[12]}" "Timeshift ${opts[13]}" 
"Jenkins ${opts[14]}" "Docker ${opts[15]}" "Weechat (IRC) ${opts[16]}" "Quassel (IRC) ${opts[17]}" "Neofetch ${opts[18]}" "GNU Emacs ${opts[19]}" 
"Kubectl ${opts[20]}" "Magic Wormhole ${opts[21]}" "Neovim ${opts[22]}" "OpenJDK 8 JDK ${opts[23]}" "OpenJDK 11 JDK ${opts[24]}" "Oracle Java 8 JDK ${opts[25]}"
"Oracle Java 11 JDK ${opts[26]}" "Done ${opts[27]}")
    select opt in "${options[@]}"
    do
        case $opt in
            "PHP7.1 ${opts[1]}")
                choice 1
                break
                ;;
            "Nginx ${opts[2]}")
                choice 2
                break
                ;;
            "FFMPEG 3.4 ${opts[3]}")
                choice 3
                break
                ;;
            "GCC4.8 - 8.2 From Source ${opts[4]}")
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
            "Docker ${opts[15]}")
                choice 15
                break
                ;;
            "Weechat (IRC) ${opts[16]}")
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
            "Oracle Java 8 JDK ${opts[25]}")
                choice 25
                break
                ;;
            "Oracle Java 11 JDK ${opts[26]}")
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
sudo yum update -y
sudo yum install wget curl mlocate nano lynx -y
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
# 1) PHP 7.0 - 7.3
1)
sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
sudo yum install yum-utils
printf "\nPlease Choose Your Desired PHP Version\n\n1-)PHP7.0\n2-)PHP7.1\n3-)PHP7.2\n4-)PHP7.3\n"
read phpversion
if [ "$phpversion" = "1" ];then
sudo yum-config-manager --enable remi-php70
elif [ "$phpversion" = "2" ];then
sudo yum-config-manager --enable remi-php71
elif [ "$phpversion" = "3" ];then
sudo yum-config-manager --enable remi-php72
elif [ "$phpversion" = "4" ];then
sudo yum-config-manager --enable remi-php73
else
echo "Out of option Please Choose between 1-4"
:
fi
sudo yum install php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo
printf "\nPHP 7 installation Has Finished\n\n"
;;

# 2- Nginx (PPA)
2)

#NGINX 

sudo yum install epel-release -y
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

sudo yum install epel-release -y
sudo rpm -v --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro
sudo rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
sudo yum install ffmpeg ffmpeg-devel -y
printf "\nFFmpeg installation Has Finished\n\n"
;;

4)

#GCC4.8 - 8.3 From Source

printf "\nPlease Choose Your Desired GCC Version\n\n1-)GCC 8.2\n2-)GCC 4.8\n"
read gccversion
if [ "$gccversion" = "1" ];then
sudo wget -O /root/Downloads/TempDL/gcc-8.2.0.tar.gz https://ftp.gnu.org/gnu/gcc/gcc-8.2.0/gcc-8.2.0.tar.gz
sudo mkdir -pv /root/Downloads/TempDL/gcc-8.2.0
sudo tar xzvf /root/Downloads/TempDL/gcc-8.2.0.tar.gz -C /root/Downloads/TempDL/gcc-8.2.0 --strip-components 1
cd /root/Downloads/TempDL/gcc-8.2.0
./contrib/download_prerequisites
sudo mkdir -pv gcc-8.2.0-build
cd gcc-8.2.0-build
../gcc-8.2.0/configure --enable-languages=c,c++ --disable-multilib
make -j 4
make install
printf "\nGCC 8.2 installation Has Finished\n\n"

elif [ "$gccversion" = "2" ];then
sudo yum install gcc -y

printf "\nGCC 4.8 installation Has Finished\n\n"
fi
;;

5)

#G++

sudo yum install gcc-c++ -y

;;

6)

#Cmake

sudo yum install cmake -y

;;

7)

#VLC
sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -y
sudo yum install https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm -y
sudo yum install vlc-core -y
sudo sed -i 's/geteuid/getppid/' /usr/bin/vlc
;;

8)

#Apache2
sudo yum install httpd -y

;;

9)

#Monitoring Tools
sudo yum install htop iftop atop glances monit powertop iotop apachetop -y

;;

10)

#Transmission-cli

sudo yum install transmission-cli transmission-common transmission-daemon -y
sudo systemctl enable transmission-daemon
sudo systemctl start transmission-daemon
sudo firewall-cmd --permanent --zone=public --add-port=9091/tcp
sudo firewall-cmd --reload

;;

11)

#Nmap

if [ "$cpuarch" = "x86_64" ];then

nmap64=`lynx -dump https://nmap.org/dist/ | awk '/nmap-7.*\.x86_64.rpm$/{url=$2}END{print url}'`
sudo rpm -Uvh $nmap64

elif [ "$cpuarch" = "x86" ] || [ "$cpuarch" = "i386" ] || [ "$cpuarch" = "i486" ] || [ "$cpuarch" = "i586" ] || [ "$cpuarch" = "i686" ];then
nmap32=`lynx -dump https://nmap.org/dist/ | awk '/nmap-7.*\.i686.rpm$/{url=$2}END{print url}'`
sudo rpm -Uvh $nmap32
fi
;;

12)

#Irssi (IRC)

sudo yum install irssi -y
;;

13)

#Timeshift

sudo yum install timeshift -y
;;

14)

#Jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum install jenkins -y
sudo systemctl start jenkins.service
sudo systemctl enable jenkins.service
sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp
sudo firewall-cmd --reload

;;

15)

#Docker
sudo yum install yum-utils device-mapper-persistent-data lvm2 -y
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io -y
sudo systemctl start docker
sudo systemctl enable docker
;;

16)

#Weechat (IRC)
sudo yum install weechat -y
;;

17)

#Quassel (IRC)
sudo yum install quassel -y
;;

18)

#Neofetch
sudo yum install epel-release dnf -y
curl -o /etc/yum.repos.d/konimex-neofetch-epel-7.repo https://copr.fedorainfracloud.org/coprs/konimex/neofetch/repo/epel-7/konimex-neofetch-epel-7.repo
sudo dnf install neofetch -y

;;

19)

#Neofetch
sudo yum install epel-release -y
sudo yum install emacs -y
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
;;

21)

#Magic Wormhole

sudo yum install python-pip python-devel -y
sudo pip install magic-wormhole
;;

22)

#Neovim

sudo yum install neovim -y
;;

23)

#OpenJDK 8 JDK

sudo yum install java-1.8.0-openjdk-devel -y
;;

24)

#OpenJDK 11 JDK

sudo yum install java-11-openjdk-devel
;;

25)

#Oracle Java 8 JDK

sudo yum install java-1.8.0-openjdk
;;

26)

#Oracle Java 11 JDK
sudo wget -O /root/Downloads/TempDL/jdk-11.0.2_linux-x64_bin.rpm --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie"   "http://download.oracle.com/otn-pub/java/jdk/11.0.2+9/f51449fcd52f4d52b93a989c5c56ed3c/jdk-11.0.2_linux-x64_bin.rpm"
sudo rpm -Uvh /root/Downloads/TempDL/jdk-11.0.2_linux-x64_bin.rpm
;;

        esac
    fi
done