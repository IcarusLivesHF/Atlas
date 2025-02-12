rem variable for direct call to tool
set "cmdwiz=lib\3rdParty\cmdwiz"

rem Use with @controller_cmdwiz where it is a second thread/process
rem Usage: set /p "x=" & set /a "%mouse_and_keys%"
set "@mouse_and_keys=key=x / 2, mouseX=((x>>10) & 2047)+1, mouseY=((x>>21) & 1023)+1, L_Click=(x & 2)>>1, R_Click=(x & 4)>>2, L_Double=(x & 8)>>3, R_Double=(x & 16)>>4, scrollDown=(x & 32)>>5, scrollUp=(x & 64)>>6"


rem Usage:
:_controller_cmdwiz
rem %@controller_cmdwiz%
REM -----------------------------
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


call lib\mouseAndKeys