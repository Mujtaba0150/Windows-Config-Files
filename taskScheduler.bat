@echo off

:: --------- Task 1 ---------
set "taskName="
for /f "tokens=1,2 delims=<>" %%a in ('findstr /i "<URI>" "kanata.xml"') do (
    set "taskName=%%b"
)

if not defined taskName (
    echo Could not find <URI> in kanata.xml.
    exit /b 1
)

echo Importing task "%taskName%" from "kanata.xml"...
schtasks /create /tn "%taskName%" /xml "kanata.xml" /f

if %errorlevel% equ 0 (
    echo Task "%taskName%" imported successfully.
) else (
    echo Failed to import task "%taskName%".
)

pause

:: --------- Task 2 ---------
set "taskName="
for /f "tokens=1,2 delims=<>" %%a in ('findstr /i "<URI>" "Nazimeen Reminder Automation.xml"') do (
    set "taskName=%%b"
)

if not defined taskName (
    echo Could not find <URI> in "Nazimeen Reminder Automation.xml".
    exit /b 1
)

echo Importing task "%taskName%" from "Nazimeen Reminder Automation.xml"...
schtasks /create /tn "%taskName%" /xml "Nazimeen Reminder Automation.xml" /f

if %errorlevel% equ 0 (
    echo Task "%taskName%" imported successfully.
) else (
    echo Failed to import task "%taskName%".
)

pause

:: --------- Task 3 ---------
set "taskName="
for /f "tokens=1,2 delims=<>" %%a in ('findstr /i "<URI>" "ADB Connection.xml"') do (
    set "taskName=%%b"
)

if not defined taskName (
    echo Could not find <URI> in "ADB Connection.xml".
    exit /b 1
)

echo Importing task "%taskName%" from "ADB Connection.xml"...
schtasks /create /tn "%taskName%" /xml "ADB Connection.xml" /f

if %errorlevel% equ 0 (
    echo Task "%taskName%" imported successfully.
) else (
    echo Failed to import task "%taskName%".
)

pause
