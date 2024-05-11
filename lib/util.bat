:util

for /f %%a in ('echo prompt $E^| cmd') do set "\e=%%a"

(set \n=^^^
%= This creates an escaped Line Feed - DO NOT ALTER =%
)

set "list.hex=0123456789ABCDEF"

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

:_hex.RGB
rem %hexToRGB% 1b9dee
set @hex.RGB=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-3" %%1 in ("^!args:~1,2^! ^!args:~3,2^! ^!args:~5,2^!") do (%\n%
	set /a "R=0x%%~1", "G=0x%%~2", "B=0x%%~3"%\n%
)) else set args=

:_hex.RND.RGB
rem %hex.rnd.rgb% <rtn> r g b
set @hex.RND.RGB=( set "hex="%\n%
	for /l %%i in (1,1,6) do (%\n%
		set /a "r=^!random^! %% 16"%\n%
		for %%r in (^^!r^^!) do set "hex=^!hex^!^!list.hex:~%%r,1^!"%\n%
	)%\n%
	set /a "R=0x^!hex:~0,2^!", "G=0x^!hex:~2,2^!", "B=0x^!hex:~4,2^!"%\n%
)

:_hex.Base2 DONT' CALL
rem %hexToBase2% 1B out <rtnVar>
set @hex.Base2=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-2" %%1 in ("^!args^!") do (%\n%
	for /l %%i in (7,-1,0) do (%\n%
		set /a "i=((0x%%1 >> %%i) & 1)"%\n%
		set "%%~2=^!%%~2^!^!i^!"%\n%
	)%\n%
)) else set args=

:_hex.Base4 DONT' CALL
rem %hexToBase4% 1B out <rtnVar>
set @hex.Base4=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-2" %%1 in ("^!args^!") do (%\n%
	for /l %%b in (7,-1,0) do (%\n%
		set /a "bit=(0x%%~1 >> %%b) & 1"%\n%
		set "bin=^!bin^!^!bit^!"%\n%
		if "^!bin:~1,1^!" neq "" (%\n%
			set /a "bit=^!bin:~0,1^! * 2 + ^!bin:~1,1^! * 1"%\n%
			set "%%~2=^!%%~2^!^!bit^!"%\n%
			set "bin="%\n%
		)%\n%
	)%\n%
	set "bin="%\n%
)) else set args=

:_pad
rem %pad% "string".int <rtn> $padding
set "$paddingBuffer=                                                                                "
set @pad=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-3 delims=." %%x in ("^!args^!") do (%\n%
    set "$padding="^&set "$_str=%%~x"^&set "len="%\n%
    (for %%P in (32 16 8 4 2 1) do if "^!$_str:~%%P,1^!" NEQ "" set /a "len+=%%P" ^& set "$_str=^!$_str:~%%P^!") ^& set /a "len-=2"%\n%
    set /a "s=%%~y-len"^&for %%a in (^^!s^^!) do set "$padding=^!$paddingBuffer:~0,%%a^!"%\n%
    if "%%~z" neq "" set "%%~z=^!$padding^!"%\n%
)) else set args=

:_encodeB64
rem %encode% "string" <rtn> base64
set @encode=for %%# in (1 2) do if %%#==2 ( for /f "tokens=*" %%1 in ("^!args^!") do (%\n%
	echo=%%~1^>inFile.txt%\n%
	certutil -encode "inFile.txt" "outFile.txt"^>nul%\n%
	for /f "tokens=* skip=1" %%a in (outFile.txt) do (%\n%
		if "%%~a" neq "-----END CERTIFICATE-----" (%\n%
			set "base64=!base64!%%a"%\n%
		)%\n%
	)%\n%
	del /f /q "outFile.txt"%\n%
	del /f /q "inFile.txt"%\n%
)) else set args=

:_decodeB64
rem %decode:?=!base64!% <rtn> plainText.txt
set @decode=for %%# in (1 2) do if %%#==2 ( for /f "tokens=*" %%1 in ("^!args^!") do (%\n%
	echo %%~1^>inFile.txt%\n%
	certutil -decode "inFile.txt" "outFile.txt"^>nul%\n%
	for /f "tokens=*" %%a in (outFile.txt) do (%\n%
		set "plainText=%%a"%\n%
	)%\n%
	del /f /q outFile.txt%\n%
	del /f /q inFile.txt%\n%
)) else set args=

:_string_properties
rem %string_properties "string" <rtn> $_len, $_rev $_upp $_low
set @string_properties=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1 delims=" %%1 in ("^!args^!") do (%\n%
	for %%i in ($_len $_rev $_upp $_low) do set "%%i="%\n%
    set "$_str=%%~1" ^& set "$_str=^!$_str:~1,-1^!" ^& set "string.upp=^!$_str:~1^!" ^& set "string.low=^!$_str:~1^!"%\n%
	for /l %%b in (10,-1,0) do set /a "string.len|=1<<%%b" ^& for %%c in (^^!string.len^^!) do if "^!$_str:~%%c,1^!" equ "" set /a "string.len&=~1<<%%b"%\n%
    for /l %%a in (^^!string.len^^!,-1,1) do set "string.rev=^!string.rev^!^!$_str:~%%~a,1^!"%\n%
    for %%i in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do set "string.upp=^!string.upp:%%i=%%i^!"%\n%
    for %%i in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do set "string.low=^!string.low:%%i=%%i^!"%\n%
)) else set args=

:_lineInject
rem %lineInject:?=FILE NAME.EXT% "String":Line#:s
set @lineInject=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-4 delims=:/" %%1 in ("?:^!args:~1^!") do (%\n%
	set "linesInFile=0"%\n%
	for /f "usebackq tokens=*" %%i in ("%%~1") do (%\n%
		set /a "linesInFile+=1"%\n%
		if /i "%%~4" neq "s" (%\n%
			if ^^!linesInFile^^! equ %%~3 echo=%%~2^>^>-temp-.txt%\n%
			echo %%i^>^>-temp-.txt%\n%
		) else (%\n%
			if ^^!linesInFile^^! equ %%~3 ( echo=%%~2^>^>-temp-.txt ) else echo %%i^>^>-temp-.txt%\n%
		)%\n%
	)%\n%
	ren "%%~1" "deltmp.txt" ^& ren "-temp-.txt" "%%~1" ^& del /f /q "deltmp.txt"%\n%
)) else set args=

:_getLatency
rem %getLatency% <rtn> %latency%
set "@getLatency=for /f "tokens=2 delims==" %%l in ('ping -n 1 ? ^| findstr /L "time="') do set "latency=%%l""

:_download
rem %download% url file
set @download=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-2" %%1 in ("^!args^!") do (%\n%
	Powershell.exe -command "(New-Object System.Net.WebClient).DownloadFile('%%~1','%%~2')"%\n%
)) else set args=

:_ZIP
rem %zip% file.ext zipFileName
set @ZIP=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-2" %%1 in ("^!args^!") do (%\n%
	tar -cf %%~2.zip %%~1%\n%
)) else set args=

:_UNZIP
rem %unzip% zipFileName
set @UNZIP=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1" %%1 in ("^!args^!") do (%\n%
	tar -xf %%~1.zip%\n%
)) else set args=