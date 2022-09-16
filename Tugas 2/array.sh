#!/bin/bash

# delarasi array
distroLinux=("Mint" "Ubuntu" "Kali" "Arch" "Debian")

# random distro
let pilih=$RANDOM%5

echo "Saya memilih distro $pilih, ${distroLinux[$pilih]} !"
