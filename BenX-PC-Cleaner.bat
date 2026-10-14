@echo off
title BenX Development PC Cleaner - Developed by Benjamin Krishan
color 1f

:: Check for Administrator Privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    cls
    echo ====================================================================
    echo  ERROR: ADMINISTRATOR PRIVILEGES REQUIRED
    echo ====================================================================
    echo.
    echo  This utility requires administrative rights to remove deep junk
    echo  and system cache files effectively.
    echo.
    echo  Please right-click on this file and select:
    echo  "Run as administrator"
    echo.
    echo ====================================================================
    echo.
    pause
    exit /b
)

cls
echo ====================================================================
echo                   BenX Development PC Cleaner
echo                  Developed by: Benjamin Krishan
echo ====================================================================
echo.
echo  Starting system optimization and junk cleanup...
echo.

:: 1. User Temp Files
echo  [1/7] Cleaning User Temporary Files...
del /s /f /q "%temp%\*.*" >nul 2>&1
for /d %%p in ("%temp%\*.*") do rmdir /s /q "%%p" >nul 2>&1
echo        - Done!

:: 2. Windows System Temp
echo.
echo  [2/7] Cleaning Windows System Temp Files...
del /s /f /q "%systemroot%\Temp\*.*" >nul 2>&1
for /d %%p in ("%systemroot%\Temp\*.*") do rmdir /s /q "%%p" >nul 2>&1
echo        - Done!

:: 3. Prefetch Files
echo.
echo  [3/7] Cleaning Prefetch Cache...
del /s /f /q "%systemroot%\Prefetch\*.*" >nul 2>&1
echo        - Done!

:: 4. Windows Update Download Cache
echo.
echo  [4/7] Cleaning Windows Update Download Cache...
net stop wuauserv >nul 2>&1
del /s /f /q "%systemroot%\SoftwareDistribution\Download\*.*" >nul 2>&1
net start wuauserv >nul 2>&1
echo        - Done!

:: 5. Flush DNS Cache
echo.
echo  [5/7] Flushing DNS and Network Cache...
ipconfig /flushdns >nul 2>&1
echo        - Done!

:: 6. Windows Crash Dumps and Logs
echo.
echo  [6/7] Cleaning Crash Dumps and System Logs...
del /s /f /q "%localappdata%\CrashDumps\*.*" >nul 2>&1
del /s /f /q "%systemroot%\*.log" >nul 2>&1
echo        - Done!

:: 7. Empty Recycle Bin
echo.
echo  [7/7] Emptying the Recycle Bin...
rd /s /q %systemdrive%\$Recycle.bin >nul 2>&1
echo        - Done!

:: Completion Message
echo.
echo ====================================================================
echo                  CLEANUP COMPLETED SUCCESSFULLY!
echo ====================================================================
echo.
echo  Your PC junk, cache, and temp files have been completely cleaned.
echo.
echo  Developed by: Benjamin Krishan
echo  Product of   : BenX Development
echo ====================================================================
echo.
pause
exit