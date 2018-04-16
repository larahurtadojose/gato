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
iostat  > iostat

sleep 2
vmstat > vmstat
hostname --fqdn > hostname  
ifconfig > ifconfig  
lsmod > lsmod  
lspci > lspci  
cat /proc/mounts > mount  
netstat -tlpn > netstat  
ps auxww > ps  
rpm -qa > rpm-qa  

ulimit -a > ulimit  
uname -a > uname  
uptime > uptime  
cat /proc/meminfo > meminfo  
cat /proc/cpuinfo > cpuinfo  

#Actualizaciones de Seguridad
yum check-update > update 2>&1
yum updateinfo summary > updateInfoSummary 2>&1
yum updateinfo list security > listSecurityUpdate 2>&1
yum --security check-update > securityUpdate 2>&1
yum --security --sec-severity=Critical check-update > securityUpdateCritical 2>&1
yum --security --sec-severity=Important check-update > securityUpdateImportant 2>&1
yum --security --sec-severity=Moderate check-update > securityUpdateModerate 2>&1
yum --security --sec-severity=Low check-update > securityUpdateLow 2>&1

sleep 1

mkdir etc  
cd etc  
cp /etc/fstab .
cp /etc/security/limits.conf .  
cp /etc/redhat-release .  
cp /etc/sysctl.conf .  
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