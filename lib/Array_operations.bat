
:_shuffle[Array]
rem %@shuffle[Array]% arrayName arrayLength
set @shuffle[Array]=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1,2" %%1 in ("^!args^!") do (%\n%
	for /l %%i in (%%~2,-1,1) do (%\n%
		set /a "r=^!random^! %% (%%i+1)"%\n%
		set "t=^!%%~1[%%i]^!"%\n%
		for %%r in (^^!r^^!) do (%\n%
			set "%%~1[%%i]=^!%%~1[%%r]^!"%\n%
			set "%%~1[%%r]=^!t^!"%\n%
		)%\n%
	)%\n%
)) else set args=

:_reverse[Array]
rem %@reverse[Array]% arrayName arrayLength
set @reverse[Array]=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1,2" %%1 in ("^!args^!") do (%\n%
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
rem %arrayContains% arrayName arrayLength "value"
set @arrayContains=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-3" %%1 in ("^!args^!") do (%\n%
	set "$arrayContains=false"%\n%
	for /l %%i in (0,1,%%~2) do (%\n%
		if "^!%%~1[%%i]^!" equ "%%~3" (%\n%
			set "$arrayContains=true"%\n%
		)%\n%
	)%\n%
)) else set args=

:_arrayToList
rem %@arrayToList% arrayName arrayLength listName
set @arrayToList=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-3" %%1 in ("^!args^!") do (%\n%
	set "%%~3="%\n%
	for /l %%i in (0,1,%%~2) do (%\n%
		set "%%~3=^!%%~3^!^!%%~1[%%i]^! "%\n%
		set "%%~1[%%i]="%\n%
	)%\n%
)) else set args=

:_listToArray
rem %@listToArray% listName arrayName
set @listToArray=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-2" %%1 in ("^!args^!") do (%\n%
	set "$i=-1"%\n%
	for %%i in (^^!%%~1^^!) do (%\n%
		set /a "$i+=1"%\n%
		for %%I in (^^!$i^^!) do set "%%~2[%%I]=%%i"%\n%
	)%\n%
	set "%%~1="%\n%
)) else set args=

:_bubble[List]
rem %@bubble[list]% %list%;newList
set @bubble[List]=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1,2 delims=;" %%1 in ("^!args^!") do (%\n%
	set "%%~2="%\n%
	set "c=0"%\n%
	for %%a in (x %%~1) do set /a "c+=1, n[^!c^!]=%%a"%\n%
	set /a "cm=c - 1"%\n%
	for /l %%l in (0,1,^^!cm^^!) do for /l %%c in (1,1,^^!cm^^!) do (%\n%
		title %%l/^^!cm^^! %%c/^^!cm^^!%\n%
		set /a "x=%%c + 1"%\n%
		for %%x in (^^!x^^!) do if ^^!n[%%c]^^! gtr ^^!n[%%x]^^! set /a "save=n[%%c]","n[%%c]=n[%%x]","n[%%x]=save"%\n%
	)%\n%
	for /l %%y in (2,1,^^!c^^!) do set "%%~2=^!%%~2^!^!n[%%y]^! "%\n%
	for %%a in (x %%~1) do set "n[^!c^!]="%\n%
)) else set args=

:selection[List]
rem %@selection[list]% %list%;newList
set @selection[List]=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1,2 delims=;" %%1 in ("^!args^!") do (%\n%
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