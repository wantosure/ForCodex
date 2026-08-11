@echo off
setlocal

rem Change this path if ControlMyMonitor.exe is installed elsewhere.
set "CMM=D:\Program Files\controlmymonitor\ControlMyMonitor.exe"

rem Replace these with values tested on the second computer.
set "SECONDARY_MONITOR=\\.\DISPLAY2\Monitor0"
set "SECONDARY_INPUT=15"
set "MAIN_MONITOR=\\.\DISPLAY1\Monitor0"
set "MAIN_INPUT=15"

if not exist "%CMM%" (
    echo ControlMyMonitor not found:
    echo %CMM%
    pause
    exit /b 1
)

"%CMM%" /SetValue "%SECONDARY_MONITOR%" 60 %SECONDARY_INPUT%
timeout /t 3 /nobreak >nul
"%CMM%" /SetValue "%MAIN_MONITOR%" 60 %MAIN_INPUT%

exit /b %ERRORLEVEL%
