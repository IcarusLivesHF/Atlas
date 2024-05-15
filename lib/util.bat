(set \n=^^^
%= This creates an escaped Line Feed - DO NOT ALTER =%
)

:_getAdmin
rem %getAdmin%
set "getAdmin=(Net session >nul 2>&1)|| (PowerShell start """%~0""" -verb RunAs & exit /b)"

:_download
rem %download% url file
set @download=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-2" %%1 in ("^!args^!") do (%\n%
	Powershell.exe -command "(New-Object System.Net.WebClient).DownloadFile('%%~1','%%~2')"%\n%
)) else set args=