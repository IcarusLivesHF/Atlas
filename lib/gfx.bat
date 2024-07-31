rem get \e
for /f %%a in ('echo prompt $E^| cmd') do set "\e=%%a"

rem get \n
(set \n=^^^
%= This creates an escaped Line Feed - DO NOT ALTER =%
)
rem define @32bitlimit if we wasn't already
set "@32bitlimit=0x7FFFFFFF"

rem define a few buffers
for /l %%i in (0,1,80) do set "$s=!$s!!$s!  " & set "$q=!$q!!$q!qq"

rem natural dependencies for GFX below
set /a "PI=31416, HALF_PI=PI / 2, TAU=TWO_PI=2*PI, PI32=PI+HALF_PI, QUARTER_PI=PI / 4"
set "_SIN=a-a*a/1920*a/312500+a*a/1920*a/15625*a/15625*a/2560000-a*a/1875*a/15360*a/15625*a/15625*a/16000*a/44800000"
set "sin=(a=(x)%%62832, c=(a>>31|1)*a, a-=(((c-47125)>>31)+1)*((a>>31|1)*62832)  +  (-((c-47125)>>31))*( (((c-15709)>>31)+1)*(-(a>>31|1)*31416+2*a)  ), !_SIN!)"
set "cos=(a=(15708 - x)%%62832, c=(a>>31|1)*a, a-=(((c-47125)>>31)+1)*((a>>31|1)*62832)  +  (-((c-47125)>>31))*( (((c-15709)>>31)+1)*(-(a>>31|1)*31416+2*a)  ), !_SIN!)"
set "_sin="
set "sqrt=( M=(N),q=M/(11264)+40, q=(M/q+q)>>1, q=(M/q+q)>>1, q=(M/q+q)>>1, q=(M/q+q)>>1, q=(M/q+q)>>1, q+=(M-q*q)>>31 )"

REM maximum number of iterations: 16*16*16*16*16 = 1,048,576
Set "While=For /l %%i in (1 1 16)Do If Defined Do.While"
Set "While=Set Do.While=1&!While! !While! !While! !While! !While! "
Set "End.While=Set "Do.While=""

rem if hei/wid not defined, get dimensions now.
for /f "skip=2 tokens=2" %%a in ('mode') do (
		   if not defined hei (set /a "hei=height=%%a"
	) else if not defined wid  set /a "wid=width=%%a"
)

rem predefine angles for any given ellipse/circle to optimize performance of the macro
REM 32  points : step 1963         64  points : step 981         100 points : step 628
for /l %%i in (0,981,%tau%) do (
	set /a "ci=!cos:x=%%i!, so=!sin:x=%%i!"
	set "PRE=!PRE!"!ci! !so!" "
)

:_concat
rem %@concat% var var
set @concat=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-2" %%1 in ("^!args^!") do set "%%2=^!%%2^!^!%%~1^!" ) else set args=

:_point
rem %@point% y;x 2/5;0-255;0-255;0-255
set @point=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-2" %%1 in ("^!args^!") do (%\n%
	set "$point=^!$point^!%\e%[48;%%2m%\e%[%%1H %\e%[0m"%\n%
)) else set args=

:_ellipse
rem %@ellipse% x y ch cw color <rtn> $ellipse
set @ellipse=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-5" %%1 in ("^!args^!") do (%\n%
	if "%%~5" equ "" ( set "$ellipse=%\e%[48;5;15m" ) else ( set "$ellipse=%\e%[48;5;%%~5m" )%\n%
	for %%x in (%pre%) do for /f "tokens=1,2" %%x in ("%%~x") do (%\n%
		set /a "xa=%%~3 * %%~x/10000 + %%~1", "ya=%%~4 * %%~y/10000 + %%~2"%\n%
		set "$ellipse=^!$ellipse^!%\e%[^!ya^!;^!xa^!H "%\n%
	)%\n%
	set "$ellipse=^!$ellipse^!%\e%[0m"%\n%
)) else set args=

:_circle
rem %@circle% cx cy cr COLOR <rtn> !$circle!
set @circle=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-4" %%1 in ("^!args^!") do (%\n%
	if "%%~4" equ "" ( set "$circle=%\e%[48;5;15m" ) else ( set "$circle=%\e%[48;5;%%~4m" )%\n%
	set /a "$d=3 - 2 * %%~3, x=0, y=%%~3"%\n%
	^!While^! (%\n%
		set /a "a=%%~1 + x, b=%%~2 + y, c=%%~1 - x, d=%%~2 - y, e=%%~1 - y, f=%%~1 + y, g=%%~2 + x, h=%%~2 - x"%\n%
		set "$circle=^!$circle^!%\e%[^!b^!;^!a^!H %\e%[^!b^!;^!c^!H %\e%[^!d^!;^!a^!H %\e%[^!d^!;^!c^!H %\e%[^!g^!;^!f^!H %\e%[^!g^!;^!e^!H %\e%[^!h^!;^!f^!H %\e%[^!h^!;^!e^!H "%\n%
		if ^^!$d^^! leq 0 ( set /a "$d=$d + 4 * x + 6"%\n%
		) else set /a "y-=1", "$d=$d + 4 * (x - y) + 10"%\n%
		if ^^!x^^! GEQ ^^!y^^! ^!End.while^!%\n%
		set /a "x+=1"%\n%
	)%\n%
	set "$circle=^!$circle^!%\e%[0m"%\n%
)) else set args=

