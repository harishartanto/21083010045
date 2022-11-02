#!/bin/bash

# Deklarasi function
l_persegi_panjang() {
	read -p $'Masukkan panjang:\n' p
	read -p $'\nMasukkan lebar:\n' l
	luas=$(printf "$p $l" | awk '{print $1*$2}')
	echo -e "\nLuas persegi panjang:\n$luas"
}

# Pemanggilan function
l_persegi_panjang
