set "degreesMode=0"
if /i "%~1" equ ""        set /a "degreesMode+=1"
if /i "%~1" equ "degrees" set /a "degreesMode+=1"

%= DEGREES are pre-normalized =%
%= RADIANS are not, divide by /10000 =%

if %degreesMode% gtr 0 (
	rem This version of SIN/COS is for DEGREES
	set "sin=(a=((x*31416/180)%%62832)+(((x*31416/180)%%62832)>>31&62832), b=(a-15708^a-47124)>>31,a=(-a&b)+(a&~b)+(31416&b)+(-62832&(47123-a>>31)),a-a*a/1875*a/320000+a*a/1875*a/15625*a/16000*a/2560000-a*a/1875*a/15360*a/15625*a/15625*a/16000*a/44800000) / 10000"
	set "cos=(a=((15708-x*31416/180)%%62832)+(((15708-x*31416/180)%%62832)>>31&62832), b=(a-15708^a-47124)>>31,a=(-a&b)+(a&~b)+(31416&b)+(-62832&(47123-a>>31)),a-a*a/1875*a/320000+a*a/1875*a/15625*a/16000*a/2560000-a*a/1875*a/15360*a/15625*a/15625*a/16000*a/44800000) / 10000"
	set "rotate=^!cos:x=theta^! + 1 * ^!sin:x=theta^!"
) else if /i "%~1" equ "radians" (
	rem This version of SIN/COS is for RADIANS
	set /a "PI=31416, HALF_PI=PI / 2, TAU=TWO_PI=2*PI, PI32=PI+HALF_PI, QUARTER_PI=PI / 4"
	set "_SIN=a-a*a/1920*a/312500+a*a/1920*a/15625*a/15625*a/2560000-a*a/1875*a/15360*a/15625*a/15625*a/16000*a/44800000"
	set "sin=(a=(        x)%%62832, c=(a>>31|1)*a, a-=(((c-47125)>>31)+1)*((a>>31|1)*62832)  +  (-((c-47125)>>31))*( (((c-15709)>>31)+1)*(-(a>>31|1)*31416+2*a)  ), !_SIN!)"
	set "cos=(a=(15708 - x)%%62832, c=(a>>31|1)*a, a-=(((c-47125)>>31)+1)*((a>>31|1)*62832)  +  (-((c-47125)>>31))*( (((c-15709)>>31)+1)*(-(a>>31|1)*31416+2*a)  ), !_SIN!)"
	set "_sin="
	set "rotate=^!cos:x=theta^! / 10000 + 1 * ^!sin:x=theta^! / 10000"
)
set "degreesMode="


rem set /a "n=, out=%sqrt%"
set "sqrt=( M=(N),j=M/(11264)+40, j=(M/j+j)>>1, j=(M/j+j)>>1, j=(M/j+j)>>1, j=(M/j+j)>>1, j=(M/j+j)>>1, j+=(M-j*j)>>31 )"

rem set /a "n=, out=%abs%"
set "Abs=(((x)>>31|1)*(x))"

rem set /a "x1=, y1=, x2=, y2=, out=%dist%"
set "dist=( @=x2-x1, $=y2-y1, ?=(((@>>31|1)*@-(($>>31|1)*$))>>31)+1, ?*(2*(@>>31|1)*@-($>>31|1)*$-((@>>31|1)*@-($>>31|1)*$)) + ^^^!?*((@>>31|1)*@-($>>31|1)*$-((@>>31|1)*@-($>>31|1)*$*2)) )"

rem set /a "v=, a=, b=, c=, d=, out=%map%"
set "map=c + (d - c) * (v - a) / (b - a)"

rem set /a "a=, b=, c=, out=%lerp%"
set "lerp=?=(a + c * (b - a) * 10) / 1000 + a"

rem set /a "a=, b=, c=, out=%interpolate%"
set "interpolate(a,b,c)=a + (b - a) * c"

rem set /a "low=, high=, value=%clamp:x=value%
set "clamp= (leq=((low-(x))>>31)+1)*low  +  (geq=(((x)-high)>>31)+1)*high  +  ^^^!(leq+geq)*(x) "


(set \n=^^^
%= This creates an escaped Line Feed - DO NOT ALTER =%
)
:_pow
rem %@pow% base exp <rtn> $pow
for /l %%i in (1,1,30) do set "pow.buffer=!pow.buffer!x*"
set @pow=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1,2" %%1 in ("^!args^!") do (%\n%
	set /a "exp=%%~2 * 2 - 1"%\n%
	for %%a in (^^!exp^^!) do set /a "x=%%~1","$pow=^!pow.buffer:~0,%%a^!"%\n%
)) else set args=