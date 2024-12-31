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