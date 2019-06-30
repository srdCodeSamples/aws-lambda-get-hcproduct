#!/usr/bin/env bash
# Install needed software and basic configs

# Terraform version
export TF_VERSION="0.12.3"

# Add Microsoft repository to apt
wget -q -P /tmp https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb
sudo dpkg -i /tmp/packages-microsoft-prod.deb

# update Apt cache
sudo apt-get update
export DEBIAN_FRONTEND=noninteractive

# install general tools
PKG="wget unzip curl jq vim"
which ${PKG} &>/dev/null || {
  sudo apt-get install -y ${PKG}
}

# install dotnet core
which dotnet || {
    sudo apt-get install -y apt-transport-https
    sudo apt-get install -y dotnet-sdk-2.1
}


# Install terraform
which terraform || {
    wget -q -P /tmp \
       https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip && {
           sudo unzip /tmp/terraform_${TF_VERSION}_linux_amd64.zip terraform -d /usr/bin
       }
}

# Cleanup
sudo apt-get clean
rm -f /tmp/terraform_${TF_VERSION}_linux_amd64.zip /tmp/packages-microsoft-prod.deb