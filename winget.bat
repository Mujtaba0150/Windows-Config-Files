@echo off
setlocal enabledelayedexpansion

:: --- Check arguments ---
if "%~1"=="" (
    echo [ERROR] Missing parameter. Use: InstallPackages.bat -l "C:\InstallRoot"
    exit /b 1
)

if /i "%~1" neq "-l" (
    echo [ERROR] Unknown parameter "%~1". Use -l to specify installation root.
    exit /b 1
)

if "%~2"=="" (
    echo [ERROR] No installation root folder provided.
    exit /b 1
)

set "INSTALL_ROOT=%~2"

:: --- Check if installedPackages.json exists ---
if not exist "installedPackages.json" (
    echo [ERROR] installedPackages.json not found in current folder.
    exit /b 1
)

:: --- Parse JSON and install packages ---
for /f "usebackq tokens=* delims=" %%A in (`powershell -NoProfile -Command ^
    "Get-Content installedPackages.json | ConvertFrom-Json | ForEach-Object { Write-Output ($_.Name + '|' + $_.Id) }"`) do (
    for /f "tokens=1,2 delims=|" %%B in ("%%A") do (
        set "PKG_NAME=%%B"
        set "PKG_ID=%%C"

        echo Installing !PKG_NAME! [!PKG_ID!] into "%INSTALL_ROOT%\!PKG_NAME!" ...

        winget install --id !PKG_ID! ^
            --location "%INSTALL_ROOT%\!PKG_NAME!" ^
            --include-dependencies ^
            --accept-package-agreements ^
            --accept-source-agreements ^
            -i
    )
)

echo.
echo [DONE] All packages processed.
endlocal
