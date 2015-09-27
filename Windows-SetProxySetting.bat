@echo off
setlocal
set proxyaddress=172.12.22.11
set proxyport=8080

set datadir=HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings

REM -----------
REM * PROCESS *
REM -----------

CHOICE /C YNC /M "Enable (y), disable (n) or restore (c)"

if %ERRORLEVEL% EQU 1 (
  call :OnOff 1
  call :localaddr

) else if %ERRORLEVEL% EQU 2 (
  call :OnOff 0

) else if %ERRORLEVEL% EQU 3 (
  call :OnOff 0
  call :removing

)
REM End of script
goto :eof

REM -----------
REM * REGEDIT *
REM -----------

:OnOff
REM Use a proxy server
reg add "%datadir%" /v ProxyEnable /t reg_dword /d %1 /f
reg add "%datadir%" /v ProxyServer /t reg_sz /d %proxyaddress%:%proxyport% /f
goto :eof

:localaddr
REM Bypass proxy server for local addresses
reg add "%datadir%" /v ProxyOverride /t reg_sz /d "<local>" /f
goto :eof

:removing
REM Removing the registry entries
reg delete "%datadir%" /v ProxyOverride /f
reg delete "%datadir%" /v ProxyServer /f
goto :eof