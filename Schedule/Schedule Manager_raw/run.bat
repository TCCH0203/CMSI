@echo off
cd /d "%~dp0"

:: Check if running from inside a zip file
echo %~dp0 | findstr /i "Temp" >nul
IF %ERRORLEVEL% EQU 0 (
    echo.
    echo ❌ Please extract the folder before running!
    echo.
    echo Right-click the zip file, select "Extract All",
    echo then open the extracted folder and double-click run.bat again.
    echo.
    pause
    exit
)

:: Try py launcher first (most reliable on Windows)
py --version >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    set PYTHON=py
    goto FOUND
)

:: Try python
python --version >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    set PYTHON=python
    goto FOUND
)

:: Try python3
python3 --version >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    set PYTHON=python3
    goto FOUND
)

:: Nothing found - try installing via winget
echo Python not found. Attempting to install Python automatically...
echo.

winget --version >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    echo Installing Python via winget...
    winget install --id Python.Python.3.12 --accept-package-agreements --accept-source-agreements
    IF %ERRORLEVEL% NEQ 0 (
        winget install --id Python.Python.3 --accept-package-agreements --accept-source-agreements
    )
) ELSE (
    echo winget not available. Downloading Python installer...
    curl -L -o "%TEMP%\python_installer.exe" https://www.python.org/ftp/python/3.12.0/python-3.12.0-amd64.exe
    IF %ERRORLEVEL% NEQ 0 (
        echo.
        echo Failed to download Python automatically.
        echo Please download and install Python manually from:
        echo https://www.python.org/downloads/
        echo.
        echo IMPORTANT: Check "Add Python to PATH" during installation.
        pause
        exit
    )
    echo Running Python installer...
    "%TEMP%\python_installer.exe" /quiet InstallAllUsers=0 PrependPath=1 Include_test=0
    echo Python installed successfully.
)

:: Refresh PATH from registry so Python is available without restarting
for /f "tokens=2*" %%A in ('reg query "HKCU\Environment" /v PATH 2^>nul') do set "USER_PATH=%%B"
for /f "tokens=2*" %%A in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PATH 2^>nul') do set "SYS_PATH=%%B"
set "PATH=%SYS_PATH%;%USER_PATH%"

:: Refresh PATH so python is available in this session
echo Refreshing environment...
for /f "tokens=*" %%i in ('where python 2^>nul') do set PYTHON=%%i

py --version >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    set PYTHON=py
    goto FOUND
)

python --version >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    set PYTHON=python
    goto FOUND
)

echo.
echo Python was installed but could not be detected yet.
echo Please close this window and double-click run.bat again.
pause
exit

:FOUND
echo Python found. Checking pip...

:: Bootstrap pip if missing
%PYTHON% -m pip --version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo pip not found. Installing pip...
    %PYTHON% -m ensurepip --upgrade
)

echo Installing required libraries...
%PYTHON% -m pip install flask docxtpl pandas openpyxl python-docx

echo.
echo Starting app...
%PYTHON% app.py
pause
