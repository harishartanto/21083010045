#!/bin/bash

#Mendeklarasikan array secara compound assignment
distroLinuxDesktop=('BlankOn' 'Ubuntu' 'Debian' 'ArchLinux' 'LinuxMint')
distroLinuxServer=('UbuntuServer' 'CentOS' 'FedoraServer')

#Menampilkan/memanggil semua elemen dalam array
echo ${distroLinuxDesktop[*]}
echo ${distroLinuxServer[*]}
