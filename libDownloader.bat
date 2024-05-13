@echo off & setlocal enableDelayedExpansion

if not exist "lib\" ( mkdir "lib" )

:main
cls
echo.
set "options=0" & for %%i in (
	3x4Font array_operations buttons encoding extlib file_operations getMouseEXE gfx logicGates math misc setFont shape sorting stdlib turtlegfx util
) do (
	set /a "options+=1"
	set "option[!options!]=%%~i"
	echo    !options!.	%%~i
)
echo.

set "input="
set /p "input=Enter numeric ID to desired library: "

echo=!input:~0,2!|findstr /ric:"[^0123456789]" || ( 
	for %%o in ("!input:~0,2!") do (
		curl -o lib\!option[%%~o]!.bat https://raw.githubusercontent.com/IcarusLivesHF/Batch-Libraries/main/lib/!option[%%~o]!.bat
	)
)
goto :main