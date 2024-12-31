:_bar
rem %@bar% currentValue maxValue MaxlengthOfBar
set @Bar=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-3" %%1 in ("^!args^!") do (%\n%
	set /a "bv=%%~3*%%~1/%%~2, ot=%%~2 / 3, tt=ot * 2, inv=%%~3 - bv - 1, hue=46, percent=100 * total/bytes"%\n%
	if %%~1 lss ^^!ot^^! ( set "hue=196" ) else if %%~1 gtr ^^!ot^^! if %%~1 lss ^^!tt^^! ( set "hue=226" )%\n%
	for /f "tokens=1-3" %%a in ("^!bv^! ^!hue^! ^!inv^!") do set "$bar=[%\e%[48;5;%%~bm^!$s:~0,%%~a^!%\e%[0m%\e%[%%~cC] %%~1/%%~2 ^!percent^!%%%\e%[0m"%\n%
)) else set args=

:_sevenSegmentDisplay
rem %@sevenSegmentDisplay% x y value color <rtn> $sevenSegmentDisplay
set /a "segbool[0]=0x7E", "segbool[1]=0x30", "segbool[2]=0x6D", "segbool[3]=0x79", "segbool[4]=0x33", "segbool[5]=0x5B", "segbool[6]=0x5F", "segbool[7]=0x70", "segbool[8]=0x7F", "segbool[9]=0x7B"
set @sevenSegmentDisplay=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-4" %%1 in ("^!args^!") do (%\n%
	set "$sevenSegmentDisplay="%\n%
	set /a "qx1=%%~1", "qx2=%%~1 + 1", "qx3=%%~1 + 2", "qx4=%%~1 - 1", "qy1=%%~2", "qy2=%%~2 + 1", "qy3=%%~2 + 2", "qy4=%%~2 + 3", "qy5=%%~2 + 4", "qy6=%%~2 + 5", "qy7=%%~2 + 6"%\n%
	for %%j in ( "6 1 1 2 1" "5 3 2 3 3" "4 3 5 3 6" "3 1 7 2 7" "2 4 5 4 6" "1 4 2 4 3" "0 1 4 2 4" ) do (%\n%
		for /f "tokens=1-5" %%v in ("%%~j") do (%\n%
			set /a "a=%%~4 * ((segbool[%%~3] >> %%~v) & 1)"%\n%
			set "$sevenSegmentDisplay=^!$sevenSegmentDisplay^!%\e%[48;5;^!a^!m%\e%[^!qy%%x^!;^!qx%%w^!H %\e%[^!qy%%z^!;^!qx%%y^!H "%\n%
		)%\n%
	)%\n%
)) else set args=

:_msgBox
rem %@msgBox% ;title;text;x;y;textColor;boxColor;boxLength
set @msgBox=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-7 delims=;" %%1 in ("^!args:~1^!") do (%\n%
	if "%%~5" neq "" ( set "t.color=%%~5" ) else ( set "t.color=15" )%\n%
	if "%%~6" neq "" ( set "box.color=%%~6" ) else ( set "box.color=15" )%\n%
	if "%%~7" neq "" ( set "msgBox.length=%%~7" ) else ( set "msgBox.length=60" )%\n%
	set "str=X%%~2"%\n%
	set "str=^!str:?=^!" ^& set "length=0" ^& for /l %%b in (10,-1,0) do set /a "length|=1<<%%b" ^& for %%c in (^^!length^^!) do if "^!str:~%%c,1^!" equ "" set /a "length&=~1<<%%b"%\n%
	set /a "msgBox.height=length / msgBox.length + 4", "msgBox.width=msgBox.length - 2"%\n%
	for /f "tokens=1-3" %%a in ("^!msgBox.width^! ^!msgBox.length^! ^!msgBox.height^!") do (%\n%
		set "$msgBox=%\e%[38;5;^!box.color^!m%\e%[%%~4;%%~3HÚ%\e%(0^!$q:~0,%%~a^!%\e%(B¿%\e%[%%~bD%\e%[B³%\e%[%%~aC³%\e%[%%~bD%\e%[BÃ%\e%(0^!$q:~0,%%~a^!%\e%(B´%\e%[%%~bD%\e%[B"%\n%
		for /l %%i in (0,1,%%~c) do set "$msgBox=^!$msgBox^!³%\e%[%%~aC³%\e%[%%~bD%\e%[B"%\n%
		set "$msgBox=^!$msgBox^!À%\e%(0^!$q:~0,%%~a^!%\e%(BÙ%\e%[0m"%\n%
	)%\n%
	set "str=^!str:=?^!"%\n%
	set /a "textx=%%~3 + 2", "texty=%%~4 + 1", "msgBox.width-=2"%\n%
	set "$msgBox=^!$msgBox^!%\e%[38;5;^!t.color^!m%\e%[^!texty^!;^!textx^!H%%~1%\e%[^!texty^!;^!textx^!H%\e%[3B"%\n%
	for /f "tokens=1,2" %%a in ("^!msgBox.width^! ^!msgBox.length^!") do (%\n%
		for /l %%i in (1,%%~a,^^!length^^!) do (%\n%
			set "$msgBox=^!$msgBox^!^!str:~%%~i,%%~a^!%\e%[%%~aD%\e%[B"%\n%
		)%\n%
	)%\n%
	set "$msgBox=^!$msgBox^!%\e%[0m%\e%[E"%\n%
	for %%i in (textx texty str box.color msgbox.height msgbox.width msgbox.length) do set "%%i="%\n%
)) else set args=

