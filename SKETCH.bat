@echo off & setlocal enableDelayedExpansion
REM echo %import%shart
REM pause

call lib\stdlib 104 50
call lib\3x4font "Mouse   install   by   Icarus Lives"
call lib\getMouseEXE

echo %\e%[3;2H%$3x4font%%\e%[25;45HClick anywhere%\e%[10H
:main

%getmouse%

echo %mouse.x% %mouse.y% %mouse.c%
goto :main