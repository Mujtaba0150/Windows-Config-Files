@echo off
setlocal enabledelayedexpansion

:: Check if correct number of arguments are provided
if "%~1"=="" (
    echo Usage: %~nx0 ^<json_file^> ^<installation_directory^>
    exit /b 1
)

set JSON_FILE=%~1
set INSTALL_DIR=%~2

:: Check if jq is available
where jq >nul 2>nul
if %errorlevel% neq 0 (
    echo Error: jq is not installed. Please install jq and try again.
    exit /b 1
)

:: Extract package names and identifiers
for /f "delims=" %%A in ('jq -r ".Sources[].Packages[] | .PackageName + \" \" + .PackageIdentifier" "%JSON_FILE%"') do (
    for /f "tokens=1*" %%B in ("%%A") do (
        set PACKAGE_NAME=%%B
        set PACKAGE_ID=%%C
        echo Installing !PACKAGE_NAME!...
        winget install --id !PACKAGE_ID! --scope machine -l "%INSTALL_DIR%\!PACKAGE_NAME!" -i
    )
)

echo All installations completed.
exit /b 0
