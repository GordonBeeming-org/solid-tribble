FROM mcr.microsoft.com/dotnet/sdk:5.0

# Install Powershell core
RUN wget -q https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb \
&& dpkg -i packages-microsoft-prod.deb \
&& apt-get update \
&& apt-get install -y powershell

RUN apt-get install unzip

RUN useradd -m -s $(which bash) devacc
# Option '-m' to create home directory see https://askubuntu.com/a/393470
# How to set bash as shell, see comments in the same answer

# Create working directory and change ownership.
# Ownership will be preserved when mounting volume to /app
# See https://stackoverflow.com/a/56990338/411428
# and https://github.com/docker/compose/issues/3270#issuecomment-543603959
RUN mkdir /app && chown devacc:devacc /app

USER devacc

# Get sqlpackage .NET Core for Linux 
RUN mkdir ~/sqlpackage \
&& cd ~/sqlpackage \
&& wget -q https://download.microsoft.com/download/0/2/0/020aa2fa-f3f2-41ba-bacd-ff15557890d3/sqlpackage-linux-x64-en-US-15.0.5084.2.zip \
&& unzip sqlpackage-linux-x64-en-US-15.0.5084.2.zip \
&& rm sqlpackage-linux-x64-en-US-15.0.5084.2.zip \
&& echo "export PATH=\"\$PATH:$HOME/sqlpackage\"" >> ~/.bashrc \
&& chmod a+x ~/sqlpackage/sqlpackage
