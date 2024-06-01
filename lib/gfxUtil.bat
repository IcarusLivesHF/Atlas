rem get \e
for /f %%a in ('echo prompt $E^| cmd') do set "\e=%%a"
rem get \n
(set \n=^^^
%= This creates an escaped Line Feed - DO NOT ALTER =%
)
rem define @32bitlimit if we wasn't already
set "@32bitlimit=0x7FFFFFFF"

for /f "skip=2 tokens=2" %%a in ('mode') do if not defined hei (set /a "hei=height=%%a") else if not defined wid set /a "wid=width=%%a"

:_loop
REM %loop% 65536 times - define STOP to break
For /l %%i in (1 1 4)Do Set "loop=!Loop!For /l %%# in (1 1 16)Do if not defined Stop "

:_delay
REM %@delay:x=10%
set "@delay=for /l %%# in (1,x,1000000) do rem"

:_concat
rem %concat% x y "string" outputVar / %concat% "string" outputVar
set @concat=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-4" %%1 in ("^!args^!") do (%\n%
	if "%~3" neq "" ( set "%%~4=^!%%~4^!%\e%[%%~2;%%~1H%%~3" ) else set "%%~2=^!%%~2^!%%~1"%\n%
)) else set args=

:_background
REM %@background% color1 color2 lineColor2Starts
set @background=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-3" %%1 in ("^!args^!") do (%\n%
	set "$background=%\e%[48;5;%%~1m%\e%[0J%\e%[%%~3H%\e%[48;5;%%~2m%\e%[0J"%\n%
)) else set args=

:_fullscreen
rem %@fullscreen%
set "@fullScreen=(title batchfs) ^& Mshta.exe vbscript:Execute("Set Ss=CreateObject(""WScript.Shell""):Ss.AppActivate ""batchfs"":Ss.SendKeys ""{F11}"":close") ^& !@getdim!"

:_construct
rem %%~1:NAME %%~2:end/optional %%~3:ID/optional <rtn> %%~1[n].ATTRIBUTES
set @construct=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-3" %%1 in ("^!args^!") do (%\n%
	if /i "%%~2" neq "purge" (%\n%
		if not defined %%~1.length set /a "%%~1.length=-1"%\n%
		set /a "%%~1.length+=1"%\n%
		set "%%~1.list=^!%%~1.list^!^!%%~1.length^! "%\n%
		for %%j in (^^!%%~1.length^^!) do (%\n%
			set /a "%%~1[%%j].x=^!random^! %% wid"%\n%
			set /a "%%~1[%%j].y=^!random^! %% hei"%\n%
			set /a "%%~1[%%j].deg=^!random^! %% 360"%\n%
			set /a "%%~1[%%j].mag=^!random^! %% 2 + 1"%\n%
			set /a "%%~1[%%j].i=(^!random^! %% 2 * 2 - 1) * %%~1[%%j].mag"%\n%
			set /a "%%~1[%%j].j=(^!random^! %% 2 * 2 - 1) * %%~1[%%j].mag"%\n%
		)%\n%
	) else (%\n%
		if "%%~3" equ "" (%\n%
			for %%j in (^^!%%~1.length^^!) do (%\n%
				for /l %%k in (0,1,%%j) do (%\n%
					for %%i in (x y i j deg mag) do set "%%~1[%%k].%%i="%\n%
				)%\n%
				set "%%~1.length="%\n%
				set "%%~1.list="%\n%
			)%\n%
		) else (%\n%
			if "^!%%~1.list^!" neq "^!%%~1.list:%%~3 =^!" (%\n%
				set "%%~1.list=^!%%~1.list:%%~3 =^!"%\n%
				for %%i in (x y i j deg mag) do set "%%~1[%%~3].%%i="%\n%
				set /a "%%~1.length-=1"%\n%
			)%\n%
		)%\n%
	)%\n%
)) else set args=

:_getDistance
rem %getDistance% x2 x1 y2 y1 <rtnVar>
set @getDistance=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-5" %%1 in ("^!args^!") do (%\n%
	set /a "%%5=( ?=((((((%%1 - %%2))>>31|1)*((%%1 - %%2)))-((((%%3 - %%4))>>31|1)*((%%3 - %%4))))>>31)+1, ?*(2*((((%%1 - %%2))>>31|1)*((%%1 - %%2)))-((((%%3 - %%4))>>31|1)*((%%3 - %%4)))-(((((%%1 - %%2))>>31|1)*((%%1 - %%2)))-((((%%3 - %%4))>>31|1)*((%%3 - %%4))))) + ^^^!?*(((((%%1 - %%2))>>31|1)*((%%1 - %%2)))-((((%%3 - %%4))>>31|1)*((%%3 - %%4)))-(((((%%1 - %%2))>>31|1)*((%%1 - %%2)))-((((%%3 - %%4))>>31|1)*((%%3 - %%4)))*2)) )"%\n%
)) else set args=

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