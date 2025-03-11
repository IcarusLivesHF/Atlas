:_makeButton
rem %@makeButton% x y ID 'string'
set @makeButton=for %%# in (1 2) do if %%#==2 ( for %%i in ("^!args^!") do  for /f "tokens=1,2 delims='" %%1 in ("%%~i") do  for /f "tokens=1-3" %%w in ("%%~1") do (%\n%
	set /a "length=0" ^& set "bar=" ^& set "str=X%%~2"%\n%
	set "button.list=^!button.list^!%%~y "%\n%
	for /l %%b in (6,-1,0) do (%\n%
		set /a "length|=1<<%%b"%\n%
		for %%c in (^^!length^^!) do if "^!str:~%%c,1^!" equ "" set /a "length&=~1<<%%b"%\n%
	)%\n%
	set /a "back=length + 2"%\n%
	for /l %%i in (1,1,^^!length^^!) do (%\n%
		set "bar=^!bar^!Ä"%\n%
	)%\n%
	set "button[%%~y].sprite=[%%~x;%%~wHÚ^!bar^!¿[^!back^!D[B³%%~2³[^!back^!D[BÀ^!bar^!Ù[0m"%\n%
	set "buttonDisplay=^!buttonDisplay^!^!button[%%~y].sprite^!"%\n%
	set /a "button[%%~y].xmin=%%~w - 1","button[%%~y].xmax=%%~w + length","button[%%~y].ymin=%%~x - 1","button[%%~y].ymax=%%~x + 1"%\n%
	set "ifUserClicks_btn[%%~y]=if ^^^!L_click^^^! equ 1 if ^^^!mouseY^^^! geq ^!button[%%~y].ymin^! if ^^^!mouseY^^^! leq ^!button[%%~y].Ymax^! if ^^^!mouseX^^^! geq ^!button[%%~y].Xmin^! if ^^^!mouseX^^^! leq ^!button[%%~y].Xmax^! "%\n%
	set "back="%\n%
)) else set args=

:_killButton
REM %@killButton% 1 4 5 2 3 6 - to kill any or all buttons
set @killButton=for %%# in (1 2) do if %%#==2 ( for /f "tokens=*" %%1 in ("^!args^!") do (%\n%
	if "%%~1" neq "" (%\n%
		for %%i in (%%~1) do (%\n%
			for %%j in ("^!button[%%i].sprite^!") do set "buttonDisplay=^!buttonDisplay:%%~j=^!"%\n%
			set "button[%%i].clicked="%\n%
			set "button[%%i].xmin="%\n%
			set "button[%%i].xmax="%\n%
			set "button[%%i].ymin="%\n%
			set "button[%%i].ymax="%\n%
			set "button[%%i].sprite="%\n%
			set "button.list=^!button.list:%%i =^!"%\n%
			set "ifUserClicks_btn[%%~i]="%\n%
		)%\n%
	)%\n%
)) else set args=

:_makeSlider
rem %@makeSlider% x y length min max sliderColor positionColor
set "map=c+(d-c)*(v-a)/(b-a)" & rem required for slider
set @makeSlider=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-7" %%1 in ("^!args^!") do (%\n%
	set "bar=" ^& set "slider.value=0"%\n%
	for /l %%i in (1,1,%%~3) do set "bar=^!bar^!Ä"%\n%
	set /a "slider.xmin=%%~1", "slider.xmax=%%~1 + %%~3 - 1", "slider.ymin=%%~2 - 2", "slider.ymax=%%~2 + 1", "slider.position=%%~1 + 1", "back=%%~3 + 2"%\n%
	set "sliderDisplay=[38;5;%%~6m[%%~2;%%~1H[AÚ^!bar^!¿[^!back^!D[B(0t(B^!bar^!(0u(B[^!back^!D[BÀ^!bar^!Ù[0m[38;5;%%~7m[%%~2;^^^!slider.position^^^!HÛ[0m"%\n%
	set "ifSliderClicked=if ^^^!L_click^^^! equ 1 if ^^^!mouseX^^^! geq %%~1 if ^^^!mouseX^^^! leq ^!slider.xmax^! if ^^^!mouseY^^^! geq ^!slider.ymin^! if ^^^!mouseY^^^! leq ^!slider.ymax^!"%\n%
	set "moveSlider=(v=mouseX, a=slider.Xmin, b=slider.Xmax, c=%%~4, d=%%~5, slider.value=%map%, slider.position=mouseX + 1)"%\n%
)) else set args=

:_makeInputBar
rem %makeInputBar% rtnVar x y length TextColor BackColor
set @makeInputBar=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-7" %%1 in ("^!args^!") do (%\n%
	set "bar=" ^& set "str=x%%~1"%\n%
	set /a "length=0", "back=%%~4 - 2"%\n%
	set /a "input.xmin=%%~2", "input.xmax=%%~2 + %%~4", "input.ymin=%%~3 - 1", "input.ymax=%%~3 + 1", "input.position.y=%%~3 + 1", "input.position.x=%%~2 + 1"%\n%
	for /l %%b in (6,-1,0) do (%\n%
		set /a "length|=1<<%%b"%\n%
		for %%c in (^^!length^^!) do if "^!str:~%%c,1^!" equ "" set /a "length&=~1<<%%b"%\n%
	)%\n%
	for /l %%i in (3,1,%%~4) do (%\n%
		set "bar=^!bar^!Ä"%\n%
	)%\n%
	set "inputDisplay=[A[38;5;%%~6m[%%~3;%%~2HÚ^!bar^!¿[%%~4D[B³[^!back^!C³[%%~4D[BÀ^!bar^!Ù[0m"%\n%
	set "ifInputClicked=if ^^^!L_click^^^! equ 1 if ^^^!mouseY^^^! geq ^!input.Ymin^! if ^^^!mouseY^^^! leq ^!input.Ymax^! if ^^^!mouseX^^^! geq ^!input.Xmin^! if ^^^!mouseX^^^! leq ^!input.Xmax^! set /p "%%~1=[38;5;%%~5m[^^!input.position.y^^!;^^!input.position.x^^!HInput: ""%\n%
)) else set args=