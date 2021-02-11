@echo off

::EJECUTAR INSTALADOR COMPONENTES

msiexec.exe /L*v "C:\VEEAM10\log\VeeamInstallerSvc.log" /qn /i "C:\VEEAM10\update\VeeamInstallerSvc.msi" ACCEPTEULA="yes" ACCEPT_THIRDPARTY_LICENSES="1"

if errorlevel 0 (
    echo "VeeamInstallerSvc - OK" >> C:\VEEAM10\log\componentes.log
) else (
    echo "VeeamInstallerSvc - ERROR" >> C:\VEEAM10\log\componentes.log
)

msiexec.exe /L*v "C:\VEEAM10\log\VeeamMountService.log" /qn /i "C:\VEEAM10\update\VeeamMountService.msi" ACCEPTEULA="yes" ACCEPT_THIRDPARTY_LICENSES="1"

if errorlevel 0 (
    echo "VeeamMountService - OK" >> C:\VEEAM10\log\componentes.log
) else (
    echo "VeeamMountService - ERROR" >> C:\VEEAM10\log\componentes.log
)


msiexec.exe /L*v "C:\VEEAM10\log\VeeamTransport.log" /qn /i "C:\VEEAM10\update\VeeamTransport.msi" ACCEPTEULA="yes" ACCEPT_THIRDPARTY_LICENSES="1"

if errorlevel 0 (
    echo "VeeamTransport - OK" >> C:\VEEAM10\log\componentes.log
) else (
    echo "VeeamTransport - ERROR" >> C:\VEEAM10\log\componentes.log
)