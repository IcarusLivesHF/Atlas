REM set /a "x=, y=, out=%rnd(x,y)%"
set /a "$seed=(%RANDOM%<<15)|%RANDOM%, $seed+=((($seed-1)>>31)&1)"
set "rnd=($seed^=$seed<<13,$seed^=$seed>>17,$seed^=$seed<<5, (($seed&0x7FFFFFFF)%%(y-x+1))+x)"
REM set /a "out=%rndSgn%"
set "rndSgn_A=(^!random^! %% 2 * 2 - 1)"
REM set /a "out=%rndSgn%"
set "rndSgn_B=(^!random^! %% 3 - 1)"
REM set /a "%rndRGB%"
set "rndRGB=r=^!random^! %% 255, g=^!random^! %% 255, b=^!random^! %% 255"
rem ----------------------------------------------------------------------------------





rem set /a "x=, out=%@log2%"
set "log2=($t=x, $r=-(65535-$t>>31)<<4, $t>>=$r, $q=-(255-$t>>31)<<3, $t>>=$q, $r|=$q, $q=-(15-$t>>31)<<2, $t>>=$q, $r|=$q, $q=-(3-$t>>31)<<1, $t>>=$q, $r|=$q, $r|=$t>>1)"
rem set /a "x=, out=%@log10%"
set "log10=(((~(x-1000000000)>>31)&1) + ((~(x-100000000)>>31)&1) + ((~(x-10000000)>>31)&1) + ((~(x-1000000)>>31)&1) + ((~(x-100000)>>31)&1) + ((~(x-10000)>>31)&1) + ((~(x-1000)>>31)&1) + ((~(x-100)>>31)&1) + ((~(x-10)>>31)&1))"
rem ----------------------------------------------------------------------------------




rem set /a "n=, out=%sqrt%"
set "sqrt=( M=(N),q=M/(11264)+40, q=(M/q+q)>>1, q=(M/q+q)>>1, q=(M/q+q)>>1, q=(M/q+q)>>1, q=(M/q+q)>>1, q+=(M-q*q)>>31 )"

rem set /a "x=, out=%isqrt%" [input range:0.001 - 2147483.647] [output range: 31.602 - 00.001]
set "iterA=$y=$y*(15000-x/10*($y*$y/100)/20000)/10000"
set "iterB=$y=$y*(15000-x*($y*$y/100)/2000)/10000"
set "condA=($y=204800>>$log/2, %iterA%, %iterA%, %iterA%, ($y+5)/10)"
set "condB=($q=1<<$log/2, $y=22000/($q+($log&1)*($q*14142/10000-$q)), %iterB%, %iterB%, %iterB%)"
set "iSqrt=($log=%@log2%, bool=-(16384-x>>31), ((bool*%condA%)|((~bool&1)*%condB%)))"
for %%i in (iterA iterB condA condB) do set "%%i="
rem ----------------------------------------------------------------------------------




rem set /a "x=, y=, out=%mag%"    Otherwise known as hypot() function
set "mag=(n=(x * x + y * y), %sqrt%)"
rem ----------------------------------------------------------------------------------




rem set /a "x=, out=%abs%"
set "abs=(M=(x>>31), (x^M)-M)"
rem ----------------------------------------------------------------------------------




REM set /a "x=, out=%sgn%" Standard mathematical sign: returns  1 for positive, -1 for negative, and 0 for zero.
set "sgn=((x)>>31 | -(x)>>31 & 1)"
rem set /a "x=, out=%sign%" Sign multiplier: returns  1 for x = 0 (treating 0 as nonnegative) and -1 for x < 0.
set "sign=(1 - 2 * (((x) >> 31) & 1))"
rem ----------------------------------------------------------------------------------




rem set /a "out=%avg:?=LIST%"   NOTE: LIST must NOT end with whitespace.
set avg=((^^^!?: =+^^^!)/(((^^^!?: =^>^>31)+3^>^>1)+((^^^!^>^>31)+3^>^>1)))
rem ----------------------------------------------------------------------------------




REM set /a "x=, y=, out=%max%"
set "max=(x-((x-y)&((x-y)>>31)))"

REM set /a "x=, y=, out=%min%"
set "min=(y+((x-y)&((x-y)>>31)))"

set "@max(x,y,z)=(t=x-((x-y)&((x-y)>>31)), t-((t-z)&((t-z)>>31)))"
set "@min(x,y,z)=(t=y+((x-y)&((x-y)>>31)), z+((t-z)&((t-z)>>31)))"
rem ----------------------------------------------------------------------------------




rem set /a "x=, y=multiple of 10, out=%floor%"
set "floor=(a=(y+5)/10*10, r=x%%a, x-r-(((x>>31)&1)&((-r>>31)&1))*a)"
rem set /a "x=, y=multiple of 10, out=%ceil%"
set "ceil= (y=(y + 5) / 10 * 10, r=x %% y, n=((-r>>31)&1)&(x>>31), f=x - r - (n*y), f + (y & ~((r-1)>>31)) )"
rem ----------------------------------------------------------------------------------




REM set /a "x=, y=, %swap%"
set "swap=(x^=y, y^=x, x^=y)"
rem ----------------------------------------------------------------------------------





REM set /a "x=, y=, out=%cmp%"
set "cmp=(x-y)>>31|((y-x)>>31&1)"
rem ----------------------------------------------------------------------------------





REM set /a "x=, n=, %pow%" & %@pow% <rtn> !$pow!
set "$b=x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x"
set "pow=$z=n * 2 - 1"
set "@pow=for %%a in (^!$z^!) do set /a $pow=^!$b:~0,%%a^!"
rem ----------------------------------------------------------------------------------