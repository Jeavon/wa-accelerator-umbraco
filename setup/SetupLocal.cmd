@ECHO off
%~d0
CD "%~dp0"

IF EXIST %WINDIR%\SysWow64 (
	SET powerShellDir=%WINDIR%\SysWow64\windowspowershell\v1.0
) ELSE (
	SET powerShellDir=%WINDIR%\system32\windowspowershell\v1.0
)

%powerShellDir%\powershell.exe -NonInteractive -Command "Set-ExecutionPolicy unrestricted"

ECHO.
ECHO *******************************************************************************
ECHO ***       Updating DataConectionString in ServiceConfiguration.cscfg        ***
ECHO *******************************************************************************
ECHO.

ECHO Setting up ServiceConfiguration.cscfg to use development blob storage.
ECHO.

%powerShellDir%\powershell.exe -NonInteractive .\scripts\SetupServiceConfigurationLocal.ps1

ECHO.
ECHO *******************************************************************************
ECHO ***                   Deploy Accelerator to Windows Azure                   ***
ECHO *******************************************************************************
ECHO.

ECHO You'll need to manually deploy the Accelerator to Windows Azure. Load in Visual Studio and start
ECHO the webrole by pressing F5.
ECHO.
ECHO Once you complete this step press any key to continue... 
PAUSE > NUL

ECHO.
ECHO *******************************************************************************
ECHO ***                 Migrating Umbraco Database to SQL Azure                 ***
ECHO *******************************************************************************
ECHO.

ECHO If you don't have a SQL Azure Server Created you can create one following the 
ECHO steps described on the Get Started section of the StartHere.htm document.
ECHO.

ECHO.
ECHO If you already have an instance of Umbraco running locally you'll need to 
ECHO migrate the SQL Server database to SQL Azure. To do this, you can use the SQL 
ECHO Azure Migration Wizard (http://sqlazuremw.codeplex.com/) and follow the 
ECHO instructions to migrate your database.
ECHO.
CHOICE /M "Do you wish to setup Umbraco with a clean database"

IF ERRORLEVEL 2 GOTO SkipCleanDB

SET /p SQLServer="Type the server name: " 
SET /p SQLDatabase="Type the database name to create: "
SET /p SQLUser="Type the SQL user name: "
SET /p SQLPassword="Type the SQL password: "

CALL SetupUmbracoSchemaLocal.cmd "%SQLServer%" "%SQLDatabase%" "%SQLUser%" "%SQLPassword%"
CALL SetupUmbracoDataLocal.cmd "%SQLServer%" "%SQLDatabase%" "%SQLUser%" "%SQLPassword%"

GOTO SkipGetSQLData

:SkipCleanDB
SET /p SQLServer="Type the server name: " 
SET /p SQLDatabase="Type the database name that you migrated: "
SET /p SQLUser="Type the SQL user name: "
SET /p SQLPassword="Type the SQL password: "

:SkipGetSQLData
ECHO.
ECHO *******************************************************************************
ECHO ***                    Downloading and Extracting Umbraco                   ***
ECHO *******************************************************************************
ECHO.

ECHO You'll need to download an extract umbraco from: http://umbraco.codeplex.com
ECHO Note that the accelerator bits where last tested with Umbraco 4.7, there might 
ECHO be some tweaks required to run with a newer version.
ECHO.
ECHO Once you complete this step press any key to continue... 
PAUSE > NUL

ECHO.
ECHO *******************************************************************************
ECHO ***          Configuring the SQL Azure Connection String in Umbraco         ***
ECHO *******************************************************************************
ECHO.

:GetUmbracoPath
SET /p UmbracoPath="Type the path were you extracted Umbraco with the trailing slash (eg: c:\Umbraco\4.7\build\): "

IF NOT EXIST "%UmbracoPath%web.config" (
ECHO.
ECHO The provided path seems incorrect. To make sure its correct, check that it 
ECHO points to the root folder, which contains the web.config file inside.
GOTO GetUmbracoPath
ECHO.
)

%powerShellDir%\powershell.exe -NonInteractive "& .\scripts\SetupUmbracoDBConnectionStringLocal.ps1 '%UmbracoPath%' '%SQLServer%' '%SQLDatabase%' '%SQLUser%' '%SQLPassword%'"

ECHO.
ECHO *******************************************************************************
ECHO ***              Configuring SQL Azure Session State in Umbraco             ***
ECHO *******************************************************************************
ECHO.

SET /p SessionStateDatabase="Type the Session State database name to create: "

CALL SetupSessionStateLocal.cmd "%SQLServer%" "%SessionStateDatabase%" "%SQLUser%" "%SQLPassword%"

%powerShellDir%\powershell.exe -NonInteractive "& .\scripts\SetupUmbracoSessionStateLocal.ps1 '%UmbracoPath%' '%SQLServer%' '%SessionStateDatabase%' '%SQLUser%' '%SQLPassword%'"

ECHO.
ECHO *******************************************************************************
ECHO ***                    Configuring Machine Key in Umbraco                   ***
ECHO *******************************************************************************
ECHO.

%powerShellDir%\powershell.exe -NonInteractive "& .\scripts\SetupMachineKey.ps1 '%UmbracoPath%'"

ECHO.
ECHO *******************************************************************************
ECHO ***                Configuring Custom HTTP Module in Umbraco                ***
ECHO *******************************************************************************
ECHO.

%powerShellDir%\powershell.exe -NonInteractive "& .\scripts\SetupHttpModule.ps1 '%UmbracoPath%'"

ECHO.
ECHO *******************************************************************************
ECHO ***                     Uploading Umbraco to Blob Storage                   ***
ECHO *******************************************************************************
ECHO.

CHOICE /M "Do you wish to upload an existing Umbraco site to Blob Storage?"
IF ERRORLEVEL 2 GOTO end

SET /p SiteName="Type the name of the site, which will be used to configure the host header in IIS: "

.\uploader\DeploySite.exe "%UmbracoPath%\" "sites" "%SiteName%" "%StorageName%" "%StorageKey%"

PAUSE

:end
