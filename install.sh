#!/bin/bash

echo "This script was written and test for debian systems, if your system is not compatible abort now!"
read -p "Continue (y/n)? " choice
case "$choice" in
	n|N)
		exit 0;;
	y|Y)
		break;;
	*)
		echo "Please answer with y/Y or n/N"
		exit 0;;
esac

# Preparation
sudo apt-get install -y build-essential checkinstall
mkdir dnscrypt && cd dnscrypt
wget https://download.libsodium.org/libsodium/releases/libsodium-0.4.5.tar.gz
wget https://download.libsodium.org/libsodium/releases/libsodium-0.4.5.tar.gz.sig
gpg --recv-keys 1CDEA439 && gpg --verify libsodium-0.4.5.tar.gz.sig && tar -zxvf libsodium-0.4.5.tar.gz
wget http://download.dnscrypt.org/dnscrypt-proxy/dnscrypt-proxy-1.3.3.tar.gz
wget http://download.dnscrypt.org/dnscrypt-proxy/dnscrypt-proxy-1.3.3.tar.gz.sig
gpg --verify dnscrypt-proxy-1.3.3.tar.gz.sig && tar -zxvf dnscrypt-proxy-1.3.3.tar.gz

# Build NaCl
cd libsodium-0.4.5
./configure && make && sudo checkinstall --default make install && sudo rm *.deb
sudo ldconfig -v

# Build dnscrypt
cd ../dnscrypt-proxy-1.3.3
./configure && make && sudo checkinstall --default make install && sudo rm *.deb

# Add dnscrypt user
sudo adduser --system --quiet --shell /bin/false --group --disabled-password --disabled-login dnscrypt

# Add system daemon
sudo cp ./dnscrypt.daemon /etc/init.d/dnscrypt
sudo chmod +x /etc/init.d/dnscrypt

# Add daemon options file
sudo cp ./dnscrypt.default /etc/default/dnscrypt

echo "Installation succeded! Start the daemon using \"service dnscrypt start\" and configure your computer to use the address \"127.0.0.1\" as the dns server"
