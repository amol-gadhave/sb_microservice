@echo off
setlocal enabledelayedexpansion
set host=%COMPUTERNAME%
set "host=!host: =!"
set hostname=%host:~3,1%
if /I "%hostname%" == "O" ( 
echo OO store 
powershell.exe -ExecutionPolicy Bypass -File "%1" "%2"
) else (
 echo FR store 
)


endlocal
