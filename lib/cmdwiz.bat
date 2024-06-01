(set \n=^^^
%= This creates an escaped Line Feed - DO NOT ALTER =%
)

set "cmdwiz=lib\cmdwiz\cmdwiz"

:_mouse_and_keys
set "mouse_and_keys=key=x / 2, MX=((x>>10) & 2047)+1, MY=((x>>21) & 1023)+1, LMB=(x & 2)>>1, RMB=(x & 4)>>2, DLB=(x & 8)>>3, DRB=(x & 16)>>4, MWD=(x & 32)>>5, MWU=(x & 64)>>6"

:_controller_cmdwiz
rem %@controller_cmdwiz%
set @controller_cmdwiz=(%\n%
	for /l %%# in () do (%\n%
		if exist "%temp%\%~n0_abort.txt" (%\n%
			del /f /q "%temp%\%~n0_abort.txt"^>nul%\n%
			exit%\n%
		)%\n%
		%cmdwiz% getch_or_mouse^>nul%\n%
		echo=^^!errorlevel^^!%\n%
	)%\n%
)