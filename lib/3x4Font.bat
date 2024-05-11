setlocal enableDelayedExpansion

set "[a]=[C  [3D[B [C [3D[B   [3D[B [C [3A"
set "[b]= [2C[3D[B   [3D[B [C [3D[B   [3A"
set "[c]=   [3D[B [2C[3D[B [2C[3D[B   [3A"
set "[d]=  [C[3D[B [C [3D[B [C [3D[B  [C[3A"
set "[e]=   [3D[B [2C[3D[B  [C[3D[B   [3A"
set "[f]=   [3D[B [2C[3D[B  ²[3D[B [C²[3A"
set "[g]=   [3D[B [2C[3D[B [C [3D[B   [3A"
set "[h]= ² [3D[B ² [3D[B   [3D[B [C [3A"
set "[i]= [D[B [D[B [D[B [3A"
set "[j]=²² [3D[B²² [3D[B [C [3D[B   [3A"
set "[k]= [C [3D[B  [C[3D[B ² [3D[B ² [3A"
set "[l]= ²²[3D[B ²²[3D[B [2C[3D[B   [3A"
set "[m]=  [C  [5D[B [C [C [5D[B ² ² [5D[B ²[C² [3A"
set "[n]= [C² [4D[B  ² [4D[B ²  [4D[B ²[C [3A"
set "[o]=   [3D[B [C [3D[B [C [3D[B   [3A"
set "[p]=   [3D[B [C [3D[B   [3D[B [2C[3A"
set "[q]=   [3D[B [C [3D[B   [3D[B[2C [3A"
set "[r]=   [3D[B [C [3D[B  [C[3D[B [C [3A"
set "[s]=  [2D[B [C[2D[B[C [2D[B  [3A"
set "[t]=   [3D[B[C [C[3D[B² ²[3D[B² ²[3A"
set "[u]= ² [3D[B ² [3D[B [C [3D[B   [3A"
set "[v]= ² [3D[B ² [3D[B [C [3D[B[C [C[3A"
set "[w]= ² ² [5D[B ² ² [5D[B [C [C [5D[B[C [C [C[3A"
set "[x]= [C [3D[B[C [C[3D[B ² [3D[B ² [3A"
set "[y]= [C [3D[B   [3D[B² ²[3D[B² ²[3A"
set "[z]=  [2D[B[C [2D[B [C[2D[B  [3A"
set "[1]=[C [2D[B  [2D[B² [2D[B² [3A"
set "[2]=  [2D[B[C [2D[B [C[2D[B  [3A"
set "[3]=   [3D[B[2C [3D[B[C  [3D[B   [3A"
set "[4]= ² [3D[B ² [3D[B   [3D[B[2C [3A"
set "[5]=  [2D[B [C[2D[B[C [2D[B  [3A"
set "[6]= [2C[3D[B   [3D[B [C [3D[B   [3A"
set "[7]=   [3D[B[2C [3D[B²² [3D[B²² [3A"
set "[8]=   [3D[B   [3D[B [C [3D[B   [3A"
set "[9]=   [3D[B [C [3D[B   [3D[B[2C [3A"
set "[0]=   [3D[B [C [3D[B [C [3D[B   [3A"
set "[.]=[C²[C[3D[B[C²[C[3D[B[3C[3D[B[C [C[3A"
set "[-]=[2B   [2A"
set "[+]=[B[C²[C[3D[B   [3D[B[C [C[3A"
set "[_]=[3C"
set "[block]=   [3D[B   [3D[B   [3D[B   [3A"


	set "string=%~1"
	set "str=x%~1"
	set "length=0"
	for /l %%b in (8,-1,0) do (
		set /a "length|=1<<%%b"
		for %%c in (!length!) do (
			if "!str:~%%c,1!" equ "" (
				set /a "length&=~1<<%%b"
			)
		)
	)
	set /a "length-=1"
	for /l %%i in (0,1,!length!) do set "return=!return!"!string:~%%~i,1!" "
	for %%i in (!return!) do set "icon=!icon!![%%~i]![C"

	if "%~2" neq "" ( set "colora=%~2" ) else ( set "colora=15" )
	if "%~3" neq "" ( set "colorb=%~3" ) else ( set "colorb=16" )

endlocal & set "$3x4font=[48;5;%colora%;38;5;%colorb%m%icon%[0m"
