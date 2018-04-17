#!/bin/bash
host="$(hostname)"

echo -ne 'Cargando Script para  Recoleccion de Informacion del Servidor' 
echo ' ' ${host}
sleep 1
echo  '*EJECUTANDO COMANDOS*'
sleep 1

sos_dir="/tmp/${host}_ServerStatus.log"
mkdir $sos_dir
cd $sos_dir
date > date
df -h > df
fdisk -l > fdisk  
top -b -n1 > top
free > free  
iptables -L > iptables
SUSEfirewall2 > firewall
cat /etc/passwd > passwd
lsblk -f > lsblk
blkid > blkid
pvdisplay > pvdisplay
vgdisplay > vgdisplay
lvdisplay > lvdisplay

sleep 2
vmstat > vmstat
#hostname --fqdn > hostname  
ifconfig > ifconfig  
lsmod > lsmod  
lspci > lspci  
cat /proc/mounts > mount  
netstat -tlpn > netstat  
ps auxww > ps  
rpm -qa > rpm-qa  
rpm --obsoletes > obsoletes

ulimit -a > ulimit  
uname -a > uname  
uptime > uptime  
cat /proc/meminfo > meminfo  
cat /proc/cpuinfo > cpuinfo  

#Actualizaciones de Seguridad
zypper list-updates -a > update 2>&1
zypper patch-check > updateInfoSummary 2>&1
zypper patches > listSecurityUpdate 2>&1
zypper ve > parchesdependencias 2>&1
zypper pchk > pchk 2>&1
zypper patches > patches 2>&1
zypper repos > repositorios 2>&1
chage -l root > expirarcontrasenas

sleep 1

mkdir etc  
cd etc  
cp /etc/fstab .
cp /etc/security/limits.conf . 
cp /etc/hosts.allow .
cp /etc/hosts.deny .
cp /etc/sysctl.conf . 
cp /etc/crontab .
mkdir sysconfig/network-scripts -p  
cd sysconfig  
cp /etc/sysconfig/* . -R  
cd $sos_dir
mkdir var/log -p  
cp /var/log/* var/log -R  
cd /tmp  

echo -ne '################################(100%)\r'
echo " "
echo "Ejecucion de comandos exitosa"
sleep 1
echo -ne 'Guardando Informacion del servidor'
echo ' ' ${host}
tar -cjf ${host}_ServerStatus.tar.bz2 $sos_dir 2&> /dev/null
sleep 1
