@echo off

setlocal 
%~d0
cd "%~dp0"

ECHO Checking for dependencies...

ContentInstallerClient\ContentInstallerClient.exe /depi:WindowsAzureAcceleratorForUmbraco.depi