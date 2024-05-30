rem Backspace
for /f %%a in ('"prompt $H&for %%b in (1) do rem"') do set "BS=%%a"
rem Carriage Return
for /f %%A in ('copy /z "%~dpf0" nul') do set "CR=%%A"

for %%i in ("pointer[R].10" "pointer[L].11" "pointer[U].1E" "pointer[D].1F"
		    "pixel[0]  .DB"   "pixel[1].B0"   "pixel[2].B1"   "pixel[3].B2"
		    "face[0]   .01"    "face[1].02"  "musicNote.0E"  "degree   .F8"
		    "diamond   .04"    "club   .05"      "spade.06"      "<3   .03"
		    "border[V] .B3"  "border[H].C4"  "border[+].C5" "border[HN].C1"
		    "border[HS].C2" "border[VE].C3" "border[VW].B4" "border[SE].D9"
		    "border[NE].BF" "corner[SW].C0" "border[NW].DA" "TAB.09" "BEL.07"
) do for /f "tokens=1,2 delims=. " %%a in ("%%~i") do (
	for /f %%i in ('forfiles /m "%~nx0" /c "cmd /c echo 0x%%~b"') do set "%%~a=%%~i"
)