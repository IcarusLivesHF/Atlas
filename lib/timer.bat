(set \n=^^^
%= This creates an escaped Line Feed - DO NOT ALTER       \n =%
)
for /f %%a in ('echo prompt $E^| cmd') do set "\e=%%a"

:_timer.start
REM %@timer.start% no arguements
set @timer.start=for /f "tokens=1-4 delims=:.," %%a in ("^!time: =0^!") do set /a "t1=(((1%%a*60)+1%%b)*60+1%%c)*100+1%%d-36610100"

:_timer.stop
rem %@timer.stop% if no arguments supplied, then return time, else, display time, and save time for @timer.diff
set @timer.stop=(%\n%
    for /f "tokens=1-4 delims=:.," %%a in ("^!time: =0^!") do set /a "t2=(((1%%a*60)+1%%b)*60+1%%c)*100+1%%d-36610100, ?=dt=t2-t1, cs=dt %% 100, sc=dt / 100 %% 60, mn=dt / 100 / 60 %% 60"%\n%
    if ^^!cs^^! lss 10 set cs=0^^!cs^^!%\n%
    if ^^!sc^^! lss 10 set sc=0^^!sc^^!%\n%
    echo=Time ?: ^^!mn^^!:^^!sc^^!.^^!cs^^!%\n%
	set dt=0%\n%
)

:_timer.diff
REM %@timer.diff% time.a time.b <rtn> difference in time.b - time.a
set @timer.diff=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1,2" %%1 in ("^!args^!") do ( if "%%~2" neq "" (%\n%
    if %%~2 gtr %%~1 ( set /a "dt=%%~2 - %%~1" ) else ( set /a "dt=%%~1 - %%~2" ) %\n%
    set /a "cs=dt %% 100, sc=dt / 100 %% 60, mn=dt / 100 / 60 %% 60"%\n%
    for %%i in (cs sc) do if ^^!%%i^^! lss 10 set %%i=0^^!%%i^^!%\n%
    echo=%\e%7----------------%\e%8%\e%[BDiff  : ^^!mn^^!:^^!sc^^!.^^!cs^^!%\n%
) else echo insufficient arguments supplied)) else set args=