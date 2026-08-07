@echo off
setlocal
title Magnetica - Update Latest Build

REM ============================================================
REM ALWAYS RUN RELATIVE TO THIS BAT FILE
REM ============================================================

cd /d "%~dp0"

set "SOURCE=%~dp0latest_export"
set "DEST=%~dp0docs\latest"

echo.
echo ==========================================
echo      MAGNETICA - UPDATE LATEST
echo ==========================================
echo.
echo Batch folder:
echo %~dp0
echo.
echo Source:
echo %SOURCE%
echo.
echo Destination:
echo %DEST%
echo.

REM ============================================================
REM CHECK FOLDERS
REM ============================================================

if not exist "%SOURCE%\" (
    echo ERROR:
    echo Could not find the latest_export folder.
    echo.
    echo Expected:
    echo %SOURCE%
    echo.
    pause
    exit /b 1
)

if not exist "%DEST%\" (
    echo ERROR:
    echo Could not find docs\latest.
    echo.
    echo Expected:
    echo %DEST%
    echo.
    pause
    exit /b 1
)

REM ============================================================
REM COPY BUILD
REM ============================================================

echo Copying new build files...
echo.
echo IMPORTANT:
echo docs\latest\index.html will NOT be overwritten.
echo.

robocopy "%SOURCE%" "%DEST%" /E /COPY:DAT /DCOPY:T /R:1 /W:1 /XF index.html

set "ROBO_RESULT=%ERRORLEVEL%"

echo.
echo ==========================================

REM Robocopy codes 0-7 are successful/non-fatal.
if %ROBO_RESULT% GEQ 8 (
    echo COPY FAILED
    echo Robocopy error code: %ROBO_RESULT%
    echo ==========================================
    echo.
    pause
    exit /b %ROBO_RESULT%
)

echo      LATEST BUILD UPDATED
echo ==========================================
echo.
echo Robocopy result code: %ROBO_RESULT%
echo.
echo Custom file preserved:
echo %DEST%\index.html
echo.
echo Check GitHub Desktop now - the changed build files
echo should appear under docs\latest.
echo.

pause
endlocal
