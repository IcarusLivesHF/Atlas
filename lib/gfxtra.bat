
:_bar
rem %@bar% currentValue maxValue MaxlengthOfBar
set @Bar=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-3" %%1 in ("^!args^!") do (%\n%
	set /a "bv=%%~3 * %%~1 / %%~2, ot=%%~2 / 3 + (%%~2 & 1), tt=ot * 2, hue=46, percent=100 * %%~1/%%~2"%\n%
	if %%~1 gtr ^^!ot^^! set "hue=226"%\n%
	if %%~1 gtr ^^!tt^^! set "hue=196"%\n%
	for /f "tokens=1,2" %%a in ("^!bv^! ^!hue^!") do (%\n%
		set "$bar=[%\e%[48;5;%%~bm%\e%[%%~aX%\e%[0m%\e%[%%~3C] %%~1/%%~2 ^!percent^!%%%\e%[0m"%\n%
	)%\n%
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
rem x y w tc1 tc2 bc;text;title
set @msgbox=for %%# in (1 2) do if %%#==2 (%\n%
	for /f "tokens=1-3 delims=;" %%A in ("^!args^!") do (%\n%
		set "$string=%%~B"%\n%
		set "str1=X%%~B"%\n%
		set "str2=X%%~C"%\n%
		set /a "$strLen=$len=0"%\n%
		for /l %%b in (10,-1,0) do (%\n%
			set /a "$strlen|=1<<%%b", "$len|=1<<%%b"%\n%
			for /f "tokens=1,2" %%c in ("^!$strlen^! ^!$len^!") do (%\n%
				if "^!str1:~%%c,1^!" equ "" set /a "$strlen&=~1<<%%b"%\n%
				if "^!str2:~%%d,1^!" equ "" set /a "$len&=~1<<%%b"%\n%
		))%\n%
		for /f "tokens=1-6" %%1 in ("%%~A") do (%\n%
			set /a "$center=%%~1 + ((%%~3 / 2) - ($len / 2)) - ($len & 1)", "lw=%%~3 - 6"%\n%
			for %%I in (^^!lw^^!) do for /l %%i in (0,%%I,^^!$strLen^^!) do (%\n%
				set /a "h+=1", "z=%%i + %%I"%\n%
				set "curstr=^!$string:~%%i,%%I^!"%\n%
				for %%z in (^^!z^^!) do (%\n%
					if "^!$string:~%%z,1^!" neq "" if "^!$string:~%%z,1^!" neq " " if "^!curstr:~-1^!" neq " " (%\n%
						set "curstr=^!curstr^!-"%\n%
				))%\n%
				if "^!curstr:~0,1^!" equ " " set "curstr=^!curstr:~1^!"%\n%
				set "$textChunk=^!$textChunk^!%\e%7^!curstr^!%\e%8%\e%[B"%\n%
			)%\n%
			set /a "sx=%%~1+1", "sy=%%~2+1","h+=6", "lh=h-4", "lw+=3", "lb=lw+1", "la=%%~2+2"%\n%
			for %%h in (^^!h^^!) do set "$mb=^!$s:~0,%%~h^!%\e%[0m"%\n%
			set "$msgbox=%\e%[48;5;16m%\e%[^!sy^!;^!sx^!H^!$mb: =%\e%[%%3X%\e%[B^!"%\n%
			set "$msgbox=^!$msgbox^!%\e%[48;5;%%~6m%\e%[%%~2;%%~1H^!$mb: =%\e%[%%3X%\e%[B^!"%\n%
			for /f "tokens=1-3" %%i in ("^!lw^! ^!lh^! ^!lb^!") do (%\n%
				set "$line=%\e%[38;5;15;48;5;%%~6m%\e%[^!la^!;%%~1H^!$s:~0,%%~j^!%\e%[C^!$q:~0,%%~i^!j"%\n%
				set "$line=^!$line: =%\e%7%\e%[%%~kCx%\e%8%\e%[B^!"%\n%
			)%\n%
			for %%i in (^^!lw^^!) do (%\n%
				set "$msgbox=%\e%(0^!$msgbox^!^!$line^!%\e%(B%\e%[38;5;%%~4m%\e%[%%~2;^!$center^!H%%~C"%\n%
				set "$msgbox=^!$msgbox^!%\e%[38;5;15m%\e%[^!sy^!;%%~1H %\e%7%\e%(0^!$q:~0,%%i^!%\e%(B%\e%8%\e%[2B "%\n%
			)%\n%
			set "$msgbox=^!$msgbox^!%\e%[38;5;%%~5m^!$textChunk^!%\e%[0m"%\n%
		)%\n%
		for %%i in ($line $textChunk $string $strlen $len $center str1 str2 curstr sx sy h lh lw la lb) do set "%%~i="%\n%
)) else set args=







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







:_bezier
rem %@bezier% x1 y1 x2 y2 x3 y3 x4 y4 color <rtn> !$bezier!
set @bezier=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-9" %%a in ("^!args^!") do (%\n%
    if "%%~i" equ "" ( set "$bezier=%\e%[48;5;15m" ) else ( set "$bezier=%\e%[48;5;%%~im" )%\n%
    set /a "H=%%~h-%%~f","I=%%~c-%%~a","J=%%~e-%%~c","K=%%~g-%%~e","L=%%~d-%%~b","M=%%~f-%%~d"%\n%
	for /l %%. in (1,1,50) do (%\n%
		set /a "_=%%.<<1",^
		        "N=((%%~a+_*I*10)/1000+%%~a)",^
		        "O=((%%~c+_*J*10)/1000+%%~c)",^
				"P=((%%~b+_*L*10)/1000+%%~b)",^
				"Q=((N+_*(O-N)*10)/1000+N)",^
				"R=((%%~d+_*M*10)/1000+%%~d)",^
				"S=((P+_*(R-P)*10)/1000+P)",^
				"vx=(Q+_*(((O+_*(((%%~e+_*K*10)/1000+%%~e)-O)*10)/1000+O)-Q)*10)/1000+Q",^
				"vy=(S+_*(((R+_*(((%%~f+_*H*10)/1000+%%~f)-R)*10)/1000+R)-S)*10)/1000+S"%\n%
		set "$bezier=^!$bezier^!%\e%[^!vy^!;^!vx^!H "%\n%
	)%\n%
	set "$bezier=^!$bezier^!%\e%[0m"%\n%
)) else set args=