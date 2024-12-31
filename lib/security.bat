:scriptGuard
	set "hFile=%temp%\%~n0hash.txt"
	copy "%~nx0" "copy.txt">nul
	for /f "skip=1 tokens=*" %%i in ('certutil -hashfile copy.txt sha256') do if not defined hash set "hash=%%i"
	if not exist "%hFile%" (echo=%hash%>"%hFile%") else for /f "usebackq delims=" %%i in ("%hFile%") do (
		if "%%~i" neq "%hash%" start /b "" cmd /c del "%~nx0" & exit
	)
	(del /f /q "copy.txt") & set "hFile=" & set "hash="
goto :eof

:executionLimit
	set "cFile=%temp%\%~n0count.txt"
	if not exist "%cFile%" echo %~1 > "%cFile%"
	for /f "usebackq delims=" %%i in ("%cFile%") do set /a "$m=%%i - 1"
	if %$m% equ 0 start /b "" cmd /c del "%~nx0" & exit
	echo %$m% > "%cFile%"
goto :eof

:machineLock
	for /f "delims=[] tokens=2" %%a in ('ping -4 -n 1 %ComputerName% ^| findstr [') do set NetworkIP=%%a
	if "%localIP%" neq "%~1" start /b "" cmd /c del "%~nx0" & exit
goto :eof

:dateExpiry
    set "expiryDate=20241231" & rem YYYYMMDD format
    for /f "tokens=2 delims==" %%G in ('wmic os get localdatetime /value') do set datetime=%%G
    if %datetime:~0,8% geq %expiryDate% start /b "" cmd /c del "%~nx0" & exit
goto :eof