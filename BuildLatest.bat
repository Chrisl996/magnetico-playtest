@echo off
title Magnetica - Update Latest Build

echo.
echo ==========================================
echo      Updating Latest Build
echo ==========================================
echo.

set "SOURCE=latest_export"
set "DEST=docs\latest"

if not exist "%SOURCE%" (
    echo ERROR: "%SOURCE%" does not exist.
    echo Export the Godot web build there first.
    pause
    exit /b 1
)

if not exist "%DEST%" (
    echo ERROR: "%DEST%" does not exist.
    echo Your existing GitHub latest folder could not be found.
    pause
    exit /b 1
)

echo Copying new Godot build...
echo Preserving docs\latest\index.html
echo.

robocopy "%SOURCE%" "%DEST%" /E /XF index.html

set "RESULT=%ERRORLEVEL%"

if %RESULT% GEQ 8 (
    echo.
    echo ERROR: Robocopy failed with code %RESULT%.
    pause
    exit /b %RESULT%
)

echo.
echo ==========================================
echo      Latest build updated!
echo ==========================================
echo.
echo GitHub structure has NOT changed.
echo docs\latest\index.html was NOT overwritten.
echo.

pause