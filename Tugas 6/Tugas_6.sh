#!/bin/bash

read -p "Input Jumlah Semester: " smt

i=0
until [ $i -eq $smt ]
do
    read -p "Input IP semester $((i+1)): " ip
    IPSMahasiswa[$i]=$ip
    i=$((i+1))
done

j=0
for x in ${IPSMahasiswa[*]}
do
    j=$(printf "$j $x" | awk '{print $1 + $2}')
done

rataan=$(printf "$j $smt" | awk '{print $1 / $2}')
echo -e "\nIPS Mahasiswa = $j / $smt"
echo -n "IPK Mahasiswa = "
printf "%.2f" $rataan
echo
