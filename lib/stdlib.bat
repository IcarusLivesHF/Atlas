for /f "tokens=1 delims==" %%a in ('set') do (
	set "unload=true"
	for %%b in (cd Path ComSpec SystemRoot temp windir) do if /i "%%a"=="%%b" set "unload=false"
	if "!unload!"=="true" set "%%a="
)
set "unload="

rem \n
(set \n=^^^
%= This creates an escaped Line Feed - DO NOT ALTER =%
)
rem \e char
for /f %%a in ('echo prompt $E^| cmd') do set "\e=%%a"
rem \c
set "\c=[2J"
rem \h
set "\h=[2J[H"

set "@32bitlimit=0x7FFFFFFF"

set "@fullScreen=(title batchfs) ^& Mshta.exe vbscript:Execute("Set Ss=CreateObject(""WScript.Shell""):Ss.AppActivate ""batchfs"":Ss.SendKeys ""{F11}"":close")"

set "@resetDimensions=set "wid=" & set "hei=" & set "width=" & set "height=""

set "@getDimensions=for /f "skip=2 tokens=2" %%a in ('mode') do (if not defined wid (set /a "wid=width=%%a") else if not defined hei (set /a "hei=height=%%a"))"

if "%~3" neq "" %@fullscreen%

%@getDimensions%

if "%~1" neq "" if "%~3" equ "" (
	set /a "wid=width=%~1", "hei=height=%~2" 2>nul
	mode %~1,%~2
)

rem hide cursor
<nul set /p "=[?25l"
exit /b

REM FEATURES:
	REM empty environment of all variables except essentials.
	REM hides cursor
	REM sets size of window
	REM @fullscreen MACRO
	REM @resetDimensions MACRO
	REM @getDimensions MACRO
	REM @32bitlimit VALUE
	REM wid, width, hei, height VALUES
	REM \n = newLine
	REM \e = esc
	REM \c = cls
	REM \h = cls + move cursor back to 0,0