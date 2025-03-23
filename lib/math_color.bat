set "lerp=((a + c * (b - a) * 10) / 1000 + a)" & rem dependency |
rem -------------------------------------------------------------




rem set /a "r0=0-255", "g0=0-255", "b0=0-255", "r1=0-255", "g1=0-255", "b1=0-255", "c=0-100, %lerpRGB%"
set "@lerpRGB=(a=r[0], b=r[1], $r=%lerp%, a=g[0], b=g[1], $g=%lerp%, a=b[0], b=b[1], $b=%lerp%)"



rem set /a "h=0-3600, s=0-10000, l=0-10000, %@hsl.rgb%" <rtn> !r! !g! !b!
set "HSL(n)=k=(n*100+(h %% 3600)/3) %% 1200, $x=k-300, $y=900-k, $x=$y-(($y-$x)&(($x-$y)>>31)), $x=100-((100-$x)&(($x-100)>>31)), max=$x-(($x+100)&(($x+100)>>31))"
set "@HSL.RGB=(%HSL(n):n=0%", "r=(l-(s*((10000-l)-(((10000-l)-l)&((l-(10000-l))>>31)))/10000)*max/100)*255/10000","%HSL(n):n=8%", "g=(l-(s*((10000-l)-(((10000-l)-l)&((l-(10000-l))>>31)))/10000)*max/100)*255/10000", "%HSL(n):n=4%", "b=(l-(s*((10000-l)-(((10000-l)-l)&((l-(10000-l))>>31)))/10000)*max/100)*255/10000)"
set "hsl(n)="



rem set /a "r=0-255, g=0-255, b=0-255, %@rgb.hsl%" <rtn> !h! !s! !l!
set "@rgb.hsl=($a=r*10000/255,$b=g*10000/255,$c=b*10000/255,$d=((($a-$b)>>31)&1),$e=$d*$b+(1-$d)*$a,$f=((($e-$c)>>31)&1),$g=$f*$c+(1-$f)*$e,$h=((($a-$b)>>31)&1),$i=$h*$a+(1-$h)*$b,$j=((($i-$c)>>31)&1),$k=$j*$i+(1-$j)*$c,$l=$g-$k,$m=((~(($l>>31)|((-$l)>>31)))&1),L=($g+$k)/2,$n=2*L-10000,$o=($n>>31)&1,$p=$o*(-$n)+(1-$o)*$n,S=(1-$m)*($l*10000/((10000-$p)+$m)),$q=((~((($g-$a)>>31)|(($a-$g)>>31)))&1),$r=((~((($a-$b)>>31)|(($b-$a)>>31)))&1),$s=(1-$r)*((~((($g-$b)>>31)|(($b-$g)>>31)))&1),$t=((~((($g-$c)>>31)|(($c-$g)>>31)))&1),$u=$q+$s+$t,$v=$l+$m,$w=($b-$c)/$v,$x=($c-$a)/$v,$y=($a-$b)/$v,$z=60*10000*$w,$aa=60*10000*$x+120*10000,$ab=60*10000*$y+240*10000,$ac=$m*0+(1-$m)*(($q*$z+$s*$aa+$t*$ab)/$u),$ad=360*10000,$ae=$ac%%$ad,H=($ae+((($ae)>>31)&1)*$ad)/1000)"



rem set /a "r0=0-255, g0=0-255, b0=0-255, r1=0-255, g1=0-255, b1=0-255, %@mixRGB%"
set "@mixRGB=(r=r0,g=g0,b=b0, %@rgb.hsl%, h0=h,s0=s,l0=l, r=r1,g=g1,b=b1, %@rgb.hsl%, h1=h,s1=s,l1=l, h=(H0+H1)/2, s=(S0+S1)/2, l=(L0+L1)/2, %@hsl.rgb%)"
