@echo off

setlocal 
%~d0
cd "%~dp0"

ECHO Checking for dependencies...

setup\ContentInstallerClient\ContentInstallerClient.exe /depi:setup\WindowsAzureAcceleratorForUmbraco.depi