(set \n=^^^
%= This creates an escaped Line Feed - DO NOT ALTER =%
)

:_shuffleArray
rem %@shuffleArray% <input:*[]> <len:int>
set @shuffleArray=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1,2" %%1 in ("^!args^!") do (%\n%
	for /l %%i in (%%~2,-1,1) do (%\n%
		set /a "r=^!random^! %% %%i"%\n%
		set "t=^!%%~1[%%i]^!"%\n%
		for %%r in (^^!r^^!) do (%\n%
			set "%%~1[%%i]=^!%%~1[%%r]^!"%\n%
			set "%%~1[%%r]=^!t^!"%\n%
		)%\n%
	)%\n%
)) else set args=

:_reverseArray
rem %@reverseArray% <input:*[]> <len:int>
set @reverseArray=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1,2" %%1 in ("^!args^!") do (%\n%
	set /a "half=%%~2 / 2"%\n%
	for /l %%i in (0,1,^^!half^^!) do (%\n%
		set "t=^!%%~1[%%i]^!"%\n%
		set /a "pos=%%~2-%%i"%\n%
		for %%p in (^^!pos^^!) do (%\n%
			set /a "%%~1[%%i]=^!%%~1[%%p]^!"%\n%
			set "%%~1[%%p]=^!t^!"%\n%
		)%\n%
	)%\n%
)) else set args=

:_arrayContains
rem %arrayContains% <input:*[]> <len:int>
set @arrayContains=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-3" %%1 in ("^!args^!") do (%\n%
	set "$arrayContains=false"%\n%
	for /l %%i in (0,1,%%~2) do (%\n%
		if "^!%%~1[%%i]^!" equ "%%~3" (%\n%
			set "$arrayContains=true"%\n%
		)%\n%
	)%\n%
)) else set args=

:_bubble
rem %@bubble% %list%;newList
set @bubble=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1,2 delims=;" %%1 in ("^!args^!") do (%\n%
	set "%%~2="%\n%
	set "c=0"%\n%
	for %%a in (x %%~1) do set /a "c+=1, n[^!c^!]=%%a"%\n%
	set /a "cm=c - 1"%\n%
	for /l %%l in (0,1,^^!cm^^!) do for /l %%c in (1,1,^^!cm^^!) do (%\n%
		set /a "x=%%c + 1"%\n%
		for %%x in (^^!x^^!) do if ^^!n[%%c]^^! gtr ^^!n[%%x]^^! set /a "save=n[%%c]", "n[%%c]=n[%%x]", "n[%%x]=save"%\n%
	)%\n%
	for /l %%y in (2,1,^^!c^^!) do set "%%~2=^!%%~2^!^!n[%%y]^! "%\n%
	for %%a in (x %%~1) do set "n[^!c^!]="%\n%
)) else set args=

:selection
rem %@sort% %list%;newList
set @selection=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1,2 delims=;" %%1 in ("^!args^!") do (%\n%
	set "%%~2="%\n%
	set "c=0"%\n%
	for %%a in (x %%~1) do set /a "c+=1", "n[^!c^!]=%%a"%\n%
	for %%c in (x %%~1) do ( set /a "lowest=1000"%\n%
		for /l %%n in (^^!c^^!,-1,1) do if ^^!n[%%n]^^! lss ^^!lowest^^! set /a "lowest=n[%%n]", "ln=%%n"%\n%
		set "n[^!ln^!]=1000"%\n%
		set "%%~2=^!%%~2^!^!lowest^! "%\n%
	)%\n%
	for %%a in (x %%~1) do set "n[^!c^!]="%\n%
	set "%%~2=^!%%~2:~2^!"%\n%
)) else set args=