:turtleGraphics
rem bresenhams line algorithm. Used to draw lines moving "forward"
call :lineMacro

call lib\math
call lib\math_trig degrees

set "mirrored=y - x"

set /a "DFX=wid / 2",^
       "DFY=hei / 2",^
	   "DFA=0",^
	   "turtle.R=255",^
	   "turtle.G=255",^
	   "turtle.B=255"
set "penDown=false"
set "saved="

rem grab default size of screen - WID, WIDTH, HEI, HEIGHT
for /f "tokens=2 delims=: " %%i in ('mode') do ( 2>nul set /a "0/%%i" && ( 
	if defined hei (set /a "wid=width=%%i") else (set /a "hei=height=%%i")
))
mode %wid%,%hei%

rem name your turtle/macros
if "%~1" neq "" ( set "prefix=%~1" ) else ( set "prefix=turtle" )

:_turtle.move
rem %turtle.move% 10
set %prefix%.move=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1" %%1 in ("^!args^!") do (%\n%
	set /a "tDFX=(1+(%%~1)) * ^!cos:x=DFA^!/10000 + dfx", "tDFY=(1+(%%~1)) * ^!sin:x=DFA^!/10000 + dfy"%\n%
	if /i "^!penDown^!" equ "true" (%\n%
		if ^^!tdfx^^! gtr 1 if ^^!tdfx^^! lss ^^!wid^^! if ^^!tdfy^^! gtr 1 if ^^!tdfy^^! lss ^^!hei^^! (%\n%
		^!line^! ^^!dfx^^! ^^!dfy^^! ^^!tdfx^^! ^^!tdfy^^!%\n%
		echo ^^!$line^^!%\n%
	))%\n%
	set /a "dfx=tdfx", "dfy=tdfy"%\n%
)) else set args=

:_turtle.left
rem %turtle.left% 90
set %prefix%.left=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1" %%1 in ("^!args^!") do (%\n%
	set /a "DFA=(dfa - %%~1) %% 360"%\n%
)) else set args=

:_turtle.right
rem %turtle.right% 90
set %prefix%.right=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1" %%1 in ("^!args^!") do (%\n%
	set /a "DFA=(dfa + %%~1) %% 360"%\n%
)) else set args=

:_turtle.setx
rem %turtle.setx% 10
set %prefix%.setx=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1" %%1 in ("^!args^!") do (%\n%
	set /a "dfx=%%~1"%\n%
	if ^^!dfx^^! lss 0 ( set "dfx=0" ) else if ^^!dfx^^! gtr ^^!wid^^! set /a "dfx=wid"%\n%
)) else set args=

:_turtle.sety
rem %turtle.sety% 10
set %prefix%.sety=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1" %%1 in ("^!args^!") do (%\n%
	set /a "dfy=%%~1"%\n%
	if ^^!dfy^^! lss 0 ( set "dfy=0" ) else if ^^!dfy^^! gtr ^^!hei^^! set /a "dfy=hei"%\n%
)) else set args=

:_turtle.setHeading
rem %turtle.setHeading% 45
set %prefix%.setHeading=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1" %%1 in ("^!args^!") do (%\n%
	set /a "dfa=%%~1 %% 360"%\n%
)) else set args=

:_turtle.goto
rem %turtle.goto% x y - will draw line to location
set %prefix%.goto=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1,2" %%1 in ("^!args^!") do (%\n%
	if ^^!dfx^^! gtr 1 if ^^!dfx^^! lss ^^!wid^^! if ^^!dfy^^! gtr 1 if ^^!dfy^^! lss ^^!hei^^! (%\n%
		if %%~1 gtr 1 if %%~1 lss ^^!wid^^! if %%~2 gtr 1 if %%~2 lss ^^!hei^^! (%\n%
			^!line^! ^^!dfx^^! ^^!dfy^^! %%~1 %%~2%\n%
			echo ^^!$line^^!%\n%
	))%\n%
	set /a "dfx=%%~1", "dfy=%%~2"%\n%
)) else set args=

:_turtle.pointTo
rem %turtle.pointTo% x y - will point to location
set %prefix%.pointTo=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-2" %%1 in ("^!args^!") do (%\n%
	set /a "x=dfx - %%~1",^
	       "y=dfy - %%~2",^
		   "dfa=(I0=((~-x>>31)&1)&((~x>>31)&1), I0*(9000*((y>>31)-((-y)>>31)))+(1-I0)*(^!Atan:x=(1000*y)/(x+I0)^!+18000*(-(x>>31))*(1+2*(y>>31))) + 18000) / 100"%\n%
)) else set args=

