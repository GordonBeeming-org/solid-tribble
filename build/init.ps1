#requires -PSEdition Core

# Create new database
# Source for the retry logic:
# https://stackoverflow.com/a/47712807/411428
$attempts=20
$sleepInSeconds=3
Start-Sleep 10 # give it some time before we go in there
do
{
    try
    {
        /opt/mssql-tools/bin/sqlcmd -S ".,1433" -U SA -P $env:SA_PASSWORD -Q "CREATE DATABASE [solid-tribble]"
        Write-Host "Database created successfully."
        break;
    }
    catch [Exception]
    {
        Write-Host "Retrying... $($_.Exception.Message)"
    }            
    $attempts--
    if ($attempts -gt 0) { Start-Sleep $sleepInSeconds }
} while ($attempts -gt 0)

/opt/mssql-tools/bin/sqlcmd -S ".,1433" -U SA -P $env:SA_PASSWORD -Q "RESTORE DATABASE [demo] FROM DISK = '/var/opt/mssql/backup/demo.bak' WITH MOVE 'Demo' TO '/var/opt/mssql/data/demo.mdf', MOVE 'Demo_log' TO '/var/opt/mssql/data/demo.ldf'"

cd /var/opt/mssql/backup
/var/opt/mssql/sqlpackage/sqlpackage /Action:Publish /SourceFile:Tribble.Contacts.dacpac /TargetServerName:.,1433 /TargetDatabaseName:solid-tribble /TargetUser:sa /TargetPassword:$env:SA_PASSWORD /Properties:IncludeCompositeObjects=True

/opt/mssql-tools/bin/sqlcmd -S ".,1433" -U SA -P $env:SA_PASSWORD -d "solid-tribble" -t "/var/opt/mssql/backup/init.sql"