rem multiply x/y axis by %rotate% 
set "rotate=^!cos:x=theta^! / 10000 + 1 * ^!sin:x=theta^! / 10000"


rem before circle loop
rem set /a "radx=, rady=, radz=, %@3Dangles%"
set "@3Dangles=( cx=^!cos:x=radx^!, sx=^!sin:x=radx^!, cy=^!cos:x=rady^!, sy=^!sin:x=rady^!, cz=^!cos:x=radz^!, sz=^!sin:x=radz^!)

rem set /a "radx=, %@rotateX%"
set "@rotateX=( cx=%cos%, sx=%sin% )"
rem set /a "rady=, %@rotateY%"
set "@rotateY=( cy=%cos:x=y%, sy=%sin:x=y% )"
rem set /a "radz=, %@rotateZ%"
set "@rotateZ=( cz=%cos:x=z%, sz=%sin:x=z% )"




rem inside circle loop ------------------------------------------
rem DEGREES / RADIANS
rem set /a "x=, y=, z=, %@PROJECTION_METHOD%" <rtn> $x $y
set "@perspective=(x*=10,y*=10,z*=10,ry=(y*cx-z*sx)/10000,rz=(y*sx+z*cx)/10000,rx=(x*cy+rz*sy)/10000,rz=(-x*sy+rz*cy)/10000,df=10000/(1000-rz),$x=((rx*cz-ry*sz)/10000)*df/100,$y=((rx*sz+ry*cz)/10000)*df/100)"

set "@ortho=(rx=(x*cx+z*sx)/10000,rz=(x*-sx+z*cx)/10000,ry=(y*cy+rz*-sy)/10000,$x=(rx*cz+ry*-sz)/10000,$y=(rx*sz+ry*cz)/10000)"

set "@iso=($x=rx=(x*cx-z*sx)/10000,rz=(x*sx+z*cx)/10000,$y=ry=(y*cy-rz*sy)/10000)"

set "@oblique=(rx=(x*cx+z*sx)/10000,rz=(x*-sx+z*cx)/10000,ry=(y*cy+rz*-sy)/10000,$x=rx+(cz*rz)/10000,$y=ry+(sz*rz)/10000)"


rem DEGREES
rem equidistant fisheye projection
rem set /a "x=, y=, z=, f=, %@fisheye%"       <rtn> $x $y
set "@fisheye=( rx=( x * cx +  z * sx)/10000, rz=(-x * sx +  z * cx)/10000, ry=( y * cy - rz * sy)/10000, rz=( y * sy + rz * cy)/10000, n=rx*rx + ry*ry, rxy=%sqrt%, e=(~((rxy>>31)|(-rxy>>31)))&1, x=rz, y=rxy, t=%atan2%, s=f * t / rxy, $x=(1-e)*(rx * s / 10000), $y=(1-e)*(ry * s / 10000) )"
