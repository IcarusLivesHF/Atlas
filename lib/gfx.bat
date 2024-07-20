rem get \e
for /f %%a in ('echo prompt $E^| cmd') do set "\e=%%a"

rem get \n
(set \n=^^^
%= This creates an escaped Line Feed - DO NOT ALTER =%
)
rem define @32bitlimit if we wasn't already
set "@32bitlimit=0x7FFFFFFF"

rem define a few buffers
for /l %%i in (0,1,5) do set "qBuffer=!qBuffer!!qBuffer!q"

rem natural dependencies for GFX below
set /a "PI=31416, HALF_PI=PI / 2, TAU=TWO_PI=2*PI, PI32=PI+HALF_PI, QUARTER_PI=PI / 4"
set "_SIN=a-a*a/1920*a/312500+a*a/1920*a/15625*a/15625*a/2560000-a*a/1875*a/15360*a/15625*a/15625*a/16000*a/44800000"
set "sin=(a=(x)%%62832, c=(a>>31|1)*a, a-=(((c-47125)>>31)+1)*((a>>31|1)*62832)  +  (-((c-47125)>>31))*( (((c-15709)>>31)+1)*(-(a>>31|1)*31416+2*a)  ), !_SIN!)"
set "cos=(a=(15708 - x)%%62832, c=(a>>31|1)*a, a-=(((c-47125)>>31)+1)*((a>>31|1)*62832)  +  (-((c-47125)>>31))*( (((c-15709)>>31)+1)*(-(a>>31|1)*31416+2*a)  ), !_SIN!)"
set "_sin="

REM maximum number of iterations: 16*16*16*16*16 = 1,048,576
Set "While=For /l %%i in (1 1 16)Do If Defined Do.While"
Set "While=Set Do.While=1&!While! !While! !While! !While! !While! "
Set "End.While=Set "Do.While=""

rem if hei/wid not defined, get dimensions now.
for /f "skip=2 tokens=2" %%a in ('mode') do if not defined hei (set /a "hei=height=%%a") else if not defined wid set /a "wid=width=%%a"

rem predefine angles for any given ellipse/circle to optimize performance of the macro
REM 32  points : step 1963         64  points : step 981         100 points : step 628
for /l %%i in (0,981,%tau%) do (
	set /a "ci=!cos:x=%%i!, so=!sin:x=%%i!"
	set "PRE=!PRE!"!ci! !so!" "
)

:_point
rem %@point% y;x 2/5;0-255;0-255;0-255
set @point=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-2" %%1 in ("^!args^!") do (%\n%
	set "$point=^!$point^!%\e%[48;%%2m%\e%[%%1H %\e%[0m"%\n%
)) else set args=

:_ellipse
rem %@ellipse% x y ch cw <rtn> $ellipse
set @ellipse=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-4" %%1 in ("^!args^!") do (%\n%
	set "$ellipse=%\e%[48;5;15m"%\n%
	for %%x in (%pre%) do for /f "tokens=1,2" %%x in ("%%~x") do (%\n%
		set /a "xa=%%~3 * %%~x/10000 + %%~1", "ya=%%~4 * %%~y/10000 + %%~2"%\n%
		set "$ellipse=^!$ellipse^!%\e%[^!ya^!;^!xa^!H "%\n%
	)%\n%
	set "$ellipse=^!$ellipse^!%\e%[0m"%\n%
)) else set args=

:_circle
rem %@circle% cx cy cr COLOR <rtn> !$circle!
set @circle=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-4" %%1 in ("^!args^!") do (%\n%
	if "%%~4" equ "" ( set "hue=15" ) else ( set "hue=%%~4")%\n%
	set "$circle=%\e%[48;5;^!hue^!m"%\n%
	set /a "$d=3 - 2 * %%~3, x=0, y=%%~3"%\n%
	^!While^! (%\n%
		set /a "a=%%~1 + x, b=%%~2 + y, c=%%~1 - x, d=%%~2 - y, e=%%~1 - y, f=%%~1 + y, g=%%~2 + x, h=%%~2 - x"%\n%
		set "$circle=^!$circle^!%\e%[^!b^!;^!a^!H "%\n%
		set "$circle=^!$circle^!%\e%[^!b^!;^!c^!H "%\n%
		set "$circle=^!$circle^!%\e%[^!d^!;^!a^!H "%\n%
		set "$circle=^!$circle^!%\e%[^!d^!;^!c^!H "%\n%
		set "$circle=^!$circle^!%\e%[^!g^!;^!f^!H "%\n%
		set "$circle=^!$circle^!%\e%[^!g^!;^!e^!H "%\n%
		set "$circle=^!$circle^!%\e%[^!h^!;^!f^!H "%\n%
		set "$circle=^!$circle^!%\e%[^!h^!;^!e^!H "%\n%
		if ^^!$d^^! leq 0 ( set /a "$d=$d + 4 * x + 6"%\n%
		)     else      set /a "y-=1", "$d=$d + 4 * (x - y) + 10"%\n%
		if ^^!x^^! GEQ ^^!y^^! ^!End.while^!%\n%
		set /a "x+=1"%\n%
	)%\n%
	set "$circle=^!$circle^!%\e%[0m"%\n%
)) else set args=

