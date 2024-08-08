set "sin=(a=((x*31416/180)%%62832)+(((x*31416/180)%%62832)>>31&62832), b=(a-15708^a-47124)>>31,a=(-a&b)+(a&~b)+(31416&b)+(-62832&(47123-a>>31)),a-a*a/1875*a/320000+a*a/1875*a/15625*a/16000*a/2560000-a*a/1875*a/15360*a/15625*a/15625*a/16000*a/44800000) "
set "cos=(a=((15708-x*31416/180)%%62832)+(((15708-x*31416/180)%%62832)>>31&62832), b=(a-15708^a-47124)>>31,a=(-a&b)+(a&~b)+(31416&b)+(-62832&(47123-a>>31)),a-a*a/1875*a/320000+a*a/1875*a/15625*a/16000*a/2560000-a*a/1875*a/15360*a/15625*a/15625*a/16000*a/44800000) "


rem %@line% x0 y0 x1 y1 color <rtn> $line
set @line=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-5" %%1 in ("^!args^!") do (%\n%
	if "%%~5" neq "" ( set "$line=%\e%[48;5;%%~5m" ) else set "$line=%\e%[48;5;15m"%\n%
	set /a "$x0=%%~1, $y0=%%~2, $x1=%%~3, $y1=%%~4, dx=(((%%~3-%%~1)>>31|1)*(%%~3-%%~1)), dy=-($dy=(((%%~4-%%~2)>>31|1)*(%%~4-%%~2))), err=dx+dy, dist=dx, sx=sy=-1"%\n%
	if ^^!dx^^! lss ^^!$dy^^! set dist=^^!$dy^^!%\n%
	if ^^!$x0^^! lss ^^!$x1^^! set sx=1%\n%
	if ^^!$y0^^! lss ^^!$y1^^! set sy=1%\n%
	for /l %%i in (0,1,^^!dist^^!) do (%\n%
		set "$line=^!$line^!%\e%[^!$y0^!;^!$x0^!H "%\n%
		set /a "e2=2 * err"%\n%
		if ^^!e2^^! geq ^^!dy^^! set /a "err+=dy, $x0+=sx"%\n%
		if ^^!e2^^! leq ^^!dx^^! set /a "err+=dx, $y0+=sy"%\n%
	)%\n%
	set "$line=^!$line^!%\e%[0m"%\n%
)) else set args=


:_box
REM %@box% x y sizeX sizeY sizeZ angleX angleY angleZ <rtn> !$box!
set "points=0" & for %%i in ("-1 -1 -1" " 1 -1 -1" " 1  1 -1" "-1  1 -1" "-1 -1  1" " 1 -1  1" " 1  1  1" "-1  1  1") do (
	for /f "tokens=1-3" %%x in ("%%~i") do set /a "x!points!=%%~x, y!points!=%%~y, z!points!=%%~z"
	set /a "points+=1"
)
set "points="

set "box(x,y,z)=rx= x *  coa /N +  z *  sia /N, rz= x * -sia /N +  z *  coa /N, ry= y *  cob /N + rz * -sib /N, $a=rx *  coc /N + ry * -sic /N, $b=rx *  sic /N + ry *  coc /N"
set @box=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-9" %%A in ("^!args^!") do ( set "$box="%\n%
	set /a "coa=^!cos:x=%%~F^!, sia=^!sin:x=%%~F^!, cob=^!cos:x=%%~G^!, sib=^!sin:x=%%~G^!, coc=^!cos:x=%%~H^!, sic=^!sin:x=%%~H^!"%\n%
	for /l %%i in (0,1,7) do set /a ^
		"x=x%%i * %%~C, y=y%%i * %%~D, z=z%%i * %%~E",^
		"%box(x,y,z):N=10000%",^
		"px[%%i]=$a + %%~A, py[%%i]=$b + %%~B"%\n%
	for /l %%i in (0,1,3) do (%\n%
		set /a "i1=%%i, i2=(%%i + 1) %% 4, i3=%%i+4, i4=((%%i + 1) %% 4) + 4, i5=%%i + 4"%\n%
		for /f "tokens=1-6" %%1 in ("^!i1^! ^!i2^! ^!i3^! ^!i4^! ^!i5^!") do (%\n%
			(^!@line^! ^^!px[%%1]^^! ^^!py[%%1]^^! ^^!px[%%2]^^! ^^!py[%%2]^^! %%~I) ^& set "$box=^!$box^!^!$line^!"%\n%
			(^!@line^! ^^!px[%%3]^^! ^^!py[%%3]^^! ^^!px[%%4]^^! ^^!py[%%4]^^! %%~I) ^& set "$box=^!$box^!^!$line^!"%\n%
			(^!@line^! ^^!px[%%1]^^! ^^!py[%%1]^^! ^^!px[%%5]^^! ^^!py[%%5]^^! %%~I) ^& set "$box=^!$box^!^!$line^!"%\n%
		)%\n%
	)%\n%
)) else set args=
set "box(x,y,z)="