:_turtle.getDist
rem %turtle.getDist% x y - returns !distance!
set %prefix%.getDist=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-2" %%1 in ("^!args^!") do (%\n%
	set /a "distance=(fx=dfx - %%~1, fy=dfy - %%~2, n=fx*fx + fy*fy, %sqrt%)"%\n%
)) else set args=

:_turtle.teleport
rem %turtle.teleport% x y - will NOT draw line to location
set %prefix%.teleport=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1,2" %%1 in ("^!args^!") do (%\n%
	set /a "dfx=%%~1", "dfy=%%~2"%\n%
	if ^^!dfx^^! lss 0 ( set "dfx=0" ) else if ^^!dfx^^! gtr ^^!wid^^! set /a "dfx=wid"%\n%
	if ^^!dfy^^! lss 0 ( set "dfy=0" ) else if ^^!dfy^^! gtr ^^!hei^^! set /a "dfy=hei"%\n%
)) else set args=

:_turtle.define
rem %turtle.define% x y heading - redefine turtle properties
set %prefix%.define=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-3" %%1 in ("^!args^!") do (%\n%
	set /a "dfx=%%~1", "dfy=%%~2", "dfa=%%~3 %% 360"%\n%
	if ^^!dfx^^! lss 0 ( set "dfx=0" ) else if ^^!dfx^^! gtr ^^!wid^^! set /a "dfx=wid"%\n%
	if ^^!dfy^^! lss 0 ( set "dfy=0" ) else if ^^!dfy^^! gtr ^^!hei^^! set /a "dfy=hei"%\n%
)) else set args=

:_turtle.circle
rem %turtle.circle% width height - draws ellipse at location
set %prefix%.circle=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1,2" %%1 in ("^!args^!") do (%\n%
	if "%%~2" neq "" ( set "cyd=%%~2" ) else set "cyd=%%~1"%\n%
	for /l %%i in (0,3,360) do (%\n%
		set /a "cx=%%~1 * ^!cos:x=%%i^!/10000 + dfx", "cy=cyd * ^!sin:x=%%i^!/10000 + dfy"%\n%
		if ^^!cx^^! gtr 0 if ^^!cx^^! lss ^^!wid^^! if ^^!cy^^! gtr 0 if ^^!cy^^! lss ^^!hei^^! (%\n%
			echo %\e%[48;2;^^!turtle.R^^!;^^!turtle.G^^!;^^!turtle.B^^!m %\e%[^^!cy^^!;^^!cx^^!H %\n%
		)%\n%
	)%\n%
)) else set args=

:_turtle.color
rem %turtle.color% R G B 38/48    - set turtle color
set %prefix%.color=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-4" %%1 in ("^!args^!") do (%\n%
	if "%%~1" neq "" set "turtle.R=%%~1"%\n%
	if "%%~2" neq "" set "turtle.G=%%~2"%\n%
	if "%%~3" neq "" set "turtle.B=%%~3"%\n%
	echo %\e%[%%~4;2;^^!turtle.R^^!;^^!turtle.G^^!;^^!turtle.B^^!m%\n%
)) else set args=

:_turtle.HSLtoRGB
rem %turtle.HSLtoRGB% HUE SAT LUM - set turtle color
set "HSL(n)=k=(n*100+(%%1 %% 3600)/3) %% 1200, x=k-300, y=900-k, x=y-((y-x)&((x-y)>>31)), x=100-((100-x)&((x-100)>>31)), max=x-((x+100)&((x+100)>>31))"
set %prefix%.HSLtoRGB=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-3" %%1 in ("^!args^!") do (%\n%
	set /a "%HSL(n):n=0%", "turtle.r=(%%3-(%%2*((10000-%%3)-(((10000-%%3)-%%3)&((%%3-(10000-%%3))>>31)))/10000)*max/100)*255/10000","%HSL(n):n=8%", "turtle.g=(%%3-(%%2*((10000-%%3)-(((10000-%%3)-%%3)&((%%3-(10000-%%3))>>31)))/10000)*max/100)*255/10000", "%HSL(n):n=4%", "turtle.b=(%%3-(%%2*((10000-%%3)-(((10000-%%3)-%%3)&((%%3-(10000-%%3))>>31)))/10000)*max/100)*255/10000"%\n%
)) else set args=
set "hsl(n)="

