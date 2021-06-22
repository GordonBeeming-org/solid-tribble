FROM mcr.microsoft.com/mssql/server:2019-latest
EXPOSE 1433

USER root

# Install Powershell core
RUN wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb \
&& dpkg -i packages-microsoft-prod.deb \
&& apt-get update \
&& apt-get install -y powershell

RUN apt-get install unzip

# Get sqlpackage .NET Core for Linux 
RUN mkdir /var/opt/mssql/sqlpackage && cd /var/opt/mssql/sqlpackage \
&& wget -q https://download.microsoft.com/download/0/2/0/020aa2fa-f3f2-41ba-bacd-ff15557890d3/sqlpackage-linux-x64-en-US-15.0.5084.2.zip \
&& unzip sqlpackage-linux-x64-en-US-15.0.5084.2.zip \
&& rm sqlpackage-linux-x64-en-US-15.0.5084.2.zip \
&& echo "export PATH=\"\$PATH:/var/opt/mssql/sqlpackage\"" >> ~/.bashrc \
&& chmod a+x /var/opt/mssql/sqlpackage/sqlpackage

USER mssql
 
COPY "__downloads" "/var/opt/mssql/backup/"

COPY "build/entrypoint.sh" "/var/opt/mssql/backup/entrypoint.sh"
COPY "build/init.ps1" "/var/opt/mssql/backup/init.ps1"
COPY "build/init.sql" "/var/opt/mssql/backup/init.sql"
COPY "src/Tribble.Contacts/bin/release/netstandard2.0/Tribble.Contacts.dacpac" "/var/opt/mssql/backup/Tribble.Contacts.dacpac"

CMD ["/bin/bash","/var/opt/mssql/backup/entrypoint.sh"]