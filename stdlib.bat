
for /f "tokens=1 delims==" %%a in ('set') do (
	set "unload=true"
	for %%b in ( cd Path ComSpec SystemRoot temp windir ) do if /i "%%a"=="%%b" set "unload=false"
	if "!unload!"=="true" set "%%a="
)

set "@fullscreen=(title batchfs) ^& Mshta.exe vbscript:Execute("Set Ss=CreateObject(""WScript.Shell""):Ss.AppActivate ""batchfs"":Ss.SendKeys ""{F11}"":close")"

(set \n=^^^
%= This creates an escaped Line Feed - DO NOT ALTER =%
)

for /f "tokens=2 delims=: " %%i in ('mode') do ( 2>nul set /a "0/%%i" && ( 
	if defined hei (set /a "wid=width=%%i") else (set /a "hei=height=%%i")
))

for /f %%a in ('echo prompt $E^| cmd') do set "\e=%%a"

set  "\c=[2J"
set "\ch=[2J[H"

set "@32bitlimit=0x7FFFFFFF"

set /a "wid=width=%~1", "hei=height=%~2" 2>nul

mode %~1,%~2

<nul set /p "=[?25l"
exit /b