:_turtle.stamp
rem %turtle.stamp% - stamp screen with stamp.id
set %prefix%.stamp=(%\n%
	if ^^!dfx^^! gtr 0 if ^^!dfx^^! lss ^^!wid^^! if ^^!dfy^^! gtr 0 if ^^!dfy^^! lss ^^!hei^^! (%\n%
		set /a "stamp+=1" ^& echo %\e%[38;2;^!turtle.R^!;^!turtle.G^!;^!turtle.B^!m!%\e%[^!dfy^!;^!dfx^!H^!stamp^!%\n%
))

:_turtle.dot
rem %turtle.dot% - stamp screen with dot
set %prefix%.dot=(%\n%
	if ^^!dfx^^! gtr 0 if ^^!dfx^^! lss ^^!wid^^! if ^^!dfy^^! gtr 0 if ^^!dfy^^! lss ^^!hei^^! (%\n%
		echo %\e%[48;2;^^!turtle.R^^!;^^!turtle.G^^!;^^!turtle.B^^!m%\e%[^^!dfy^^!;^^!dfx^^!H %\n%
))

:_turtle.plot
rem %turtle.plot% - stamp screen with dot
set %prefix%.plot=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-2" %%1 in ("^!args^!") do (%\n%
	set "plotout=%\e%[38;2;^!turtle.R^!;^!turtle.G^!;^!turtle.B^!m%\e%[^!dfy^!;^!dfx^!H"%\n%
	       if /i "%%~1" equ "x" ( echo ^^!plotout^^!^^!dfx^^!%\n%
	) else if /i "%%~1" equ "y" ( echo ^^!plotout^^!^^!dfy^^!%\n%
	) else if /i "%%~1" equ "a" ( echo ^^!plotout^^!^^!dfa^^!%\n%
	)%\n%
)) else set args=

:_turtle.push
rem %turtle.push% save location and heading to array
set %prefix%.push=(set "saved=^!DFX^!,^!DFY^!,^!DFA^! ^!saved^!")

:_turtle.pop
rem %turtle.pop% return to saved location
set %prefix%.pop=(for /f "tokens=1-3 delims=, " %%x in ("^!saved^!") do (set /a "DFX=%%x, DFY=%%y, DFA=%%z") ^& set "saved=^!saved:* =^!")

:_turtle.home
REM %turtle.home% - send turtle to 0,0
set %prefix%.home=set /a "DFX=0, DFY=0, DFA=0"

:_turtle.center
REM %turtle.center% - send turtle to middle screen
set %prefix%.center=set /a "DFX=wid/2, DFY=hei/2, DFA=0"

:_turtle.penDown
REM %turtle.penDown% - begin draw
set "%prefix%.penDown=set penDown=true"

:_turtle.penUp
REM %turtle.penUp% - stop draw
set "%prefix%.penUp=set penDown=false"

:_turtle.clearScreen
REM %turtle.clearScreen% - clear screen
set "%prefix%.clearScreen=echo %\e%[2J%\e%[H"




goto :eof
:_______________________
:lineMacro bresenhams
rem line x0 y0 x1 y1 color
set line=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-5" %%1 in ("^!args^!") do (%\n%
	set "$line=[48;2;^!turtle.R^!;^!turtle.G^!;^!turtle.B^!m"%\n%
	set /a "$x0=%%~1,$y0=%%~2,$x1=%%~3,$y1=%%~4, dx=(((%%~3-%%~1)>>31|1)*(%%~3-%%~1)), dy=-($dy=(((%%~4-%%~2)>>31|1)*(%%~4-%%~2))), err=dx+dy, dist=dx, sx=-1, sy=-1"%\n%
	if ^^!dx^^! lss ^^!$dy^^! ( set dist=^^!$dy^^! )%\n%
	if ^^!$x0^^! lss ^^!$x1^^! ( set sx=1 )%\n%
	if ^^!$y0^^! lss ^^!$y1^^! ( set sy=1 )%\n%
	for /l %%i in (0,1,^^!dist^^!) do (%\n%
		set "$line=^!$line^!%\e%[^!$y0^!;^!$x0^!H "%\n%
		set /a "e2=err<<1"%\n%
		if ^^!e2^^! geq ^^!dy^^! ( set /a "err+=dy, $x0+=sx" )%\n%
		if ^^!e2^^! leq ^^!dx^^! ( set /a "err+=dx, $y0+=sy" )%\n%
	)%\n%
	set "$line=^!$line^!%\e%[0m"%\n%
)) else set args=

goto :eof