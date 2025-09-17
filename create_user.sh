#!/bin/bash

<<help
this shell script
used for create users
help

echo "===== create a User ====="

read -p "enter username: " username

read -p "enter password: " password

sudo useradd -m "$username"

echo -e "$password\n$password" | sudo passwd "$username"

echo "===== user is created====="
