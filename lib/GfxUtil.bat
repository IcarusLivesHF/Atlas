:_@getDim
rem %@getDim% - get current dimensions of window
set  @getDim=(%\n%
	set "wid=" ^& set "hei=" ^& set "width=" ^& set "height="%\n%
	for /f "skip=2 tokens=2" %%a in ('mode') do if not defined hei (set /a "hei=height=%%a") else if not defined wid set /a "wid=width=%%a"%\n%
)

:_timestamp
rem %timestamp:?=t1% set /a "dt=t2-t1"
set @timestamp=for /f "tokens=1-4 delims=:.," %%a in ("^!time: =0^!") do set /a "?=(((1%%a*60)+1%%b)*60+1%%c)*100+1%%d-36610100"


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

:_fps
rem %@fps% <rtn> deltaTime, FPS, $TT, $min, $sec, frameCount
set @fps=(%\n%
	for /f "tokens=1-4 delims=:.," %%a in ("^!time: =0^!") do set /a "t1=((((10%%a-1000)*60+(10%%b-1000))*60+(10%%c-1000))*100)+(10%%d-1000)"%\n%
	if defined t2 set /a "deltaTime=(t1 - t2)","$TT+=deltaTime","fps=60 * (1000 / (deltaTime + 1)) / 1000","$sec=$TT / 100 %% 60","$min=$TT / 100 / 60 %% 60","frameCount=(frameCount + 1) %% @32bitlimit"%\n%
	set /a "t2=t1"%\n%
	if "^!$sec:~1^!" equ "" set "$sec=0^!$sec^!"%\n%
	title FPS:^^!fps^^! Time: ^^!$min^^!:^^!$sec^^! Frames: ^^!frameCount^^!/^^!$TT^^!%\n%
)