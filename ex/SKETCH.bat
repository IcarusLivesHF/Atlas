@echo off & setlocal enableDelayedExpansion

call lib\stdlib 80 60

echo %\e%[10;10H%\e%[38;5;10mHello World

pause