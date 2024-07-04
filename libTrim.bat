@echo off & setlocal enableDelayedExpansion

if "%~1" equ "" ( echo Please drag and drop script into libTrim.bat & pause & exit /b )

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
			
			if /i "!current:~0,6!" equ "stdlib" (
				if /i "!line:~-12!" equ "/multithread" (
					xcopy lib\readKey.bat sketch\lib
				)
			)
			if /i "!current!" equ "sound" (
				md sketch\lib\sfx
				xcopy lib\sfx sketch\lib\sfx
			) else if /i "!current!" equ "cmdwiz" (
				md sketch\lib\cmdwiz
				xcopy lib\cmdwiz sketch\lib\cmdwiz
			)
		)
	)
)

tar -cf "%~n1_[%random%].zip" "sketch"

rmdir /s /q sketch

echo done!
pause
