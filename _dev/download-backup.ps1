cd $PSScriptRoot/../
if(-not (Test-Path "__downloads"))
{
  New-Item "__downloads" -ItemType Directory
}
cd "__downloads"
if(-not (Test-Path "demo.bak"))
{
  Invoke-WebRequest -Uri "https://github.com/dah-dah-demos/stunning-memory/raw/main/files/demo.bak" -OutFile "demo.bak"
}
