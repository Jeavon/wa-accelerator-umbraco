@echo off

setlocal 
%~d0
cd "%~dp0"

cscript "%~dp0setup\SetupLocal.vbs"