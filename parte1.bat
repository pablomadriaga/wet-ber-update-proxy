@echo off

::DESCOMPRIMIR ARCHIVOS


setlocal
cd /d %~dp0
Call :UnZipFile "C:\veeam10\update" "C:\veeam10\VeeamInstallerSvc.zip"
exit /b

:UnZipFile <ExtractTo> <newzipfile>
set vbs="%temp%\_.vbs"
if exist %vbs% del /f /q %vbs%
>%vbs%  echo Set fso = CreateObject("Scripting.FileSystemObject")
>>%vbs% echo If NOT fso.FolderExists(%1) Then
>>%vbs% echo fso.CreateFolder(%1)
>>%vbs% echo End If
>>%vbs% echo set objShell = CreateObject("Shell.Application")
>>%vbs% echo set FilesInZip=objShell.NameSpace(%2).items
>>%vbs% echo objShell.NameSpace(%1).CopyHere(FilesInZip)
>>%vbs% echo Set fso = Nothing
>>%vbs% echo Set objShell = Nothing
cscript //nologo %vbs%
if exist %vbs% del /f /q %vbs%


:: CREA CARPETA LOG
mkdir C:\VEEAM10\log

if not exist "C:\VEEAM10\update"  (
echo "No se descomprimio carpeta" >> C:\VEEAM10\log\General.LOG

GOTO FIN
)


::VERIFICAR VERSION

reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v4.0.30319\SKUs\.NETFramework,Version=v4.7.2" 2>nul
if errorlevel 1 (
    echo ".NET Framework 4.7.2 is NOT installed" >> C:\VEEAM10\log\General.LOG
) else (
    echo ".NET Framework 4.7.2 is installed" >> C:\VEEAM10\log\General.LOG
)


::EJECUTAR INSTALADOR .NET

cd C:\VEEAM10\update
NDP472-KB4054530-x86-x64-AllOS-ENU.exe /q /log C:\VEEAM10\update\log /norestart
if errorlevel 0 (
    echo ".NET instalacion - OK" >> C:\VEEAM10\log\General.LOG
) else (
    echo ".NET instalacion - ERROR" >> C:\VEEAM10\log\General.LOG
)

:FIN