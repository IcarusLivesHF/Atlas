(set \n=^^^
%= This creates an escaped Line Feed - DO NOT ALTER       \n =%
)

set @timer.start=for /f "tokens=1-4 delims=:.," %%a in ("^!time: =0^!") do set /a "t1=(((1%%a*60)+1%%b)*60+1%%c)*100+1%%d-36610100"

set @timer.stop=(%\n%
	for /f "tokens=1-4 delims=:.," %%a in ("^!time: =0^!") do set /a "t2=(((1%%a*60)+1%%b)*60+1%%c)*100+1%%d-36610100, dt=t2-t1, cs=dt %% 100, sc=dt / 100 %% 60, mn=dt / 100 / 60 %% 60"%\n%
	if ^^!cs^^! lss 10 set cs=0^^!cs^^!%\n%
	if ^^!sc^^! lss 10 set sc=0^^!sc^^!%\n%
	echo=^^!mn^^!:^^!sc^^!.^^!cs^^!%\n%
)