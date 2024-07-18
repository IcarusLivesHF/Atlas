rem set /a "gravity:?=VARIABLE_AFFECTED"
set "gravity=_G_=1, ?.acceleration+=_G_, ?.velocity+=?.acceleration, ?.acceleration*=0, ?+=?.velocity"

REM set /a "x=, out=%smoothStep%"
set "smoothStep=(3 * 100 - 2 * x) * x / 100 * x / 100"

REM set /a "r=, g=, b=, out=%bitColor%"
set "bitColor=C=((r)*6/256)*36+((g)*6/256)*6+((b)*6/256)+16"

REM set /a "%rndRGB%"
set "rndRGB=r=^!random^! %% 255, g=^!random^! %% 255, b=^!random^! %% 255"

REM set /a "u1=, u2=, v1=, v2=, out=%det%"
set "det=u1 * v2 - u2 * v1"

rem set /a u1=, v1=, u2=, v2=, out=%dot%
set "dot=u1 * v1 + u2 * v2"

REM set /a "x=, out=%randomRangeBoundary%"
set "randomRangeBoundary=(^!random^! %% (x * 2 + 1) - x)"

REM set /a "x=, y=, out=%randomRange%"
set "randomRange=(^!random^! %% ((x - (y * 2)) + 1) + y)"

REM set /a "a=, b=, c=, d=, out=%kappa%"
set "kappa=(((1000*(a+d)/(a+b+c+d)) - ((((10000*(a+c)/(a+b+c+d))*(10000*(a+b)/(a+b+c+d))) + ((10000*(b+d)/(a+b+c+d))*(10000*(c+d)/(a+b+c+d))))/100000)) * 1000 / (1000 - ((((10000*(a+c)/(a+b+c+d))*(10000*(a+b)/(a+b+c+d))) + ((10000*(b+d)/(a+b+c+d))*(10000*(c+d)/(a+b+c+d))))/100000)))"

REM set /a "x=, y=, out=%avg%"
set "avg=(x & y) + (x ^ y) / 2"

REM set /a "%every:x=FRAMES%" ; must define %frameCount%
set "every=1/(frameCount%%x)"

REM set /a "x=, out=%sign%"
set "sign=(x)>>31 | -(x)>>31 & 1"

REM set /a "a=, b=, c=, d=, out=%getState%"
set "getState=a * 8 + b * 4 + c * 2 + d * 1"

REM set /a "x=, y=, z=, out=%index%"
set "index=x + y * z"

REM set /a "x=, y=, out=%max%"
set "max=(x - ((((x - y) >> 31) & 1) * (x - y)))"

REM set /a "x=, y=, out=%min%"
set "min=(y - ((((x - y) >> 31) & 1) * (y - x)))"

REM set /a "x=, y=, %swap%"
set "swap=x^=y, y^=x, x^=y"

REM set /a "x=, y=, out=%cmp%"
set "cmp=(x-y)>>31|((y-x)>>31&1)"

REM set /a "x=, y=, a=, b=, c=, d=, out=%BBA%"
set "BBA=(((~(x-a)>>31)&1)&((~(c-x)>>31)&1)&((~(y-b)>>31)&1)&((~(d-y)>>31)&1))"

REM set /a "x=, y=, out=%checkBounds%"
set "checkBounds=(((wid-x)>>31)&1)|(((hei-y)>>31)&1)"

REM set /a "a=,b=, out=%hypot%"
set "hypot=( M=(a*a+b*b),j=M/(11264)+40, j=(M/j+j)>>1, j=(M/j+j)>>1, j=(M/j+j)>>1, j=(M/j+j)>>1, j=(M/j+j)>>1, j+=(M-j*j)>>31 )"