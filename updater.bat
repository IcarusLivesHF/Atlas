@echo off & setlocal enableDelayedExpansion

if exist "lib\" (
	curl -s -o "%temp%\version.txt" "https://raw.githubusercontent.com/IcarusLivesHF/Batch-Libraries/refs/heads/main/lib/version.txt"
	for /f "usebackq delims=" %%i in ("%temp%\version.txt") do set "remoteVersion=%%i" & set "remoteVersion=!remoteVersion:.=!"
	for /f "usebackq delims=" %%i in ("lib\version.txt")    do set "currentVersion=%%i" & set "currentVersion=!currentVersion:.=!"

	if !currentVersion! lss !remoteVersion! (
		call :download_and_unpack
	)
	del /f /q "%temp%\version.txt"
) else (
	mkdir lib\
	call :download_and_unpack
)
exit

:download_and_unpack
	curl -L -o Batch-Libraries.zip https://github.com/IcarusLivesHF/Batch-Libraries/archive/refs/heads/main.zip
	powershell -Command "Expand-Archive -Path 'Batch-Libraries.zip' -DestinationPath '.' -Force"
	copy /y "Batch-Libraries-main\lib" "%cd%\lib"
	rmdir /S /Q "Batch-Libraries-main"
	del /f /q "Batch-Libraries.zip"
goto :eof