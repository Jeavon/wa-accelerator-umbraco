@ECHO off
echo.
echo Importing Data...
osql -S %1 -d %2 -U %3 -P %4 -i %~dp0db\SqlAzure.ImportCleanDatabase.sql
echo.
echo Done!
echo.
