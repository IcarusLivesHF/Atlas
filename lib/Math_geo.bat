rem set /a "x1=, y1=, x2=, y2=, out=%dist%"
set "dist=(fx=x1-x2, fy=y1-y2, n=fx*fx+fy*fy, %sqrt%)"


REM set /a "x=, y=, a=, b=, c=, d=, out=%BBA%"
set "boundingBox=(((~(x-a)>>31)&1)&((~(c-x)>>31)&1)&((~(y-b)>>31)&1)&((~(d-y)>>31)&1))"


REM set /a "u1=, u2=, v1=, v2=, out=%det%"
set "det=u1 * v2 - u2 * v1"


rem set /a u1=, v1=, u2=, v2=, out=%dot%
set "dot=u1 * v1 + u2 * v2"


rem set /a "a1=, b1=, c1=, d1=, a2=, b2=, c2=, d2=, %matrixMul_2x2%" <rtn> !$a!-!$d!
set "matrixMul_2x2=$a=a1*a2+b1*c2,  $b=a1*b2+b1*d2,  $c=c1*a2+d1*c2,  $d=c1*b2+d1*d2"
REM set /a "a=, b=, c=, d=, e=, f=, g=, h=, i=, j=, k=, l=, m=, n=, o=, p=, q=, r=, %matrixMul_3x3%" <rtn> !$a!-!$i!
set "matrixMul_3x3=$a=a*j+b*m+c*p, $b=a*k+b*n+c*q, $c=a*l+b*o+c*r, $d=d*j+e*m+f*p, $e=d*k+e*n+f*q, $f=d*l+e*o+f*r, $g=g*j+h*m+i*p, $h=g*k+h*n+i*q, $i=g*l+h*o+i*r"
