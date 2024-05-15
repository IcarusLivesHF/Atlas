@echo off & setlocal enableDelayedExpansion & mode 80,40

for /f %%a in ('echo prompt $E^| cmd') do set "\e=%%a"

if not exist "lib\" ( mkdir "lib" )

:main

echo %\e%[6;3H%\e%(0lqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqk%\e%(B
set "options=0" & for /f "delims=" %%i in ('dir /b "lib\*.bat"') do (
	set /a "options+=1"
	set "option[!options!]=%%~i"
	echo   %\e%(0x%\e%(B%\e%7%\e%[38;5;11m!options!%\e%[0m.%\e%8%\e%[12C%\e%7%\e%[38;5;39m%%~i%\e%[0m%\e%8%\e%[57C%\e%(0x%\e%(B
)
echo.  %\e%(0mqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqj%\e%(B
set "input="
set /p "input=%\e%[2B%\e%[3CEnter %\e%[38;5;11mnumeric ID%\e%[0m to desired %\e%[38;5;39mlibrary%\e%[0m: "
echo.%\e%[2J%\e%[H

echo=!input:~0,2!|findstr /ric:"[^0123456789]" || ( 
	for %%o in ("!input:~0,2!") do (
		curl -o lib\!option[%%~o]!.bat https://raw.githubusercontent.com/IcarusLivesHF/Batch-Libraries/main/lib/!option[%%~o]!.bat >>log.txt
	)
)

goto :main