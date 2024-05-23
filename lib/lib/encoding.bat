(set \n=^^^
%= This creates an escaped Line Feed - DO NOT ALTER =%
)

set "list.hex=0123456789ABCDEF"

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