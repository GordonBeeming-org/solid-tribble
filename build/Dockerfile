FROM mcr.microsoft.com/mssql/server:2019-latest
EXPOSE 1433

USER root

# Install Powershell core
RUN wget -q https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb \
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

ENTRYPOINT [ "/opt/microsoft/powershell/7/pwsh", "/var/opt/mssql/backup/init.ps1" ]

ENTRYPOINT ["/opt/mssql-tools/bin/sqlcmd","-S","localhost","-U","SA","-P","$SA_PASSWORD", "-Q","RESTORE DATABASE [demo] FROM DISK = '/var/opt/mssql/backup/demo.bak' WITH MOVE 'Demo' TO '/var/opt/mssql/data/demo.mdf', MOVE , MOVE 'Demo_log' TO '/var/opt/mssql/data/demo.ldf'"]

CMD ["/opt/mssql/bin/sqlservr"]