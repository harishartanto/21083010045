#!/bin/bash

# Deklarasi function
nama() {
    echo "Siapa namamu?"
    read nama
    npm	# <--- Pemanggilan function npm
}
npm() {
    echo "Sebutkan NPMmu!"
    read npm
    echo -e "\nHai $nama dengan NPM $npm, selamat datang\ndi praktikum sistem operasi yang seru ini ya!"
}

# Pemanggilan function nama
nama
