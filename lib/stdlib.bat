for /f "tokens=1 delims==" %%a in ('set') do (
	set "unload=true"
	for %%b in (cd Path ComSpec SystemRoot temp windir) do (
		if /i "%%a"=="%%b" set "unload=false"
	)
	if "!unload!"=="true" set "%%a="
)
set "unload="

rem define a few buffers for other libraries
for /l %%i in (0,1,80) do set "$s=!$s!!$s!  " & set "$q=!$q!!$q!qq"

(set \n=^^^
%= This creates an escaped Line Feed - DO NOT ALTER       \n =%
)
for /f %%a in ('echo prompt $E^| cmd') do set "\e=%%a" %= \e =%
(echo %\e%[?25l) &                                     %= hide cursor =%

set /a "@32bitlimit=(1<<31)-1" & rem 2147483647   or   0x7FFFFFFF

for /f "skip=2 tokens=2" %%a in ('mode') do (
		   if not defined hei ( set /a "hei=height=%%a"
	) else if not defined wid   set /a "wid=width=%%a"
)

if "%~2" neq "" (
	set /a "wid=width=%~1", "hei=height=%~2 - 1"
	mode %~1,%~2
) 2>nul

chcp 65001>nul
exit /b
