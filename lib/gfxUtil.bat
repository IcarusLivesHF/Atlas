rem get \e
for /f %%a in ('echo prompt $E^| cmd') do set "\e=%%a"
rem get \n
(set \n=^^^
%= This creates an escaped Line Feed - DO NOT ALTER =%
)
rem define @32bitlimit if we wasn't already
set "@32bitlimit=0x7FFFFFFF"

:_@getDim
rem %@getDim% - get current dimensions of window
set  @getDim=(%\n%
	set "wid=" ^& set "hei=" ^& set "width=" ^& set "height="%\n%
	for /f "skip=2 tokens=2" %%a in ('mode') do if not defined hei (set /a "hei=height=%%a") else if not defined wid set /a "wid=width=%%a"%\n%
)

:_delay
REM %@delay:x=10%
set "@delay=for /l %%# in (1,x,1000000) do rem"

:_background
REM %@background% color1 color2 lineColor2Starts
set @background=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-3" %%1 in ("^!args^!") do (%\n%
	set "$background=%\e%[48;5;%%~1m%\e%[0J%\e%[%%~3H%\e%[48;5;%%~2m%\e%[0J"%\n%
)) else set args=

:_fullscreen
rem %@fullscreen%
set "@fullScreen=(title batchfs) ^& Mshta.exe vbscript:Execute("Set Ss=CreateObject(""WScript.Shell""):Ss.AppActivate ""batchfs"":Ss.SendKeys ""{F11}"":close") ^& !@getdim!"

:_HSL.RGB
rem %HSL.RGB% 0-3600 0-10000 0-10000 <rtn> r g b
set "HSL(n)=k=(n*100+(%%1 %% 3600)/3) %% 1200, x=k-300, y=900-k, x=y-((y-x)&((x-y)>>31)), x=100-((100-x)&((x-100)>>31)), max=x-((x+100)&((x+100)>>31))"
set @HSL.RGB=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-3" %%1 in ("^!args^!") do (%\n%
	set /a "%HSL(n):n=0%", "r=(%%3-(%%2*((10000-%%3)-(((10000-%%3)-%%3)&((%%3-(10000-%%3))>>31)))/10000)*max/100)*255/10000","%HSL(n):n=8%", "g=(%%3-(%%2*((10000-%%3)-(((10000-%%3)-%%3)&((%%3-(10000-%%3))>>31)))/10000)*max/100)*255/10000", "%HSL(n):n=4%", "b=(%%3-(%%2*((10000-%%3)-(((10000-%%3)-%%3)&((%%3-(10000-%%3))>>31)))/10000)*max/100)*255/10000"%\n%
)) else set args=
set "hsl(n)="

:_fps
rem %@fps% <rtn> deltaTime, FPS, $TT, $min, $sec, frameCount
set @fps=(%\n%
	for /f "tokens=1-4 delims=:.," %%a in ("^!time: =0^!") do set /a "t1=((((10%%a-1000)*60+(10%%b-1000))*60+(10%%c-1000))*100)+(10%%d-1000)"%\n%
	if defined t2 set /a "deltaTime=(t1 - t2)","$TT+=deltaTime","fps=60 * (1000 / (deltaTime + 1)) / 1000","$sec=$TT / 100 %% 60","$min=$TT / 100 / 60 %% 60","frameCount=(frameCount + 1) %% @32bitlimit"%\n%
	set /a "t2=t1"%\n%
	if "^!$sec:~1^!" equ "" set "$sec=0^!$sec^!"%\n%
	title FPS:^^!fps^^! Time: ^^!$min^^!:^^!$sec^^! Frames: ^^!frameCount^^!/^^!$TT^^!%\n%
)

:_timeStamp
rem %@timestamp% var
set @timeStamp=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-2" %%1 in ("^!args^!") do (%\n%
	for /f "tokens=1-4 delims=:.," %%a in ("^!time: =0^!") do set /a "%%~1=((((10%%a-1000)*60+(10%%b-1000))*60+(10%%c-1000))*100)+(10%%d-1000)"%\n%
)) else set args=