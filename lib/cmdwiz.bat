
set "cmdwiz=lib\cmdwiz\cmdwiz"



set "saveLastClicks=last_l_click=l_click, last_r_click=r_click"

rem substitute ? for R,L:   if %onClick:?=L% ( do code )
set        "onClick="^^!?_click^^!.^^!last_?_click^^!" equ "1.0""
set "onClickRelease="^^!?_click^^!.^^!last_?_click^^!" equ "0.1""

rem set /a "a=, b=, c=, d=, %clickingInsideBox:?=L or R%" <rtn> $clickingInsideBox 0:false or 1:true
set "@clickingInsideBox=$clickingInsideBox=((~(mouseY-b)>>31)&1) & ((~(d-mouseY)>>31)&1) & ((~(mouseX-a)>>31)&1) & ((~(c-mouseX)>>31)&1) & ?_click"

:_mouse_and_keys
set "mouse_and_keys=key=x / 2, mouseX=((x>>10) & 2047)+1, mouseY=((x>>21) & 1023)+1, L_Click=(x & 2)>>1, R_Click=(x & 4)>>2, L_Double=(x & 8)>>3, R_Double=(x & 16)>>4, scrollDown=(x & 32)>>5, scrollUp=(x & 64)>>6"

:_controller_cmdwiz
rem %@controller_cmdwiz%
set @controller_cmdwiz=(%\n%
	for /l %%# in () do (%\n%
		if exist "%temp%\abort.txt" (%\n%
			del /f /q "%temp%\abort.txt"^>nul%\n%
			exit%\n%
		)%\n%
		%cmdwiz% getch_or_mouse^>nul%\n%
		echo=^^!errorlevel^^!%\n%
	)%\n%
)