@echo off & setlocal enableDelayedExpansion

set "tmpVer=%temp%\version.txt"
set "remVer=https://raw.githubusercontent.com/IcarusLivesHF/Batch-Libraries/refs/heads/main/lib/version.txt"
set "gitArchive=https://github.com/IcarusLivesHF/Batch-Libraries/archive/refs/heads/main.zip"

if exist "lib\" (
	curl -s -o "%tmpVer%" "%remVer%"
	for /f "usebackq delims=" %%i in ("%tmpVer%") do (
		set "remoteVersion=%%i" & set "remoteVersion=!remoteVersion:.=!")
	for /f "usebackq delims=" %%i in ("lib\version.txt")    do (
		set "currentVersion=%%i" & set "currentVersion=!currentVersion:.=!")
	del /f /q "%tmpVer%"
	
	if !currentVersion! lss !remoteVersion! (
		call :download_and_unpack
	) else (
		echo No update at this time
		timeout /t 2
	)
) else (
	mkdir lib\
	call :download_and_unpack
)
exit /b

:download_and_unpack
	(curl -L -o Batch-Libraries.zip %gitArchive%) & cls
	powershell -Command "Expand-Archive -Path 'Batch-Libraries.zip' -DestinationPath '.' -Force"
	copy /y "Batch-Libraries-main\lib" "%cd%\lib"
	rmdir /S /Q "Batch-Libraries-main"
	del /f /q "Batch-Libraries.zip"
goto :eof
