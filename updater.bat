@echo off & setlocal enableDelayedExpansion
set "quit=timeout /t 2 & exit"

set "tmpVer=%temp%\version.txt"
set "remVer=https://raw.githubusercontent.com/IcarusLivesHF/Batch-Libraries/refs/heads/main/lib/version.txt"
set "gitArchive=https://github.com/IcarusLivesHF/Batch-Libraries/archive/refs/heads/main.zip"

where curl >nul 2>&1 || (
    echo Error: curl is not installed or not in PATH. & %quit%
)
where powershell >nul 2>&1 || (
    echo Error: PowerShell is not available. & %quit%
)

if exist "lib\" (
    echo Checking for updates...
    curl -s -o "%tmpVer%" "%remVer%" || (
		echo Error: Failed to download version info. & %quit%
    )
    
    if exist "%tmpVer%" for /f "usebackq delims=" %%i in ("%tmpVer%") do (
        set "remoteVersion=%%i" & set "remoteVersion=!remoteVersion:.=!"
    ) else echo Error: Temporary version file missing. & %quit%
    
    if exist "lib\version.txt" for /f "usebackq delims=" %%i in ("lib\version.txt") do (
        set "currentVersion=%%i" & set "currentVersion=!currentVersion:.=!"
    ) else (
        echo Error: Local version file is missing.
        set "currentVersion=0"
    )
    del /f /q "%tmpVer%"
    
    if !currentVersion! lss !remoteVersion! (
        echo Update available: !currentVersion! -^> !remoteVersion!
        call :download_and_unpack
    ) else (
        echo No update at this time. & timeout /t 2
    )
) else (
    echo Library not found. Initializing setup...
    mkdir lib\
    call :download_and_unpack
)

exit

:download_and_unpack
    echo Downloading update...
    curl -L -o Batch-Libraries.zip "%gitArchive%" || (
        echo Error: Failed to download archive. & %quit%
    )
    echo Unpacking...
    powershell -Command "Expand-Archive -Path 'Batch-Libraries.zip' -DestinationPath '.' -Force" || (
        echo Error: Failed to unpack archive. & %quit%
    )
    echo Updating library...
    xcopy /E /H /Y "Batch-Libraries-main\lib" "lib\" || (
        echo Error: Failed to copy updated files. & %quit%
    )
    echo Cleaning up...
    rmdir /S /Q "Batch-Libraries-main"
    del /f /q "Batch-Libraries.zip"
    echo Update completed successfully!
goto :eof
