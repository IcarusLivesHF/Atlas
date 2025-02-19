(set \n=^^^
%= This creates an escaped Line Feed - DO NOT ALTER =%
)

rem set /a "gravity:?=VARIABLE_AFFECTED"
set "gravity=_G_=1, ?.acceleration+=_G_, ?.velocity+=?.acceleration, ?.acceleration*=0, ?+=?.velocity"

REM set /a "x=, out=%smoothStep%"
set "smoothStep=(3 * 100 - 2 * x) * x / 100 * x / 100"

REM set /a "r=, g=, b=, out=%bitColor%"
set "bitColor=C=r*6/256*36 + g*6/256*6 + b*6/256 + 16"

REM set /a "%rndRGB%"
set "rndRGB=r=^!random^! %% 255, g=^!random^! %% 255, b=^!random^! %% 255"

REM set /a "u1=, u2=, v1=, v2=, out=%det%"
set "det=u1 * v2 - u2 * v1"

rem set /a u1=, v1=, u2=, v2=, out=%dot%
set "dot=u1 * v1 + u2 * v2"

REM set /a "x=, out=%randomRangeBoundary%"
set "randomRangeBoundary=(^!random^! %% (x * 2 + 1) - x)"

REM set /a "a=, b=, c=, d=, out=%kappa%"
set "kappa=(((1000*(a+d)/(a+b+c+d)) - ((((10000*(a+c)/(a+b+c+d))*(10000*(a+b)/(a+b+c+d))) + ((10000*(b+d)/(a+b+c+d))*(10000*(c+d)/(a+b+c+d))))/100000)) * 1000 / (1000 - ((((10000*(a+c)/(a+b+c+d))*(10000*(a+b)/(a+b+c+d))) + ((10000*(b+d)/(a+b+c+d))*(10000*(c+d)/(a+b+c+d))))/100000)))"

REM set /a "%every:x=FRAMES%" ; must define %frameCount%
set "every=1/(frameCount%%x)"

rem set /a "out=%@avg(?):?=LIST%"   NOTE: LIST must NOT end with whitespace.
set @avg(?)=((^^^!?: =+^^^!)/(((^^^!?: =^>^>31)+3^>^>1)+((^^^!^>^>31)+3^>^>1)))

REM set /a "a=, b=, c=, d=, out=%getState%"
set "getState=a * 8 + b * 4 + c * 2 + d * 1"

REM set /a "x=, y=, out=%max%"
set "max=(x - ((((x - y) >> 31) & 1) * (x - y)))"

REM set /a "x=, y=, out=%min%"
set "min=(y - ((((x - y) >> 31) & 1) * (y - x)))"

rem set /a "x=, out=%floor%"
set "floor=(a=x, r=a%%10000, n=((-r>>31)&1)&(a>>31), a - r - (n*10000) )"

rem set /a "x=, out=%ceil%"
set "ceil=(a=x, r=a%%10000, n=((-r>>31)&1)&(a>>31), f=a - r - (n*10000), f + (10000 & ~((r-1)>>31)) )"

REM set /a "x=, y=, %swap%"
set "swap=(x^=y, y^=x, x^=y)"

REM set /a "x=, y=, out=%cmp%"
set "cmp=(x-y)>>31|((y-x)>>31&1)"

rem set /a "a=, b=, c=, out=%interpolate%"
set "interpolate=a + (b - a) * c / 100"

REM set /a "x=, y=, a=, b=, c=, d=, out=%BBA%"
set "BBA=(((~(x-a)>>31)&1)&((~(c-x)>>31)&1)&((~(y-b)>>31)&1)&((~(d-y)>>31)&1))"

rem set /a "a1=, b1=, c1=, d1=, a2=, b2=, c2=, d2=, %matrixMul_2x2%" <rtn> !$a!-!$d!
set "matrixMul_2x2=$a=a1*a2+b1*c2,  $b=a1*b2+b1*d2,  $c=c1*a2+d1*c2,  $d=c1*b2+d1*d2"

REM set /a "a=, b=, c=, d=, e=, f=, g=, h=, i=, j=, k=, l=, m=, n=, o=, p=, q=, r=, %matrixMul_3x3%" <rtn> !$a!-!$i!
set "matrixMul_3x3=$a=a*j+b*m+c*p, $b=a*k+b*n+c*q, $c=a*l+b*o+c*r, $d=d*j+e*m+f*p, $e=d*k+e*n+f*q, $f=d*l+e*o+f*r, $g=g*j+h*m+i*p, $h=g*k+h*n+i*q, $i=g*l+h*o+i*r"

rem tables for log2 and log10
set "tab32=0009010A0D15021D0B0E10121619031E080C141C0F111807131B17061A05041F"
set "powerOf10=1000000000"

rem set /a "x=, %log2%" & %@log2%
set "log2=(v=x, v|=(v>>1), v|=(v>>2), v|=(v>>4), v|=(v>>8), v|=(v>>16), index=(((v * 130329821) >> 27) & 31) * 2)"
set "@log2=for %%i in (^!index^!) do set /a $log=0x^!tab32:~%%i,2^!"

rem %@log10% INT <rtn> $log
set @log10=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-2" %%1 in ("^!args^!") do (%\n%
	set /a "v=%%1, v|=(v>>1), v|=(v>>2), v|=(v>>4), v|=(v>>8), v|=(v>>16), index=(((v * 130329821) >> 27) & 31) * 2"%\n%
	for %%i in (^^!index^^!) do set /a "$log=0x^!tab32:~%%i,2^!"%\n%
	set /a "t=(($log + 1) * 1233 >> 12) + 1, $log=t - 1"%\n%
	for %%t in (^^!t^^!) do (%\n%
		set "p=^!powerOf10:~0,%%t^!"%\n%
		if %%~1 lss ^^!p^^! set /a "$log-=1"%\n%
	)%\n%
)) else set args=