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

:_sortFWD
rem %sort[fwd]:#=stingArray%
SET "@sort[fwd]=(FOR %%S in (%%#%%) DO @ECHO %%S) ^| SORT"

:_sortREV
rem %sort[rev]:#=stingArray%
SET "@sort[rev]=(FOR %%S in (%%#%%) DO @ECHO %%S) ^| SORT /R"

:_filterFWD
rem %filter[fwd]:#=stingArray%
SET "@filter[fwd]=(FOR %%F in (%%#%%) DO @ECHO %%F) ^| SORT /UNIQ"

:_filterREV
rem %filter[rev]:#=stingArray%
SET "@filter[rev]=(FOR %%F in (%%#%%) DO @ECHO %%F) ^| SORT /UNIQ /R"