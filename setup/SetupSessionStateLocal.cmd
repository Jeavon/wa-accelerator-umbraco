@ECHO off
echo.
echo Creating the SQL Azure database...

osql -S %1 -U %3 -P %4 -Q "if exists (select * from sys.databases where name = '%2') print 'true' else print 'false'" > tmpFile 
set /p existsDatabase= < tmpFile 
del tmpFile

if %existsDatabase% == true goto DeleteDB

goto CreateDB

:DeleteDB
echo.
echo Database '%2' already exists. Please delete it and then press any key to continue...
pause > nul
echo.
echo Creating SQL Azure database...
goto CreateDB

:CreateDB
osql -S %1 -U %3 -P %4 -Q "create database %2"
echo.
echo Done!
echo.
echo Importing Session State Schema...
osql -S %1 -d %2 -U %3 -P %4 -i %~dp0db\InstallSqlState.sql
echo.
echo Done!
echo.