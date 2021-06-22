FROM mcr.microsoft.com/mssql/server:2019-latest
EXPOSE 1433

COPY "__downloads" "/var/opt/mssql/backup/"

CMD ["sleep","60"]

CMD ["/opt/mssql-tools/bin/sqlcmd","-S","localhost","-U","SA","-P","$SA_PASSWORD", "-Q","RESTORE DATABASE [demo] FROM DISK = '/var/opt/mssql/backup/demo.bak' WITH MOVE 'Demo' TO '/var/opt/mssql/data/demo.mdf', MOVE , MOVE 'Demo_log' TO '/var/opt/mssql/data/demo.ldf'"]

CMD ["sleep","infinity"]