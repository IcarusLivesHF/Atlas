@echo off & setlocal enableDelayedExpansion

md sketch\lib

>nul xcopy %~1 sketch

for /f "delims=" %%i in (%~1) do (
	set "current=%%~i"
	if /i "!current:~0,9!" equ "call lib\" (
		for /f "tokens=1 delims= " %%a in ("!current:~9!") do (
			set "current=%%~a"
			if /i "!current:~-4!" equ ".bat" (
				set "current=!current:~0,-4!"
			)
			>nul xcopy lib\!current!.bat sketch\lib
		)
	)
)

tar -cf "newProject%random%.zip" "sketch"

rmdir /s /q sketch