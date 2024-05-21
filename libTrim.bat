@echo off & setlocal enableDelayedExpansion

if "%~1" equ "" exit /b

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
			if /i "!current:~0,6!" equ "stdlib" (
				if /i "!line:~-12!" equ "/multithread" (
					xcopy lib\readKey.bat sketch\lib
				)
			)
			xcopy lib\!current!.bat sketch\lib
			if /i "!current!" equ "sound" (
				md sketch\lib\sfx
				>nul xcopy lib\sfx sketch\lib\sfx
			)
			if /i "!current!" equ "cmdwiz" (
				md sketch\lib\cmdwiz
				xcopy lib\cmdwiz sketch\lib\cmdwiz
			)
		)
	)
)

if "%~2" neq "" (
	set "outputName=%~2.zip"
) else (
	set "outputName=newProject%random%.zip"
)

tar -cf "%outputName%" "sketch"

rmdir /s /q sketch