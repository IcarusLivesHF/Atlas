set "sqrt(N)=( M=(N),j=M/(11264)+40, j=(M/j+j)>>1, j=(M/j+j)>>1, j=(M/j+j)>>1, j=(M/j+j)>>1, j=(M/j+j)>>1, j+=(M-j*j)>>31 )"

:_collision
REM %collisionRectRect% x1 y1 w1 h1 x2 y2 w2 h2   <rtn> !COLLISION! 0:false or 1:true
set "collisionRectRect=COLLISION=((~((a+c)-e)>>31)&1) & ((~((e+g)-a)>>31)&1) & ((~((b+d)-f)>>31)&1) & ((~((f+h)-b)>>31)&1)"

rem %collisionCircleRect% cx cy r rx ry rw rh     <rtn> !COLLISION! 0:false or 1:true
set "collisionCircleRect=tx=cx, ty=cy, tx=((((cx - rx) >> 31) & 1) * rx) + ((1 - (((cx - rx) >> 31) & 1)) * (1 - ((((rx+rw) - cx) >> 31) & 1)) * cx) + (((((rx+rw) - cx) >> 31) & 1) * (rx+rw)), ty=((((cy - ry) >> 31) & 1) * ry) + ((1 - (((cy - ry) >> 31) & 1)) * (1 - ((((ry+rh) - cy) >> 31) & 1)) * cy) + (((((ry+rh) - cy) >> 31) & 1) * (ry+rh)), COLLISION=((~(r-!sqrt(n):n=((cx - tx)*(cx - tx)) + ((cy - ty)*(cy - ty))!)>>31)&1)"

rem collisionLineLine x1 y1 x2 y2 x3 y3 x4 y4     <rtn> !COLLISION! 0:false or 1:true
set "collisionLineLine=uA=10 * ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1)), uB=10 * ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1)), COLLISION=((~(uA-0)>>31)&1) & ((~(10-uA)>>31)&1) & ((~(uB-0)>>31)&1) & ((~(10-uB)>>31)&1)"

rem collisionLineRect x1 y1 rx ry rw rh           <rtn> !COLLISION! 0:false or 1:true
set "collisionLineRect=uA=10 * ((rx-rx)*(y1-ry) - ((ry+rh)-ry)*(x1-rx)) / (((ry+rh)-ry)*(x2-x1) - (rx-rx)*(y2-y1)), uB=10 * ((x2-x1)*(y1-ry) - (y2-y1)*(x1-rx)) / (((ry+rh)-ry)*(x2-x1) - (rx-rx)*(y2-y1)), LEFT=((~(uA-0)>>31)&1) & ((~(10-uA)>>31)&1) & ((~(uB-0)>>31)&1) & ((~(10-uB)>>31)&1),uA=10 * (((rx+rw)-(rx+rw))*(y1-ry) - ((ry+rh)-ry)*(x1-(rx+rw))) / (((ry+rh)-ry)*(x2-x1) - ((rx+rw)-(rx+rw))*(y2-y1)), uB=10 * ((x2-x1)*(y1-ry) - (y2-y1)*(x1-(rx+rw))) / (((ry+rh)-ry)*(x2-x1) - ((rx+rw)-(rx+rw))*(y2-y1)), RIGHT=((~(uA-0)>>31)&1) & ((~(10-uA)>>31)&1) & ((~(uB-0)>>31)&1) & ((~(10-uB)>>31)&1),uA=10 * (((rx+rw)-rx)*(y1-ry) - (ry-ry)*(x1-rx)) / ((ry-ry)*(x2-x1) - ((rx+rw)-rx)*(y2-y1)), uB=10 * ((x2-x1)*(y1-ry) - (y2-y1)*(x1-rx)) / ((ry-ry)*(x2-x1) - ((rx+rw)-rx)*(y2-y1)), TOP=((~(uA-0)>>31)&1) & ((~(10-uA)>>31)&1) & ((~(uB-0)>>31)&1) & ((~(10-uB)>>31)&1),uA=10 * (((rx+rw)-rx)*(y1-(ry+rh)) - ((ry+rh)-(ry+rh))*(x1-rx)) / (((ry+rh)-(ry+rh))*(x2-x1) - ((rx+rw)-rx)*(y2-y1)), uB=10 * ((x2-x1)*(y1-(ry+rh)) - (y2-y1)*(x1-rx)) / (((ry+rh)-(ry+rh))*(x2-x1) - ((rx+rw)-rx)*(y2-y1)), BOTTOM=((~(uA-0)>>31)&1) & ((~(10-uA)>>31)&1) & ((~(uB-0)>>31)&1) & ((~(10-uB)>>31)&1),COLLISION=left | right | top | bottom"
