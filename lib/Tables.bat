rem set /a "x=, %fadeT%" & %@fade%
set "fadeTable=000000000000000000010101010202030304040506070708090A0B0D0E0F101213141618191B1C1E2021232527292B2C2E3032343638393B3D3F4143444648494B4C4E50515254555657595A5B5C5D5D5E5F60606161626263636363646464646464646464646464646464646464636363636262616160605F5E5D5D5C5B5A59575655545251504E4C4B4948464443413F3D3B3938363432302E2C2B2927252321201E1C1B191816141312100F0E0D0B0A09080707060504040303020201010101000000000000000000"
set "fadeT=$index=x * 2 - 2"
set "@fade=for %%a in (^!$index^!) do set /a $fade=0x^!fadeTable:~%%a,2^!"
