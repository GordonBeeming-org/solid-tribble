#requires -PSEdition Core
# Additional steps to initialize the development container

# Copy container specific setting overrides in
#if (-not (Test-Path "$HOME/.vscode-server/data/Machine"))
#{
#    New-Item "$HOME/.vscode-server/data/Machine" -ItemType Directory | Out-Null
#}
#Copy-Item -LiteralPath "/app/dev/vscode_settings.json" -Destination "$HOME/.vscode-server/data/Machine/settings.json"

# Install sqlserver module so we can use 'Invoke-Sqlcmd'
Install-Module sqlserver -Confirm:$False  -Force

# Invoke-Sqlcmd -ServerInstance "localhost,1433" -Username SA -Password P@ssw0rd12345 -Query "SELECT * FROM sys.databases";

# Create new database
# Source for the retry logic:
# https://stackoverflow.com/a/47712807/411428
$attempts=20
$sleepInSeconds=3
do
{
    try
    {
        Invoke-Sqlcmd -ServerInstance "localhost,1433" -Username SA -Password $env:SA_PASSWORD -Query "CREATE DATABASE [solid-tribble]";
        Write-Host "Database created successfully."
        break;
    }
    catch [Exception]
    {
        #Write-Host $_.Exception.Message
        Write-Host "Retrying..."
    }            
    $attempts--
    if ($attempts -gt 0) { Start-Sleep $sleepInSeconds }
} while ($attempts -gt 0)


cd /app/src/Tribble.Contacts/bin/release/netstandard2.0
/var/opt/mssql/sqlpackage /Action:Publish /SourceFile:Tribble.Contacts.dacpac /TargetServerName:localhost,1433 /TargetDatabaseName:solid-tribble /TargetUser:sa /TargetPassword:$env:SA_PASSWORD /Properties:IncludeCompositeObjects=True

Invoke-Sqlcmd -ServerInstance "localhost,1433" -Username SA -Password $env:SA_PASSWORD -InputFile "/var/opt/mssql/backup/init.sql";

# dotnet new --install MSBuild.Sdk.SqlProj.Templates
