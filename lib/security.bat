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

:instanceCheck
	set "title=%~1" & set "title=!title: =_!"
	for /f "tokens=10" %%A in ('tasklist /v /fi "imagename eq cmd.exe" ^| findstr /i "%title%"') do if "%%~A" equ "%title%" (
		for /f "usebackq delims=" %%i in ("%temp%\instanceCheck.txt") do set /a "cooldown=!time:~-5,-3! - %%~i"
		if !cooldown! lss %~2 ( exit ) else ( del /f /q "%temp%\instanceCheck.txt" )
	)
	title %title%
	echo %time:~-5,-3%>"%temp%\instanceCheck.txt"
goto :eof

:timeWindow
set "startTime=09:00"
set "endTime=17:00"

set "currentTime=%time:~0,5%"
if "%currentTime%" lss "%startTime%" (
    echo [ERROR] Outside allowed time window. Exiting.
    timout /t 2 >nul & exit
) else if "%currentTime%" geq "%endTime%" (
    echo [ERROR] Outside allowed time window. Exiting.
    timout /t 2 >nul & exit
)
goto :eof