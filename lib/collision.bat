set "sqrt(N)=( M=(N),j=M/(11264)+40, j=(M/j+j)>>1, j=(M/j+j)>>1, j=(M/j+j)>>1, j=(M/j+j)>>1, j=(M/j+j)>>1, j+=(M-j*j)>>31 )"

:_collision
rem PointPoint x1 y1 x2 y2               <rtn> !COLLISION! 0:false or 1:true
set "PointPoint=COLLISION=(((~(x2-x1)>>31)&1)&((~(x1-x2)>>31)&1)) & (((~(y2-y1)>>31)&1)&((~(y1-y2)>>31)&1))"

rem PointCircle x1 y1 cx cy r            <rtn> !COLLISION! 0:false or 1:true
set "PointCircle=COLLISION=((~((r - !sqrt(n):n=(x1-cx)*(x1-cx) + (y1-cy)*(y1-cy)!)-1)>>31)&1)"

rem CircleCircle c1x c1y c1r c2x c2y c2r <rtn> !COLLISION! 0:false or 1:true
set "CircleCircle=COLLISION=((~((c1r+c2r)-!sqrt(n):n=(c1x-c2x)*(c1x-c2x) + (c1y-c2y)*(c1y-c2y)!)>>31)&1)"

rem PointRect px py rx ry rw rh          <rtn> !COLLISION! 0:false or 1:true
set "PointRect=COLLISION=((~(px-rx)>>31)&1) & ((~((rx+rw)-px)>>31)&1) & ((~(py-ry)>>31)&1) & ((~((ry+rh)-py)>>31)&1)"
	
REM RectRect x1 y1 w1 h1 x2 y2 w2 h2     <rtn> !COLLISION! 0:false or 1:true
set "RectRect=COLLISION=((~((a+c)-e)>>31)&1) & ((~((e+g)-a)>>31)&1) & ((~((b+d)-f)>>31)&1) & ((~((f+h)-b)>>31)&1)"

rem CircleRect cx cy r rx ry rw rh       <rtn> !COLLISION! 0:false or 1:true
set "CircleRect=tx=cx, ty=cy, tx=((((cx - rx) >> 31) & 1) * rx) + ((1 - (((cx - rx) >> 31) & 1)) * (1 - ((((rx+rw) - cx) >> 31) & 1)) * cx) + (((((rx+rw) - cx) >> 31) & 1) * (rx+rw)), ty=((((cy - ry) >> 31) & 1) * ry) + ((1 - (((cy - ry) >> 31) & 1)) * (1 - ((((ry+rh) - cy) >> 31) & 1)) * cy) + (((((ry+rh) - cy) >> 31) & 1) * (ry+rh)), COLLISION=((~(r-!sqrt(n):n=((cx - tx)*(cx - tx)) + ((cy - ty)*(cy - ty))!)>>31)&1)"

REM LinePoint x1 y1 x2 y2 px py          <rtn> !COLLISION! 0:false or 1:true
set "LinePoint=d1=!sqrt(n):n=(px-x1)*(px-x1) + (py-y1)*(py-y1)!, d2=!sqrt(n):n=(px-x2)*(px-x2) + (py-y2)*(py-y2)!, ll=!sqrt(n):n=(x1-x2)*(x1-x2) + (y1-y2)*(y1-y2)!, COLLISION=((~(ll-(d1+d2))>>31)&1)"

rem LineLine x1 y1 x2 y2 x3 y3 x4 y4     <rtn> !COLLISION! 0:false or 1:true
set "LineLine=uA=10 * ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1)), uB=10 * ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1)), COLLISION=((~(uA-0)>>31)&1) & ((~(10-uA)>>31)&1) & ((~(uB-0)>>31)&1) & ((~(10-uB)>>31)&1)"

rem LineRect x1 y1 rx ry rw rh           <rtn> !COLLISION! 0:false or 1:true
set "LineRect=uA=10 * ((rx-rx)*(y1-ry) - ((ry+rh)-ry)*(x1-rx)) / (((ry+rh)-ry)*(x2-x1) - (rx-rx)*(y2-y1)), uB=10 * ((x2-x1)*(y1-ry) - (y2-y1)*(x1-rx)) / (((ry+rh)-ry)*(x2-x1) - (rx-rx)*(y2-y1)), LEFT=((~(uA-0)>>31)&1) & ((~(10-uA)>>31)&1) & ((~(uB-0)>>31)&1) & ((~(10-uB)>>31)&1),uA=10 * (((rx+rw)-(rx+rw))*(y1-ry) - ((ry+rh)-ry)*(x1-(rx+rw))) / (((ry+rh)-ry)*(x2-x1) - ((rx+rw)-(rx+rw))*(y2-y1)), uB=10 * ((x2-x1)*(y1-ry) - (y2-y1)*(x1-(rx+rw))) / (((ry+rh)-ry)*(x2-x1) - ((rx+rw)-(rx+rw))*(y2-y1)), RIGHT=((~(uA-0)>>31)&1) & ((~(10-uA)>>31)&1) & ((~(uB-0)>>31)&1) & ((~(10-uB)>>31)&1),uA=10 * (((rx+rw)-rx)*(y1-ry) - (ry-ry)*(x1-rx)) / ((ry-ry)*(x2-x1) - ((rx+rw)-rx)*(y2-y1)), uB=10 * ((x2-x1)*(y1-ry) - (y2-y1)*(x1-rx)) / ((ry-ry)*(x2-x1) - ((rx+rw)-rx)*(y2-y1)), TOP=((~(uA-0)>>31)&1) & ((~(10-uA)>>31)&1) & ((~(uB-0)>>31)&1) & ((~(10-uB)>>31)&1),uA=10 * (((rx+rw)-rx)*(y1-(ry+rh)) - ((ry+rh)-(ry+rh))*(x1-rx)) / (((ry+rh)-(ry+rh))*(x2-x1) - ((rx+rw)-rx)*(y2-y1)), uB=10 * ((x2-x1)*(y1-(ry+rh)) - (y2-y1)*(x1-rx)) / (((ry+rh)-(ry+rh))*(x2-x1) - ((rx+rw)-rx)*(y2-y1)), BOTTOM=((~(uA-0)>>31)&1) & ((~(10-uA)>>31)&1) & ((~(uB-0)>>31)&1) & ((~(10-uB)>>31)&1),COLLISION=left | right | top | bottom"