rem set /a "v=, a=, b=, c=, d=, out=%map%"
set "map=(c + (d - c) * (v - a) / (b - a))"



rem set /a "a=, b=, c=, out=%lerp%"
set "lerp=((a + c * (b - a) * 10) / 1000 + a)"



rem set /a "lo=, hi=, x=, value=%@constrain%
set "constrain=(lq=x-lo, $t=x-(lq&(lq>>31)), gq=hi-$t, $t+=(gq&(gq>>31)))"



rem set /a "a=, b=, c=, out=%interpolate%"
set "interpolate=a + (b - a) * c / 100"



REM set /a "x=, out=%smoothStep%"
set "smoothStep_A=(300 - 2 * x) * x / 100 * x / 100"



rem set /a "x=, out=%fade%"
set "fade=( $x2=x * x, $x3=$x2 * x, $A=$x3 / 100, $B=6 * $x2 - 1500 * x + 100000, $A * $B / 1000000)"