:_ball
rem %@ball:?=SIZE% <rtn> !$ball:x=COLOR!
set @ball=(%\n%
	set "s=?"%\n%
	if ^^!s^^! lss 3 set s=3%\n%
	for /l %%i in (1,1,^^!s^^!) do set ".=^!.^!."%\n%
	set "$ball=%\e%7^!.:~0,-2^!%\e%8%\e%[B%\e%[D"%\n%
	for /l %%i in (3,1,^^!s^^!) do set "$ball=^!$ball^!%\e%7^!.^!%\e%8%\e%[B"%\n%
	set "$ball=%\e%[48;5;xm^!$ball^!%\e%[C^!.:~0,-2^!%\e%[0m"%\n%
)

:_rect
rem %@rect% x y w h <rtn> !$rect!
set @rect=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-4" %%1 in ("^!args^!") do (%\n%
	set "$rect=^!$q:~0,%%4^!"%\n%
	set "$rect=%\e%[%%~2;%%~1H%\e%(0%\e%7l^!$q:~0,%%~3^!k%\e%8%\e%[B^!$rect:q=%\e%7x%\e%[%%3Cx%\e%8%\e%[B^!m^!$q:~0,%%~3^!j%\e%(B%\e%[0m"%\n%
)) else set args=

:_fillRect
rem %@fillRect% x y w h color <rtn> !$fillRect!
set @fillRect=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-5" %%1 in ("^!args^!") do (%\n%
    if "%%~5" neq "" ( set "$fillrect=%\e%[48;5;%%~5m" ) else set "$fillrect=%\e%[48;5;15m"%\n%
    set "$fillRect=^!$fillRect^!^!$s:~0,%%4^!"%\n%
	set "$fillrect=%\e%[%%~2;%%~1H^!$fillrect: =%\e%[%%3X%\e%[B^!%\e%[0m"%\n%
)) else set args=

:_roundRect
rem %@roundrect% x y w h r color <rtn> !$roundrect!
set @roundrect=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-6" %%1 in ("^!args^!") do (%\n%
    if "%%~6" neq "" ( set "$roundrect=%\e%[48;5;%%~6m" ) else set "$roundrect=%\e%[48;5;15m"%\n%
    set /a "$s1=%%~1 + %%~5,$t1=%%~1 + %%~3 - %%~5,$s2=%%~2 + %%~5,$t2=%%~2 + %%~4 - %%~5,$e1=%%~2 + %%~4,$e2=%%~1 + %%~3,$e=%%~5 * %%~5"%\n%
    for /l %%i in (^^!$s1^^!,1,^^!$t1^^!) do set "$roundrect=^!$roundrect^!%\e%[%%~2;%%~iH %\e%[^!$e1^!;%%~iH "%\n%
    for /l %%i in (^^!$s2^^!,1,^^!$t2^^!) do set "$roundrect=^!$roundrect^!%\e%[%%~i;%%~1H %\e%[%%~i;^!$e2^!H "%\n%
    for /l %%i in (1,1,%%~5) do (%\n%
		set /a "$i=%%i-1, dy=($e - $i*$i)/%%~5, $x1=$s1 - %%i,$y1=$s2 - dy,$x2=$t1 + %%i,$y2=$t2 + dy"%\n%
		set "$roundrect=^!$roundrect^!%\e%[^!$y1^!;^!$x1^!H %\e%[^!$y1^!;^!$x2^!H %\e%[^!$y2^!;^!$x1^!H %\e%[^!$y2^!;^!$x2^!H "%\n%
    )%\n%
    set "$roundrect=^!$roundrect^!%\e%[0m"%\n%
)) else set args=

:_line
rem %@line% x0 y0 x1 y1 color <rtn> $line
set @line=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-5" %%1 in ("^!args^!") do (%\n%
	if "%%~5" neq "" ( set "$line=%\e%[48;5;%%~5m" ) else set "$line=%\e%[48;5;15m"%\n%
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
set @bezier=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-9" %%a in ("^!args^!") do (%\n%
    if "%%~i" equ "" ( set "$bezier=%\e%[48;5;15m" ) else ( set "$bezier=%\e%[48;5;%%~im" )%\n%
    set /a "I=%%~c-%%~a","J=%%~e-%%~c","K=%%~g-%%~e","L=%%~d-%%~b","M=%%~f-%%~d"%\n%
	for /l %%. in (1,1,50) do (%\n%
		set /a "_=%%.<<1,N=((%%~a+_*I*10)/1000+%%~a),O=((%%~c+_*J*10)/1000+%%~c),P=((%%~b+_*L*10)/1000+%%~b),Q=((N+_*(O-N)*10)/1000+N),S=((%%~d+_*M*10)/1000+%%~d),T=((P+_*(S-P)*10)/1000+P),vx=(Q+_*(((O+_*(((%%~e+_*K*10)/1000+%%~e)-O)*10)/1000+O)-Q)*10)/1000+Q,vy=(T+_*(((S+_*(((%%~f+_*(%%~h-%%~f)*10)/1000+%%~f)-S)*10)/1000+S)-T)*10)/1000+T"%\n%
		set "$bezier=^!$bezier^!%\e%[^!vy^!;^!vx^!H "%\n%
	)%\n%
	set "$bezier=^!$bezier^!%\e%[0m"%\n%
)) else set args=