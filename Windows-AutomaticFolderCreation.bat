@echo off
setlocal
set UuidOutputPath=%SkyDriveDir%\Public
set UuidNumber=100

if not "%1"=="" (
  set UuidOutputPath=%1
  set UuidNumber=%2
)

for /f "tokens=*" %%i in ('Uuidgen -c -n%UuidNumber%') do (
  mkdir "%UuidOutputPath%\%%i"
)
goto :eof