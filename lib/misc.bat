set "gravity=_G_=1, ?.acceleration+=_G_, ?.velocity+=?.acceleration, ?.acceleration*=0, ?+=?.velocity"
set "smoothStep=(3 * 100 - 2 * x) * x / 100 * x / 100"
set "bitColor=C=((r)*6/256)*36+((g)*6/256)*6+((b)*6/256)+16"
set "fib=?=c=a+b, a=b, b=c"
set "rndRGB=r=^!random^! %% 255, g=^!random^! %% 255, b=^!random^! %% 255"
set "FNCross=(a * d - b * c)"
set "RRB=(^!random^! %% (x * 2 + 1) - x)" & rem Random Range Boundary