@echo off & setlocal enableDelayedExpansion

call lib\stdlib 104 50

:main

echo %\e%[10;10H Hello World

goto :main
