(set \n=^^^
%= This creates an escaped Line Feed - DO NOT ALTER =%
)

:_lineInject
rem %lineInject:?=FILE NAME.EXT% "String":Line#:s
set @lineInject=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-4 delims=:/" %%1 in ("?:^!args:~1^!") do (%\n%
	set "linesInFile=0"%\n%
	for /f "delims=" %%i in (%%~1) do (%\n%
		set /a "linesInFile+=1"%\n%
		if /i "%%~4" neq "s" (%\n%
			if "^!linesInFile^!" equ "%%~3" (%\n%
				echo=%%~2^>^>-temp-.txt%\n%
			)%\n%
			echo %%i^>^>-temp-.txt%\n%
		) else (%\n%
			if "^!linesInFile^!" equ "%%~3" (%\n%
				echo=%%~2^>^>-temp-.txt%\n%
			) else echo %%i^>^>-temp-.txt%\n%
		)%\n%
	)%\n%
	ren "%%~1" "deltmp.txt"%\n%
	ren "-temp-.txt" "%%~1"%\n%
	del /f /q "deltmp.txt"%\n%
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