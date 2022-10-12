#!/bin/bash

#Mendeklarasikan array secara indirect
distroLinuxDesktop[0]=BlankOn
distroLinuxDesktop[1]=Ubuntu
distroLinuxDesktop[2]=Debian
distroLinuxDesktop[3]=ArchLinux
distroLinuxDesktop[4]=LinuxMint

distroLinuxServer[0]=UbuntuServer
distroLinuxServer[1]=CentOS
distroLinuxServer[2]=FedoraServer

#Menampilkan & memanggil elemen dalam array
echo ${distroLinuxDesktop[*]}
echo ${distroLinuxServer[*]}
