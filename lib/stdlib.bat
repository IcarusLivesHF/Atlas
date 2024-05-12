for /f "tokens=1 delims==" %%a in ('set') do (
	set "unload=true"
	for %%b in (cd Path ComSpec SystemRoot temp windir) do if /i "%%a"=="%%b" set "unload=false"
	if "!unload!"=="true" set "%%a="
)
set "unload="

(set \n=^^^
%= This creates an escaped Line Feed - DO NOT ALTER       \n =%
)
for /f %%a in ('echo prompt $E^| cmd') do set "\e=%%a" %= \e =%
set "\c=[2J"                                           %= \c =%
set "\h=[2J[H"                                         %= \h =%

<nul set /p "=%\e%[?25l"     & rem hide cursor

set "@32bitlimit=0x7FFFFFFF" & rem 2147483647 or (1 << 31) - 1 or 0x7FFFFFFF

set "@fullScreen=(title batchfs) ^& Mshta.exe vbscript:Execute("Set Ss=CreateObject(""WScript.Shell""):Ss.AppActivate ""batchfs"":Ss.SendKeys ""{F11}"":close")"

set "@resetDim=set "wid=" & set "hei=" & set "width=" & set "height=""

set "@getDim=for /f "skip=2 tokens=2" %%a in ('mode') do (if not defined hei (set /a "hei=height=%%a") else if not defined wid (set /a "wid=width=%%a"))"

if "%~3" neq "" %@fullscreen%
%@getDim%
if "%~1" neq "" if "%~3" equ "" (
	set /a "wid=width=%~1", "hei=height=%~2"
	mode %~1,%~2
) 2>nul
exit /b