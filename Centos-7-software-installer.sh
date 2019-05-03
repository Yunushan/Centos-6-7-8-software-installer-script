#!/bin/bash
sudo yum update -y

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
options=("PHP7.1 ${opts[1]}" "Nginx ${opts[2]}" "FFMPEG 3.4 ${opts[3]}" "GCC4.8 - 8.2 From Source ${opts[4]}" "G++ ${opts[5]}" "Cmake ${opts[6]}" "VLC ${opts[7]}" "Done ${opts[8]}")
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
            "Done ${opts[8]}")
                break 2
                ;;
            *) printf '%s\n' 'Please Choose Between 1-8';;
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



sudo yum install wget curl mlocate nano -y
printf "\n"

# Epel and Remi Repositories Folder
if [ -d "/root/Downloads/epel-and-remi-repositories/" ];then
:
else
sudo mkdir -p /root/Downloads/epel-and-remi-repositories/
fi
# Downloaded tmp files
if [ -d "/root/Downloads/TempDL/" ];then
:
else
sudo mkdir -p /root/Downloads/TempDL/
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
        esac
    fi
done