
rem substitute ? for R,L:   if %onClick:?=L% ( do code )
set        "@onClick="^^!?_click^^!.^^!last_?_click^^!" equ "1.0""
set "@onClickRelease="^^!?_click^^!.^^!last_?_click^^!" equ "0.1""
set   "@holdingClick="^^!?_click^^!.^^!last_?_click^^!" equ "1.1""


rem use with onClick/onClickRelease
rem usage: set /a "%saveLastClicks%"
set "@saveLastClicks=last_l_click=l_click, last_r_click=r_click, last_b_click=b_click"


rem 0 by default, 1 if true if mouse is clicking 
set "@ifClickingPoint=(_t=(mouseX^x)|(mouseY^y)|(L_click^1), (~(_t|-_t)>>31)&1)"


rem determine if mouse is hovering over a box, button, etc.
rem set /a "a=x, b=y, c=x+wid, d=y+hei, return=%@hovering%"
set "@hovering=((~(mouseY-b)>>31)&1) & ((~(d-mouseY)>>31)&1) & ((~(mouseX-a)>>31)&1) & ((~(c-mouseX)>>31)&1)"

rem bounding box macro with L/R click validation
rem set /a "a=, b=, c=, d=, %clickingInsideBox:?=L or R%" <rtn> !$clickingInsideBox! 0:false or 1:true
set "@clickingInsideBox=$clickingInsideBox=^!@hovering^! & ?_click"


rem determine a key press even if other keys are being held
rem %asyncKeys:?=27% ( echo You're pressing ESC key )
set "@asyncKeys=if NOT "^^!keysPressed^^!" == "^^!keysPressed:-?-=^^!""


rem @clickAndDrag x y w h L/R
set @clickAndDrag=for %%# in (1 2) do if %%#==2 (for /f "tokens=1-5" %%1 in ("^!args^!") do (%\n%
	set /a "$clickingInsideBox=((~((mouseX - %%~1 + 1) | (%%~1 + %%~3 - mouseX - 1) | (mouseY - %%~2 + 1) | (%%~2 + %%~4 - mouseY - 2)) >> 31) & 1) & %%~5_click"%\n%
	if ^^!$clickingInsideBox^^! equ 1 ( %\n%
		if defined dragging ( set /a "%%~1=mouseX - offsetX, %%~2=mouseY - offsetY"%\n%
		)        else       ( set /a "offsetX=mouseX - %%~1, offsetY=mouseY - %%~2, dragging=1" )%\n%
	) else set "dragging="%\n%
)) else set args=