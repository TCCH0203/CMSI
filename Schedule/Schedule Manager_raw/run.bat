@echo off
title Schedule Manager
cd /d "%~dp0"

echo ====================================
echo  Schedule Manager
echo ====================================
echo.

:: Check if running from inside a zip file
echo %~dp0 | findstr /i "Temp" >nul
IF %ERRORLEVEL% EQU 0 (
    echo ERROR: Please extract the folder before running!
    echo.
    echo Right-click the zip file, select "Extract All",
    echo then open the extracted folder and double-click run.bat again.
    echo.
    pause
    exit
)

:: ============================
:: FIND PYTHON
:: ============================
echo Checking for Python...

py --version >nul 2>&1
IF %ERRORLEVEL% EQU 0 ( set PYTHON=py & goto FOUND )

python --version >nul 2>&1
IF %ERRORLEVEL% EQU 0 ( set PYTHON=python & goto FOUND )

python3 --version >nul 2>&1
IF %ERRORLEVEL% EQU 0 ( set PYTHON=python3 & goto FOUND )

:: ============================
:: PYTHON NOT FOUND - INSTALL
:: ============================
echo Python not found. Installing automatically...
echo.

winget --version >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    echo Installing Python via winget...
    winget install --id Python.Python.3.12 --accept-package-agreements --accept-source-agreements
    IF %ERRORLEVEL% NEQ 0 (
        winget install --id Python.Python.3 --accept-package-agreements --accept-source-agreements
    )
) ELSE (
    echo Downloading Python installer...
    curl -L -o "%TEMP%\python_installer.exe" https://www.python.org/ftp/python/3.12.0/python-3.12.0-amd64.exe
    IF %ERRORLEVEL% NEQ 0 (
        echo.
        echo Could not download Python automatically.
        echo Please download and install Python from:
        echo https://www.python.org/downloads/
        echo.
        echo IMPORTANT: Check "Add Python to PATH" during installation.
        echo Then double-click run.bat again.
        echo.
        pause
        exit
    )
    echo Running Python installer...
    "%TEMP%\python_installer.exe" /quiet InstallAllUsers=0 PrependPath=1 Include_test=0
)

:: Refresh PATH from registry
for /f "tokens=2*" %%A in ('reg query "HKCU\Environment" /v PATH 2^>nul') do set "USER_PATH=%%B"
for /f "tokens=2*" %%A in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PATH 2^>nul') do set "SYS_PATH=%%B"
set "PATH=%SYS_PATH%;%USER_PATH%"

py --version >nul 2>&1
IF %ERRORLEVEL% EQU 0 ( set PYTHON=py & goto FOUND )

python --version >nul 2>&1
IF %ERRORLEVEL% EQU 0 ( set PYTHON=python & goto FOUND )

echo.
echo Python was installed but needs a restart to be detected.
echo Please close this window and double-click run.bat again.
echo.
pause
exit

:: ============================
:: PYTHON FOUND
:: ============================
:FOUND
echo Python found: 
%PYTHON% --version
echo.

:: Bootstrap pip if missing
%PYTHON% -m pip --version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Installing pip...
    %PYTHON% -m ensurepip --upgrade
)

:: Install libraries
echo Installing required libraries...
%PYTHON% -m pip install --upgrade pip
%PYTHON% -m pip install flask==3.0.3 docxtpl==0.16.8 pandas==2.2.2 openpyxl==3.1.2 python-docx==1.1.2 Pillow==10.3.0

echo.
echo ====================================
echo  Starting app...
echo  Open your browser and go to:
echo  http://localhost:5000
echo ====================================
echo.
%PYTHON% app.py
pause
