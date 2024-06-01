(set \n=^^^
%= This creates an escaped Line Feed - DO NOT ALTER =%
)

:_getAdmin
rem %@getAdmin%
set "getAdmin=(Net session >nul 2>&1)|| (PowerShell start """%~0""" -verb RunAs & exit /b)"

:_download
rem %@download% url file
set @download=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-2" %%1 in ("^!args^!") do (%\n%
	Powershell.exe -command "(New-Object System.Net.WebClient).DownloadFile('%%~1','%%~2')"%\n%
)) else set args=

:_unique
rem %@unique%
set "@unique=for /f "tokens=1-7 delims=/.-: " %%a in ("%date:* =% %time: =0%") do set "$unique=%%c%%a%%b%%d%%e%%f%%g""

:_getLen
rem %getlen% "string" <rtn> $length
set @getlen=for %%# in (1 2) do if %%#==2 ( for %%1 in (^^!args^^!) do (%\n%
	set "str=X%%~1" ^& set "length=0" ^& for /l %%b in (10,-1,0) do set /a "length|=1<<%%b" ^& for %%c in (^^!length^^!) do if "^!str:~%%c,1^!" equ "" set /a "length&=~1<<%%b"%\n%
)) else set args=

:_string_properties
rem %string_properties "string" <rtn> $, $_rev $_upp $_low
set @string_properties=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1 delims=" %%1 in ("^!args^!") do (%\n%
    set "$_str=%%~1" ^& set "$_str=^!$_str:~1,-1^!" ^& set "$string.upper=^!$_str:~1^!" ^& set "$string.lower=^!$_str:~1^!"%\n%
	for /l %%b in (10,-1,0) do set /a "$string.length|=1<<%%b" ^& for %%c in (^^!$string.length^^!) do if "^!$_str:~%%c,1^!" equ "" set /a "$string.length&=~1<<%%b"%\n%
    for /l %%a in (^^!$string.length^^!,-1,1) do set "$string.reverse=^!$string.reverse^!^!$_str:~%%~a,1^!"%\n%
    for %%i in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do set "$string.upper=^!$string.upper:%%i=%%i^!"%\n%
    for %%i in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do set "$string.lower=^!$string.lower:%%i=%%i^!"%\n%
	set "$_str="%\n%
)) else set args=