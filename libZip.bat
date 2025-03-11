@echo off & setlocal enableDelayedExpansion

REM ------------------------------------------------------------------------------
REM libZip.bat
REM ------------------------------------------------------------------------------
REM This script copies a primary batch file and any referenced library components
REM (based on lines starting with "call lib\") into a "sketch" folder, then
REM archives the folder as a .zip (using PowerShell’s Compress-Archive).
REM Usage:
REM   1) Drag and drop a batch script onto libZip.bat, or call it via:
REM         libZip.bat yourScript.bat
REM   2) The script creates a "sketch" folder, copies the script and its
REM      dependencies, then bundles them into a single .zip.
REM ------------------------------------------------------------------------------

REM Validate argument: Must provide a file to process
if "%~1"=="" (
    echo [ERROR] No input file provided. Please drag and drop a script onto libZip.bat.
    pause
    exit /b 1
)

md sketch\lib

xcopy %~1 sketch

for /f "delims=" %%i in (%~1) do (

	set "line=%%~i"
	
	if /i "!line:~0,9!" equ "call lib\" (
	
		for /f "tokens=1 delims= " %%a in ("!line:~9!") do (
			set "current=%%~a"
			
			if /i "!current:~-4!" equ ".bat" (
				set "current=!current:~0,-4!"
			)
			
			xcopy lib\!current!.bat sketch\lib
			
			if /i "!current!" equ "sound" (
			
				md sketch\lib\sfx
				xcopy lib\sfx sketch\lib\sfx
				
			) else if /i "!current!" equ "cmdwiz" (
			
				if not exist sketch\lib\3rdparty md sketch\lib\3rdparty
				xcopy lib\3rdparty\cmdwiz.exe sketch\lib\3rdparty\cmdwiz.exe
				xcopy lib\mouseAndKeys.bat sketch\lib
				
			) else if /i "!current!" equ "radish" (
			
				if not exist sketch\lib\3rdparty md sketch\lib\3rdparty
				xcopy lib\3rdparty\radish.exe sketch\lib\3rdparty\radish.exe
				xcopy lib\mouseAndKeys.bat sketch\lib
				
			)
		)
	)
)

rem tar -cf "%~n1_[%random%].zip" "sketch"
powershell -NoProfile -Command ^
    "Compress-Archive -Path 'sketch' -DestinationPath '%~n1_[%random%].zip' -Force"

rmdir /s /q sketch
