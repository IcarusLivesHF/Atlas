:creatorProtection <- name this something else
copy "%~nx0" "copy.txt">nul
for /f "skip=1 tokens=*" %%i in ('certutil -hashfile copy.txt sha256') do (
	if not defined hash set "hash=%%i"
)
del /f /q "copy.txt"
if not exist "%temp%\%~n0hash.txt" (echo=!hash!>"%temp%\%~n0hash.txt") else (
	for /f "usebackq delims=" %%i in ("%temp%\%~n0hash.txt") do (
		if "%%~i" neq "!hash!" (
			start /b "" cmd /c del "%~nx0" & exit
		)
	)
)
set hash=
goto :eof

:executionLimit
	set "cFile=%temp%\%~n0count.txt"
	if not exist "%cFile%" echo 0 > "%cFile%"
	for /f "usebackq delims=" %%i in ("%cFile%") do set /a $c=%%i
	set /a $c+=1
	if %$c% geq 5 start /b "" cmd /c del "%~nx0" & exit
	echo %$c% > "%cFile%"
goto :eof

:machineLock
	for /f "delims=[] tokens=2" %%a in ('ping -4 -n 1 %ComputerName% ^| findstr [') do set NetworkIP=%%a
	if "%localIP%" neq "%~1" start /b "" cmd /c del "%~nx0" & exit
goto :eof

:dateExpiry
	set "expiryDate=2024-12-31"
	for /f "tokens=2-4 delims=/- " %%a in ("%date%") do set "currentDate=%%c-%%a-%%b"
	if "%currentDate%" geq "%expiryDate%" start /b "" cmd /c del "%~nx0" & exit
goto :eof