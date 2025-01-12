:_getAdmin
rem %@getAdmin%
set "@getAdmin=(Net session >nul 2>&1)|| (PowerShell start """%~0""" -verb RunAs & exit /b)"

:_download
rem %@download% url file - to remain backward compatible, PowerShell.
set @download=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-2" %%1 in ("^!args^!") do (%\n%
	Powershell.exe -command "(New-Object System.Net.WebClient).DownloadFile('%%~1','%%~2')"%\n%
)) else set args=

:_unique
rem %@unique%
set "@unique=for /f "tokens=1-7 delims=/.-: " %%a in ("%date:* =% %time: =0%") do set "$unique=%%c%%a%%b%%d%%e%%f%%g""

:_getLen
rem %getlen% var <rtn> $len
set "@getlen=for %%# in (1 2) do if %%#==2 ( for /f %%1 in ("^^!args^^!") do (set "$=A^^!%%~1^^!" & set "$len=" &  ( for %%] in (4096 2048 1024 512 256 128 64 32 16) do if "^^!$:~%%]^^!" NEQ "" set /a "$len+=%%]" & set "$=^^!$:~%%]^^!" ) & set "$=^^!$:~1^^!FEDCBA9876543210" & set /a $len+=0x^!$:~15,1^! ) ) else set args="

:_string_properties
rem %string_properties% "string" <rtn> $, $_rev $_upp $_low
set @string_properties=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1 delims=" %%1 in ("^!args^!") do (%\n%
    set "$_str=%%~1" ^& set "$_str=^!$_str:~1,-1^!" ^& set "$string.upper=^!$_str:~1^!" ^& set "$string.lower=^!$_str:~1^!"%\n%
	for /l %%b in (10,-1,0) do set /a "$string.length|=1<<%%b" ^& for %%c in (^^!$string.length^^!) do if "^!$_str:~%%c,1^!" equ "" set /a "$string.length&=~1<<%%b"%\n%
    for /l %%a in (^^!$string.length^^!,-1,1) do set "$string.reverse=^!$string.reverse^!^!$_str:~%%~a,1^!"%\n%
    for %%i in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do set "$string.upper=^!$string.upper:%%i=%%i^!"%\n%
    for %%i in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do set "$string.lower=^!$string.lower:%%i=%%i^!"%\n%
	set "$_str="%\n%
)) else set args=

:_modFile
rem \e edit, \i insert, \a append, \p prepend, \d delete, \b backup
set @modFile=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-5 delims=/\" %%1 in ("^!args:~1^!") do (%\n%
	set /a "line_num=lines=0"%\n%
	for /f "delims=: tokens=1" %%i in ('findstr /n "^^" "%%~2"') do set /a "lines+=1"%\n%
	^< "%%~2" ( for /l %%i in (1,1,^^!lines^^!) do set /p "line[%%i]=" )%\n%
	^> "temp.txt" (%\n%
		for /l %%i in (1,1,^^!lines^^!) do (%\n%
			set /a "line_num+=1"%\n%
			if ^^!line_num^^! equ %%~1 (%\n%
				       if "%%~4" equ "e" ( echo %%~3%\n%
				) else if "%%~4" equ "i" ( echo %%~3^&echo ^^!line[%%i]^^!%\n%
				) else if "%%~4" equ "a" ( echo ^^!line[%%i]^^!%%~3%\n%
				) else if "%%~4" equ "p" ( echo %%~3^^!line[%%i]^^!%\n%
				) else if "%%~4" equ "d" ( rem do nothing %\n%
				)%\n%
			) else echo=^^!line[%%i]^^!%\n%
			set "line[%%i]="%\n%
		)%\n%
	)%\n%
	set "lines="%\n%
	set "line_num="%\n%
	if "%%~5" equ "b" copy /y "%%~2" "backup_%%~2"^>nul%\n%
	move /y "temp.txt" "%%~2"^>nul%\n%
)) else set args=