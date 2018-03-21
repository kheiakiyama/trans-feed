#!/bin/sh
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-xenial-prod xenial main" > /etc/apt/sources.list.d/dotnetdev.list'
sudo apt-get update
sudo apt-get install libunwind8
wget -O dotnet.tar.gz https://download.microsoft.com/download/D/7/2/D725E47F-A4F1-4285-8935-A91AE2FCC06A/dotnet-sdk-2.0.3-linux-x64.tar.gz
mkdir -p $HOME/dotnet && tar zxf dotnet.tar.gz -C $HOME/dotnet
export PATH=$PATH:$HOME/dotnet
dotnet --version
wget -O azcopy.tar.gz https://aka.ms/downloadazcopyprlinux
tar -xf azcopy.tar.gz
ls -la ./azcopy
ls -la ./_site
export PATH=$PATH:$HOME/dotnet
dotnet --version
dotnet ./azcopy/azcopy.dll --version
