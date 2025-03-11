rem set /a "v=, a=, b=, c=, d=, out=%map%"
set "map=(c + (d - c) * (v - a) / (b - a))"



rem set /a "a=, b=, c=, out=%lerp%"
set "lerp=((a + c * (b - a) * 10) / 1000 + a)"



rem set /a "lo=, hi=, x=, value=%@constrain%
set "constrain=(lq=x-lo, $t=x-(lq&(lq>>31)), gq=hi-$t, $t+=(gq&(gq>>31)))"



rem set /a "a=, b=, c=, out=%interpolate%"
set "interpolate=a + (b - a) * c / 100"



REM set /a "x=, out=%smoothStep%"
set "smoothStep_A=(3 * 100 - 2 * x) * x / 100 * x / 100"
set "smoothStep_B=((3*1000*x*x) -  (2*x*x*x))/1000000"



rem set /a "x=, out=%fade%"
set "fade_A=( x2=x * x, x3=x2 * x, A=x3 / 100, B=6 * x2 - 1500 * x + 100000, (A * B + 500000) / 1000000)"
set "fade_B=(x2 = x * x, x3 = x * x2, A=(x3 + 500) / 1000, B=(6 * x2 - 15000 * x + 10000000 + 500) / 1000, (A * B + 500000) / 1000000)"



REM set /a "r=, g=, b=, out=%bitColor%"
set "bitColor=C=r*6/256*36 + g*6/256*6 + b*6/256 + 16"