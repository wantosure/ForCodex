@echo off
setlocal

rem Change this path if ControlMyMonitor.exe is installed elsewhere.
set "CMM=D:\Program Files\controlmymonitor\ControlMyMonitor.exe"

rem Replace these with values tested on your own computer.
set "SECONDARY_MONITOR=\\.\DISPLAY2\Monitor0"
set "SECONDARY_INPUT=17"
set "MAIN_MONITOR=\\.\DISPLAY1\Monitor0"
set "MAIN_INPUT=17"

if not exist "%CMM%" (
    echo ControlMyMonitor not found:
    echo %CMM%
    pause
    exit /b 1
)

rem Switch the secondary monitor first.
"%CMM%" /SetValue "%SECONDARY_MONITOR%" 60 %SECONDARY_INPUT%

rem Wait before switching the main monitor.
timeout /t 3 /nobreak >nul

rem Switch the main monitor last.
"%CMM%" /SetValue "%MAIN_MONITOR%" 60 %MAIN_INPUT%

exit /b %ERRORLEVEL%