rem MUST CALL lib\math radians
:_arc
rem %@arc% x y size DEGREES(0-360) arcRotationDegrees(0-360) lineThinness color
set @arc=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-7" %%1 in ("^!args^!") do (%\n%
	set "$arc=%\e%[48;5;15m"%\n%
    for /l %%e in (%%~4,%%~6,%%~5) do (%\n%
		set /a "_x=%%~3 * ^!cos:x=%%e^!/10000 + %%~1", "_y=%%~3 * ^!sin:x=%%e^!/10000 + %%~2"%\n%
		set "$arc=^!$arc^!%\e%[^!_y^!;^!_x^!H "%\n%
	)%\n%
	set "$arc=^!$arc^!%\e%[0m"%\n%
)) else set args=

rem MUST CALL lib\gfxline to obtain %@line% first
:_triangle
rem %@triangle% x0 y0 x1 y1 x2 y2 <rtn> !$triangle!
set @triangle=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-6" %%1 in ("^!args^!") do (%\n%
	set "$triangle="%\n%
	^!@line^! %%~1 %%~2 %%~3 %%~4%\n%
	set "$triangle=^!$triangle^!^!$line^!"%\n%
	^!@line^! %%~1 %%~2 %%~5 %%~6%\n%
	set "$triangle=^!$triangle^!^!$line^!"%\n%
	^!@line^! %%~3 %%~4 %%~5 %%~6%\n%
	set "$triangle=^!$triangle^!^!$line^!%\e%[0m"%\n%
)) else set args=

rem MUST CALL lib\gfxline to obtain %@line% first
:_quad
rem %@quad% x0 y0 x1 y1 x2 y2 <rtn> !$quad!
set @quad=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-8" %%1 in ("^!args^!") do (%\n%
	set "$quad="%\n%
	^!@line^! %%~1 %%~2 %%~3 %%~4%\n%
	set "$quad=^!$quad^!^!$line^!"%\n%
	^!@line^! %%~1 %%~2 %%~5 %%~6%\n%
	set "$quad=^!$quad^!^!$line^!"%\n%
	^!@line^! %%~3 %%~4 %%~7 %%~8%\n%
	set "$quad=^!$quad^!^!$line^!"%\n%
	^!@line^! %%~5 %%~6 %%~7 %%~8%\n%
	set "$quad=^!$quad^!^!$line^!%\e%[0m"%\n%
)) else set args=

:_AAline
rem %@AAline% x0 x1 y0 y1 <rtn> !$AAline!
set @AAline=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-4" %%1 in ("^!args^!") do (%\n%
	set "$AAline="%\n%
	set /a "$dx=(((%%~3-%%~1)>>31|1)*(%%~3-%%~1))","$dy=(((%%~4-%%~2)>>31|1)*(%%~4-%%~2))", "$x0=%%~1,$y0=%%~2,$x1=%%~3,$y1=%%~4", "$err=$dx-$dy", "dxdy=$dx+$dy","dist=$dx"%\n%
	if ^^!$dx^^! lss ^^!$dy^^! ( set /a "dist=$dy" )%\n%
	if %%~1 lss %%~3 ( set $sx=1 ) else ( set $sx=-1 )%\n%
	if %%~2 lss %%~4 ( set $sy=1 ) else ( set $sy=-1 )%\n%
	if ^^!dxdy^^! equ 0 ( set $ed=1 ) else ( set /a "$ed=dist" )%\n%
	for /l %%i in (1,1,^^!dist^^!) do (%\n%
		set /a "$shade=255 - (255 * ((($err-$dx+$dy)>>31|1)*($err-$dx+$dy)) / $ed)", "e2=$err, x2=$x0", "$2e2=2 * e2", "color=232 + (255 - 232) * $shade / 255"%\n%
		set "$AAline=^!$AAline^!%\e%[48;5;^!color^!m%\e%[^!$y0^!;^!$x0^!H "%\n%
		if ^^!$2e2^^! geq -^^!$dx^^! (%\n%
			set /a "e2dy=e2 + $dy"%\n%
			if ^^!e2dy^^! lss ^^!$ed^^! if ^^!$x0^^! neq ^^!$x1^^! (%\n%
				set /a "$shade=255 - (255 * (((e2+$dy)>>31|1)*(e2+$dy)) / $ed)", "$y0sy=$y0 + $sy", "color=232 + (255 - 232) * $shade / 255"%\n%
				set "$AAline=^!$AAline^!%\e%[48;5;^!color^!m%\e%[^!$y0sy^!;^!$x0^!H "%\n%
			)%\n%
			set /a "$err-=$dy, $x0+=$sx"%\n%
		)%\n%
		if ^^!$2e2^^! leq ^^!$dy^^! if ^^!$y0^^! neq ^^!$y1^^! (%\n%
			set /a "dxe2=$dx - e2"%\n%
			if ^^!dxe2^^! lss ^^!$ed^^! (%\n%
				set /a "$shade=255 - (255 * ((($dx-e2)>>31|1)*($dx-e2)) / $ed)", "x2sx=x2 + $sx", "color=232 + (255 - 232) * $shade / 255"%\n%
				set "$AAline=^!$AAline^!%\e%[48;5;^!color^!m%\e%[^!$y0^!;^!x2sx^!H "%\n%
			)%\n%
			set /a "$err+=$dx, $y0+=$sy"%\n%
		)%\n%
	)%\n%
	set "$AAline=^!$AAline^!%\e%[0m"%\n%
)) else set args=