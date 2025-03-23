rem multiply x/y axis by %rotate% 
set "rotate=^!cos:x=theta^! / 10000 + 1 * ^!sin:x=theta^! / 10000"


rem before circle loop
rem set /a "radx=, rady=, radz=, %@3Dangles%"
set "@3Dangles=( cx=^!cos:x=radx^!, sx=^!sin:x=radx^!, cy=^!cos:x=rady^!, sy=^!sin:x=rady^!, cz=^!cos:x=radz^!, sz=^!sin:x=radz^!)

rem inside circle loop
rem set /a "x=, y=, z=, %@PROJECTION_METHOD%" <rtn> $x $y
set "@perspective=( ry=( y * cx -  z * sx) /10000, rz=( y * sx +  z * cx) /10000, rx=( x * cy + rz * sy) /10000, rz=(-x * sy + rz * cy) /10000, df=10000 / (1000 - rz), $x=((rx * cz - ry * sz)/10000) * df / 100, $y=((rx * sz + ry * cz)/10000) * df / 100)"

set "@ortho=( rx=( x *  cx +  z *  sx) /10000, rz=( x * -sx +  z *  cx) /10000, ry=( y *  cy + rz * -sy) /10000, $x=(rx *  cz + ry * -sz) /10000, $y=(rx *  sz + ry *  cz) /10000)"

set "@iso=( $x=rx=( x * cx - z * sx) / 10000, rz=( x * sx + z * cx) / 10000, $y=ry=( y * cy - rz * sy) / 10000)"

set "@oblique=( rx=( x *  cx +  z *  sx) / 10000, rz=( x * -sx +  z *  cx) / 10000, ry=( y *  cy + rz * -sy) / 10000, $x=rx + (cz * rz) / 10000, $y=ry + (sz * rz) / 10000)"