:_rect
rem %@rect% x y w h <rtn> $rect
set @rect=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-4" %%1 in ("^!args^!") do (%\n%
	set "$rect=%\e%[%%~2;%%~1H%\e%(0%\e%7l^!qBuffer:~0,%%~3^!k%\e%8%\e%[B"%\n%
	for /l %%i in (1,1,%%~4) do set "$rect=^!$rect^!%\e%7x%\e%[%%~3Cx%\e%8%\e%[B"%\n%
	set "$rect=^!$rect^!m^!qBuffer:~0,%%~3^!j%\e%(B%\e%[0m"%\n%
)) else set args=

:_line
rem %@line% x0 y0 x1 y1 color <rtn> $line
set @line=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-4" %%1 in ("^!args^!") do (%\n%
	set "$line=%\e%[48;5;15m"%\n%
	set /a "$x0=%%~1,$y0=%%~2,$x1=%%~3,$y1=%%~4, dx=(((%%~3-%%~1)>>31|1)*(%%~3-%%~1)), dy=-($dy=(((%%~4-%%~2)>>31|1)*(%%~4-%%~2))), err=dx+dy, dist=dx, sx=-1, sy=-1"%\n%
	if ^^!dx^^! lss ^^!$dy^^! ( set dist=^^!$dy^^! )%\n%
	if ^^!$x0^^! lss ^^!$x1^^! ( set sx=1 )%\n%
	if ^^!$y0^^! lss ^^!$y1^^! ( set sy=1 )%\n%
	for /l %%i in (0,1,^^!dist^^!) do (%\n%
		set "$line=^!$line^!%\e%[^!$y0^!;^!$x0^!H "%\n%
		set /a "e2=2 * err"%\n%
		if ^^!e2^^! geq ^^!dy^^! ( set /a "err+=dy, $x0+=sx" )%\n%
		if ^^!e2^^! leq ^^!dx^^! ( set /a "err+=dx, $y0+=sy" )%\n%
	)%\n%
	set "$line=^!$line^!%\e%[0m"%\n%
)) else set args=

:_bezier
rem %@bezier% x1 y1 x2 y2 x3 y3 x4 y4 color <rtn> !$bezier!
set @bezier=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-9" %%1 in ("^!args^!") do (%\n%
	if "%%~9" equ "" ( set "hue=15" ) else ( set "hue=%%~9")%\n%
    set "$bezier=%\e%[48;5;^!hue^!m"%\n%
    for /l %%. in (1,1,50) do (%\n%
        set /a "_=%%.<<1,N=((%%~1+_*(%%~3-%%~1)*10)/1000+%%~1),O=((%%~3+_*(%%~5-%%~3)*10)/1000+%%~3),P=((%%~2+_*(%%~4-%%~2)*10)/1000+%%~2),Q=((N+_*(O-N)*10)/1000+N),S=((%%~4+_*(%%~6-%%~4)*10)/1000+%%~4),T=((P+_*(S-P)*10)/1000+P),vx=(Q+_*(((O+_*(((%%~5+_*(%%~7-%%~5)*10)/1000+%%~5)-O)*10)/1000+O)-Q)*10)/1000+Q,vy=(T+_*(((S+_*(((%%~6+_*(%%~8-%%~6)*10)/1000+%%~6)-S)*10)/1000+S)-T)*10)/1000+T"%\n%
        set "$bezier=^!$bezier^!%\e%[^!vy^!;^!vx^!H "%\n%
    )%\n%
	set "$bezier=^!$bezier^!%\e%[0m"%\n%
)) else set args=