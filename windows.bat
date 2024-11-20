@echo off
setlocal enabledelayedexpansion

:: Define colors for output
set "RED=0C"
set "GREEN=0A"
set "YELLOW=0E"
set "BLUE=09"
set "CYAN=0B"
set "RESET=07"

:: Clear screen and display welcome message
cls
color %CYAN%
echo ========================================================
color %GREEN%
echo        Welcome to the Luckycoin Node Installation       
color %CYAN%
echo ========================================================

:: Check if curl is available
where curl >nul 2>nul
if errorlevel 1 (
    color %RED%
    echo Curl is not installed. Please install it before running this script.
    pause
    exit /b
)

:: Fetch the latest release URL dynamically
color %BLUE%
echo Fetching the latest release details...
set "LATEST_RELEASE="
for /f "tokens=*" %%i in ('curl -s https://api.github.com/repos/LuckyCoinProj/luckycoinV3/releases/latest') do (
    set "LATEST_RELEASE=!LATEST_RELEASE!%%i"
)
if "!LATEST_RELEASE!"=="" (
    color %RED%
    echo Failed to fetch the latest release information. Please check your internet connection or GitHub API limits.
    pause
    exit /b
)

:: Extract tag name
for /f "tokens=2 delims=:," %%i in ('echo !LATEST_RELEASE! ^| findstr /i /c:"tag_name"') do set "TAG_NAME=%%i"
set "TAG_NAME=%TAG_NAME:"=%"
color %GREEN%
echo Latest release found: %TAG_NAME%

:: Define asset name and URL
set "ASSET_NAME=Node-%TAG_NAME%-windows.zip"
for /f "tokens=*" %%i in ('echo !LATEST_RELEASE! ^| findstr /i /c:"browser_download_url"') do (
    echo %%i | findstr /i /c:"%ASSET_NAME%" >nul
    if not errorlevel 1 (
        for /f "tokens=2 delims=:," %%j in ('echo %%i') do set "ASSET_URL=%%j"
        set "ASSET_URL=%ASSET_URL:~1,-1%"
        goto :continue
    )
)
:continue

if not defined ASSET_URL (
    color %RED%
    echo Failed to find the asset for your selection. Please check the release page manually.
    pause
    exit /b
)

color %GREEN%
echo Selected asset: %ASSET_NAME%

:: Check if Luckycoin Node is already running and prompt for update
tasklist | findstr /i luckycoind.exe >nul
if not errorlevel 1 (
    color %YELLOW%
    echo Luckycoin Node is already running.
    luckycoin-cli --version | findstr /r /o "^LuckyCoin Core RPC client version v[0-9]\.[0-9]\.[0-9]" > version.tmp
    set /p CURRENT_VERSION=<version.tmp
    del version.tmp
    set "CURRENT_VERSION=%CURRENT_VERSION:v=%"
    if "%CURRENT_VERSION%"=="%TAG_NAME%" (
        color %GREEN%
        echo Your Luckycoin Node is already up-to-date (version %TAG_NAME%).
        echo Use "luckycoin-cli help" for commands and management.
        pause
        exit /b
    ) else (
        color %YELLOW%
        echo A new version (%TAG_NAME%) is available. Current version: %CURRENT_VERSION%.
        set /p "update_choice=Do you want to update your Luckycoin Node? (y/n): "
        if /i "%update_choice%"=="y" (
            color %YELLOW%
            echo Stopping Luckycoin Node...
            luckycoin-cli stop
            timeout /t 5 /nobreak >nul
        ) else (
            color %GREEN%
            echo No update performed. Node is still running.
            pause
            exit /b
        )
    )
)

:: Download and install the Luckycoin Node
color %CYAN%
echo ========================================================
echo Step 1: Downloading Luckycoin Node...
echo ========================================================
curl -L -o %ASSET_NAME% %ASSET_URL%
if errorlevel 1 (
    color %RED%
    echo Failed to download the asset. Please check your internet connection.
    pause
    exit /b
)
color %BLUE%
echo Extracting files...
tar -xf %ASSET_NAME%
del %ASSET_NAME%

:: Move binaries to installation path
if exist "%ProgramFiles%\Luckycoin" (
    echo Luckycoin binaries already exist. Overwriting...
    rmdir /s /q "%ProgramFiles%\Luckycoin"
)
mkdir "%ProgramFiles%\Luckycoin"
move luckycoind.exe luckycoin-cli.exe luckycoin-tx.exe "%ProgramFiles%\Luckycoin"

:: Add Luckycoin path to environment variables
setx PATH "%PATH%;%ProgramFiles%\Luckycoin" >nul

:: Create data directory and download configuration
mkdir %AppData%\Luckycoin
curl -L -o %AppData%\Luckycoin\luckycoin.conf https://github.com/LuckyCoinProj/luckycoinV3/releases/download/%TAG_NAME%/luckycoin.conf

:: Run Luckycoin Node
"%ProgramFiles%\Luckycoin\luckycoind.exe" -daemon

:: Completion message
color %GREEN%
echo ========================================================
echo Luckycoin Node setup complete!
echo ========================================================
echo Use "luckycoin-cli help" for commands and management.
echo Example: To check the current block height of your node, run:
echo luckycoin-cli getblockcount
echo This will display the current block height, helping you verify your node's synchronization status.
pause
exit /b