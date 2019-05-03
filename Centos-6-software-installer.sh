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
options=("PHP7.1 ${opts[1]}" "Nginx ${opts[2]}" "FFMPEG ${opts[3]}" "GCC ${opts[4]}" "G++ ${opts[5]}" "Cmake ${opts[6]}" "VLC ${opts[7]}" "Done ${opts[8]}")
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
            "FFMPEG ${opts[3]}")
                choice 3
                break
                ;;
            "GCC ${opts[4]}")
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
# 1) PHP 7.1
1)
sudo yum remove webtatic-release -y
sudo yum install https://centos6.iuscommunity.org/ius-release.rpm -y
sudo yum install php71u-cli php71u-common php71u-fpm php71u-gd php71u-mbstring php71u-mysqlnd php71u-opcache php71u-pdo php71u-pear php71u-pecl-igbinary php71u-pecl-imagick php71u-pecl-memcached php71u-process php71u-xml -y
printf "\nPhp 7.1 installation Has Finished\n\n"
;;

# 2- Nginx (PPA)
2)

#NGINX 

sudo wget -O /root/Downloads/TempDL/nginx-release-centos-6-0.el6.ngx.noarch.rpm http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm
sudo rpm -ivh /root/Downloads/TempDL/nginx-release-centos-6-0.el6.ngx.noarch.rpm
sudo yum install nginx -y 
sudo chkconfig nginx on
sudo service nginx start
sudo echo "-A INPUT -m state --state NEW -p tcp --dport 80 -j ACCEPT" >> /etc/sysconfig/iptables
sudo service iptables restart
printf "\nNginx installation Has Finished\n\n"
;;

3)

#FFMPEG 

sudo yum install epel-release -y
sudo rpm --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro
sudo rpm -Uvh http://li.nux.ro/download/nux/dextop/el6/x86_64/nux-dextop-release-0-2.el6.nux.noarch.rpm
sudo yum install ffmpeg ffmpeg-devel -y
printf "\nFFmpeg installation Has Finished\n\n"
;;

4)

#GCC

sudo yum install gcc -y

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
sudo wget -O /root/Downloads/TempDL/rpmfusion-free-release-6.noarch.rpm https://download1.rpmfusion.org/free/el/rpmfusion-free-release-6.noarch.rpm
sudo yum install https://download1.rpmfusion.org/free/el/rpmfusion-free-release-6.noarch.rpm -y
sudo yum install vlc -y
sudo sed -i 's/geteuid/getppid/' /usr/bin/vlc
;;
        esac
    fi
done