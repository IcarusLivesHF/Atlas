rem set /a "gravity:?=VARIABLE_AFFECTED"
set "gravity=_G_=1, ?.acceleration+=_G_, ?.velocity+=?.acceleration, ?.acceleration*=0, ?+=?.velocity"


REM set /a "a=, b=, c=, d=, out=%getState%"
set "getState=(a * 8 + b * 4 + c * 2 + d * 1)"



REM set /a "%every:x=FRAMES%" ; must define %frameCount%
set "every=1/(frameCount%%x)"


