(SET \n=^^^
%= This defines an escaped Line Feed - DO NOT ALTER =%
)

SET MM=FOR %%# IN (1 2)DO IF %%#==2 (%=                      'v0.2a 2018/08/18 =%%\n%
%= =%FOR %%A IN (D G N T U U1 U2 X Y)DO SET $%%A=%=          '$ is used as prefix on all first-tier variables as these can't be passed into the macro, clear intitial values =%%\n%
%= =%SET $Y=4096 2048 1024 512 256 128 64 32 16 8 4 2 1%=    'binary regression for sizeOf/trailingZeros functions =%%\n%
%= =%SET $Z=0000000000000000%=                               'create constants, 9-digit controls, 4096 zeros, operator-precedence table =%%\n%
%= =%FOR %%A IN (1 2 3 4)DO SET $%%A=%%A00000000^&SET $Z=!$Z!!$Z!!$Z!!$Z!%\n%
%= =%FOR %%A IN ("( ," ": )" "T # +# -# \# /# @# $# |# {# &# <<# >>#" "||" "|&" "&&" "|" { "&" "## <>" "< > ># <#" "<#>" "<< >>" "+ -" "\ / @" $ "' } `")DO SET/A $T+=1^&SET "$O!$T!= %%~A "%\n%
%= =%IF "!$MD!"=="" SET $MD=2%=                              '$MD/maxDecimal=maximum #of decimals to return =%%\n%
%= =%IF "!$M#!"=="" SET $M#=16%=                             '$M#=maximum# of asterisks/equal-signs/tildes allowed in input, else macro will fail without warning and MM_=ERRORLEVEL=0, be sure to set this value high enough for your usage =%%\n%
%= =%IF "!$P: =!"==";" SET $P=;!$MM!%=                       'if no input (or only spaces), copy parameters from variable $MM =%%\n%
%= =%SET "$P=!$P:^={!"%=                                     'replace ^ carets(problem char#1) with { left-brace =%%\n%
%= =%SET $P=!$P:^"= !%=                                      'remove double-quotes =%%\n%
%= =%SET $P=!$P:\=/!%=                                       'assume \ backslash is / forwardslash(division), \ backslash is then used for * multiplication =%%\n%
%= =%SET $P=!$P:,=;!%=                                       'assume all expression separators are ; semi-colons, commas are then used as ? ternary-open =%%\n%
%= =%SET $P=!$P:?= , ! %=                                    'replace ? question-marks(problem char#2) with , commas =%%\n%
%= =%FOR %%A IN (+ - / @ $ # : ' { "&" "|" "<" ">" "(" ")" ";")DO SET "$P=!$P:%%~A= %%~A !"%\n%
%= =%FOR /L %%A IN (0,1,!$M#!)DO (%=                         'separate all other operators from operands =%%\n%
%=    =%FOR /F "tokens=1* delims=*" %%B IN ("!$P!")DO IF "%%C" NEQ "" SET "$P=%%B \ %%C"%= 'replace * asterisks(problem char#3) with \ backslash =%%\n%
%=    =%FOR /F "tokens=1* delims==" %%B IN ("!$P!")DO IF "%%C" NEQ "" SET "$P=%%B # %%C"%= 'replace = equal-signs(problem char#4) with # hashmark =%%\n%
%=    =%FOR /F "tokens=1* delims=~" %%B IN ("!$P!")DO IF "%%C" NEQ "" SET "$P=%%B } %%C"%= 'replace ~ tilde(problem char#5) with } right-brace =%%\n%
%=    =%SET $P=!$P:  = !)%=                                  'reduce double-spaces, replace numeric negation(-) with ` and remove unary(+), reassemble multi-char operators =%%\n%
%= =%FOR %%A IN (+ - \ / @ $ # : ' { } "&" "|" ">" "<" "(" ";" ",")DO SET "$P=!$P: %%~A - = %%~A ` !"^&SET "$P=!$P: %%~A + = %%~A !"%\n%
%= =%FOR %%A IN ("< <=<<" "> >=>>" "< >=<>" "< #=<#" "# >=#>" "> #=>#" "# #=##" "+ #=+#" "- #=-#" "\ #=\#" "/ #=/#" "@ #=@#" "$ #=$#" "| #=|#" "& #=&#" "{ #={#" "& &=&&" "| &=|&" "| |=||" "{ {={" "{ {={")DO SET "$P=!$P:%%~A!"%\n%
%= =%SET $R=MM_=%=                                           'initialize $R=return-variable-queue and feed expressions one-at-a-time into loop =%%\n%
%= =%FOR %%: IN (^"!$P: ;=^" ^"!^")DO IF %%: NEQ "" IF DEFINED $R (SET "$E=(%%~: + 0 )"%=  'begin shunting-yard(ish) parser =%%\n%
%=    =%FOR %%A IN (C Q S T V)DO SET $%%A=%=                                               'small cheat by seeding expression with '( exp + 0 )' to greatly simplify parser =%%\n%
%=    =%FOR %%A IN (^"!$E: =^" ^"!^")DO IF %%A NEQ "" IF DEFINED $R (SET/A $O=$K=0%=       'feed ops one-at-a-time into loop =%%\n%
%=       =%FOR /F %%B IN ("!$V!")DO SET $K=%%B%=                                           '$K=peek at value on top of $V=precedence-value-of-operator stack =%%\n%
%=       =%FOR /L %%B IN (1,1,17)DO IF "!$O%%B!" NEQ "!$O%%B: %%~A =!" SET $O=%%B%=        'find $O=operator-precedence of current op =%%\n%
%=       =%IF !$O!==0 (SET $Q=%%~A !$Q!%=                                                  'if no match, then it's an operand, place on top of queue =%%\n%
%=       =%)ELSE IF !$O!==3 (IF !$K! GTR 3 SET $R=^&ECHO Assignment error.^>^&2%=          'only ternary, assignments, and parenthesis are allowed below assignments =%%\n%
%=       =%)ELSE IF !$O! NEQ 1 IF !$O! LSS 16 IF !$O! LEQ !$K! (SET $T=%=                  'if not openParenthesis/openTernary(lowest) nor powerOf/unary(highest) but LEQ top of stack then process stack =%%\n%
%=          =%IF "!$S!"=="!$S:(=!" SET $R=^&ECHO Missing open parenthesis.^>^&2%=          'there should always be open-parenthesis in the stack =%%\n%
%=          =%FOR %%B IN (^"!$S: =^" ^"!^")DO IF %%B NEQ "" IF DEFINED $R (%=              'feed operators from stack one-at-a-time into loop =%%\n%
%=             =%IF !$O! LEQ !$K! (SET/A $C+=1%=                                           '$C=counter for next-queued-variable,if current operator-precedence LEQ top of stack process next operator =%%\n%
%=                =%FOR /F "tokens=1-3*" %%C IN ("!$Q!")DO (%=                             'pop operands from the top of queue =%%\n%
%=                   =%IF !$K!==17 (SET $A=%%C %%C^&SET $B=%%D %%E %%F^&IF "%%C"=="" SET $R=%=   'if unary operator =%%\n%
%=                   =%)ELSE IF %%~B==T (SET $A=%%D %%C %%E^&SET $B=%%F^&IF "%%E"=="" SET $R=%=  'if ternary operator =%%\n%
%=                   =%)ELSE SET $A=%%D %%C^&SET $B=%%E %%F^&IF "%%D"=="" SET $R=%=              'if binary operator =%%\n%
%= Start Math        =%IF DEFINED $R (SETLOCAL%=                                           'if operands are good,SETLOCAL and start math sequence =%%\n%
%= Capture Operands     =%FOR %%I IN (!$A!)DO FOR /F "tokens=* delims=-0123456789." %%J IN ("%%I")DO (SET/A $D+=1%= '$D=counter for operands =%%\n%
%=                         =%IF "%%J"=="" (SET $N!$D!=%%I)ELSE SET $N!$D!=!%%I!)%=         'determine if number or variable,capture values =%%\n%
%=                      =%FOR %%I IN (g n n1 n2 n3 u u1 u2 v)DO SET %%I=!$%%I!%=           'now it's OK to use variables other than $, set/clear new values =%%\n%
%=                      =%SET/A i=1,a=f=f1=q=s11=s12=s21=s22=t=t1=t2=t3=w=0%=              'clear start values =%%\n%
%=                      =%SET "p=%%~B"%=                                                   'capture current operator-symbol =%%\n%
%= Discover Operands    =%FOR /L %%I IN (1,1,!$D!)DO (IF "!n%%I:~0,1!"=="-" SET n%%I=!n%%I:~1!^&SET u%%I=-%=                 'separate unary from value =%%\n%
%=                         =%FOR /F "tokens=* delims=0123456789." %%J IN ("!n%%I!")DO IF "%%J" NEQ "" SET n%%I=!n%%I:%%J=!%= 'remove non-numerical portion of value =%%\n%
%=                         =%FOR /F "tokens=1-2 delims=." %%J IN ("0!n%%I!")DO FOR /F "tokens=* delims=0" %%L IN ("%%J")DO SET o%%I1=%%L^&SET o%%I2=%%K%\n%
%=                         =%IF "!o%%I1!"=="" SET o%%I1=0%=                                'capture integer+decimal portions of value, remove leading zeros, check for zero =%%\n%
%=                         =%SET o%%I=!o%%I1!!o%%I2!%=                                     'set o1/o2/o3=assembled non-padded values =%%\n%
%=                         =%FOR %%J IN (1 2)DO (SET t=!o%%I%%J!0%=                        'find length of integer/decimal portion of each value =%%\n%
%=                            =%FOR %%K IN (!$Y!)DO IF "!t:~%%K,1!" NEQ "" SET/A s%%I%%J+=%%K^&SET t=!t:~%%K!)%\n%
%=                         =%SET/A s%%I=s%%I1+s%%I2)%=                                     'set total length(s=size) of each value, then set padded values(m1=maxIntLength,m2=maxDecLength,n1/n2=padded-values) =%%\n%
%=                      =%FOR %%I IN (1 2)DO SET/A"m%%I=(s1%%I+7)/8*8"^&IF !s2%%I! GTR !s1%%I! SET/A"m%%I=(s2%%I+7)/8*8"%\n%
%=                      =%FOR %%I IN (1 2)DO FOR /F "tokens=1*" %%J IN ("!m1! !m2!")DO SET n%%I=!$Z!!o%%I1!^&SET t=!o%%I2!!$Z!^&SET n%%I=!n%%I:~-%%J!!t:~0,%%K!%\n%
%=                      =%IF "!n1!" GTR "!n2!" (SET q=1)ELSE IF "!n1!" LSS "!n2!" SET q=-1%= 'determine q=3-way compare=if abs(n1) GTR abs(n2) =%%\n%
%= Compound Assignment  =%FOR %%I IN (+ - \ / @ $ { "|" "&" "<<" ">>")DO IF %%B=="%%~I#" SET y=%%D^&SET "p=%%~I"%= 'check for compound assignments, if found, correct op and set y=return variable =%%\n%
%=                      =%SET/A d=m2,h=m1+m2,z=$MD+2%=                                     'd=decimalPlace=max padded fractional length,h=maxLength of padded int + fraction values =%%\n%
%=                      =%IF !p!==+ IF "!u2!" NEQ "!u1!" SET u2=!u1!^&SET p=-%\n%
%=                      =%IF !p!==- IF "!u2!" NEQ "!u1!" SET u2=!u1!^&SET p=+%=            'only add/subtract values with matching unaries =%%\n%
%= (`)Negative          =%IF !p!==` SET n=!n1!^&IF "!u1!"=="" SET u=-%=                    'negative - numeric negation =%%\n%
%= (#)Assignment        =%IF !p!==# SET y=%%D^&SET u=!u2!^&SET n=!n2!%=                    'assignment - set y=return variable=operand2,u=unary of answer=same as value2,n=final answer=same as value2 =%%\n%
%= (T)Ternary If        =%IF !p!==T SET u=!u1!^&SET n=!n1!^&IF !o3! EQU 0 SET u=!u2!^&SET n=!n2!%= 'ternary - set u=n=value1, if third-value=0, set u=n=value2 =%%\n%
%= (+)Addition          =%IF !p!==+ (SET u=!u1!%=                                          'addition - group values by 8 digits, add values, collect carry, assemble n=answer =%%\n%
%=                         =%FOR /L %%I IN (8,8,!h!)DO SET/A t=1!n1:~-%%I,8!+1!n2:~-%%I,8!+w,w=t/$3^&SET n=!t:~1!!n!%\n%
%=                         =%SET n=!w!!n!)%=                                               'collect carry =%%\n%
%= (-)Subtraction       =%IF !p!==- (%=                                                    'subtraction - only subtract lesser from greater, if n1>=n2 set u=u1=unary of value1, else swap n1 with n2 and set u=negative if u1=positive, then same procedure as addition without the carry =%%\n%
%=                         =%IF !q! GEQ 0 (SET u=!u1!)ELSE SET t=!n1!^&SET n1=!n2!^&SET n2=!t!^&IF "!u1!"=="" SET u=-%\n%
%=                         =%IF !q! NEQ 0 FOR /L %%I IN (8,8,!h!)DO SET/A t=3!n1:~-%%I,8!-1!n2:~-%%I,8!+w,w=t/$2-1^&SET n=!t:~1!!n!)%\n%
%=                      =%IF "!n!"=="" SET d=0%=                 'above operations require d=m2, all others require d=0, if n="" then no operations have been performed =%%\n%
%= (@)Modulo            =%IF !p!==@ SET p=/^&SET f1=1%=          'modulo - set op=division and f1/MODflag=1 =%%\n%
%= (/)Division          =%IF !p!==/ (SET/A s11+=s22,s12-=s22%=   'division+modulo - set s11/size1_int+=size2_dec,s12/size1_dec-=size2_dec =%%\n%
%=                         =%IF !s12! LSS 0 SET s12=0%=          'if size1_dec<0 set to 0 =%%\n%
%=                         =%SET/A s1=s11+s12,j=s11+z%=          's1/length_of_value1=size1_int+size1_dec,j/#of divisions=size1+$maxDecimal =%%\n%
%=                         =%SET w=!$Z!%=                        'w=remainder=$zeros =%%\n%
%=                         =%SET o1=0!o1!!$Z!%=                  'o1/non-padded value1=lead0~o1~$zeros =%%\n%
%=                         =%IF !f1!==1 SET j=0%=                'above will move decimalPlace and set j=#of divisions, if f1/MODflag=1 set j=0 because integer only =%%\n%
%=                         =%IF !j! LSS !s1! SET/A j=s1%=        'if j LSS s1/size1=length of value1 then j=size1 ie. no fraction/integer only =%%\n%
%=                         =%IF "!u1!" NEQ "!u2!" SET u=-%=      'if unaries don't match answer is negative =%%\n%
%=                         =%FOR %%I IN (!h!)DO SET n2=!$Z!!o2!^&SET n2=!n2:~-%%I!%=       'set n2/divisor=corrected/padded value2 =%%\n%
%=                         =%IF !q!==0 (SET n=1)ELSE IF !n2! EQU 0 (SET g=X^&ECHO Divide by zero error.^>^&2%\n%
%=                         =%)ELSE IF !o1! NEQ 0 FOR /L %%I IN (1,1,!j!)DO (SET t=0%=      'reset t/answer digit=0 and d/decimalPlace+=1 if GTR lengthOfDividend =%%\n%
%=                            =%IF %%I GTR !s11! SET/A d+=1%=                              'add next digit from dividend to remainder and crop to maxSize for comparison with divisor =%%\n%
%=                            =%FOR %%J IN (!h!)DO SET w=!w!!o1:~%%I,1!^&SET w=!w:~-%%J!%\n%
%=                            =%IF "!w!" GEQ "!n2!" FOR /L %%J IN (1,1,9)DO IF "!w!" GEQ "!n2!" (SET/A t+=1,t2=0%\n%
%=                               =%SET t3=!w!%=                                            'if w/remainder GTR n2/divisor then w-=n2 until it's not, t=answer digit=#of subtractions until w LSS n2 =%%\n%
%=                               =%SET w=%\n%
%=                               =%FOR /L %%K IN (8,8,!h!)DO SET/A t1=3!t3:~-%%K,8!-1!n2:~-%%K,8!+t2,t2=t1/$2-1^&SET w=!t1:~1!!w!)%\n%
%=                            =%SET n=!n!!t!)%=                                            'add t=answer digit to n/quotient/final answer =%%\n%
%=                         =%IF !f1!==1 SET u=!u1!^&SET n=!w!)%=                           'if f1/MODflag=1 set u=unary of dividend,n/answer=w/integer remainder =%%\n%
%= ($)Power Of          =%IF !p!==$ (SET p=\^&SET u2=%=                                    'powerOf - set op=multiply, check for integer/0/1 exponent =%%\n%
%=                         =%IF !s22! NEQ 0 SET o2=0^&SET g=X^&ECHO Non-integer exponent.^>^&2%\n%
%=                         =%IF !o1! LEQ 1 SET o2=0%=                                      'i=o2=0 will effectively cancel multiplication routine =%%\n%
%=                         =%SET/A i=o2,a=i/3+1,t=i%%2,n=o2=s2=1%=                         'set i=exponent,a=#of loop iterations,t=even/odd exponent,answer=non-padded value2=length of value2=1 =%%\n%
%=                         =%IF !t!==0 SET u1=)%=                                          'if exponent is even clear unary of value1, as answer will be positive =%%\n%
%= (\)Multiplication    =%IF !p!==\ (IF "!u1!" NEQ "!u2!" SET u=-%=                        'multiplication+powerOf - if unaries don't match answer is negative =%%\n%
%=                         =%FOR /L %%H IN (0,1,!a!)DO IF !i! NEQ 0 (SET/A t2=i%%2,i/=2%=  'if exponent NEQ 0 capture odd/even and halve exponent =%%\n%
%=                            =%IF !t2!==1 (SET n=%=                                       'n/answer=NULL =%%\n%
%=                               =%SET n2=0000000!o2!%=                                    'n2=0000000non-padded value2 =%%\n%
%=                               =%SET/A"d=s12+s22,h=(s2+7)/8*8"%=                         'set decimalPlace=size1_dec+size2_dec,maxSize=largest group of 8 =%%\n%
%=                               =%FOR /L %%I IN (1,1,!h!)DO SET _%%I=0%=                  'clear carry columns =%%\n%
%=                               =%FOR /L %%I IN (1,1,!s1!)DO (SET/A w=t1=0,c=%%I%=        'multiply each digit of o1 by n2 grouped by 8 =%%\n%
%=                                  =%FOR /L %%J IN (8,8,!h!)DO SET/A t=!o1:~-%%I,1!,t=t*1!n2:~-%%J,8!+w-t*$1,w=t/$1,_!c!+=t%%$1,c+=8%\n%
%=                                  =%SET _!c!=!w!)%=                                      'collect carry into the next column =%%\n%
%=                               =%FOR /L %%I IN (1,1,!c!)DO SET/A _%%I+=t1,t1=_%%I/10^&SET n=!_%%I:~-1!!n!%\n%
%=                               =%SET n=!t1!!n!)%=                                        'add all columns together, attach remainder to product =%%\n%
%=                            =%IF !i! NEQ 0 (SET n1=%=                                    'if exponent NEQ 0 square n1 by setting n2=n1 and repeating as above saving product in n1 =%%\n%
%=                               =%SET n2=0000000!o1!%\n%
%=                               =%SET/A"s12*=2,s22=d,h=(s1+7)/8*8"%\n%
%=                               =%FOR /L %%I IN (1,1,!h!)DO SET _%%I=0%\n%
%=                               =%FOR /L %%I IN (1,1,!s1!)DO (SET/A w=t1=0,c=%%I%\n%
%=                                  =%FOR /L %%J IN (8,8,!h!)DO SET/A t=!o1:~-%%I,1!,t=t*1!n2:~-%%J,8!+w-t*$1,w=t/$1,_!c!+=t%%$1,c+=8%\n%
%=                                  =%SET _!c!=!w!)%\n%
%=                               =%FOR /L %%I IN (1,1,!c!)DO SET/A _%%I+=t1,t1=_%%I/10^&SET n1=!_%%I:~-1!!n1!%\n%
%=                               =%SET n1=!t1!!n1!^&SET n2=!n!%=                           'n1=new square,n2=current answer, remove leading zeros =%%\n%
%=                               =%FOR %%I IN (1 2)DO FOR /F "tokens=* delims=0" %%J IN ("!n%%I!")DO (SET o%%I=%%J%\n%
%=                                  =%SET/A s%%I=0,t=s%%I2-z%=                             'clear size,set t=size#_dec - $maxDecimal =%%\n%
%=                                  =%IF !t! GTR 0 FOR %%K IN (!t!)DO SET/A s%%I2=z^&SET o%%I=!o%%I:~0,-%%K!%\n%
%=                                  =%SET t=!o%%I!0%=                                      'crop values to $maxDecimal,determine new length =%%\n%
%=                                  =%FOR %%K IN (!$Y!)DO IF "!t:~%%K,1!" NEQ "" SET/A s%%I+=%%K^&SET t=!t:~%%K!))))%\n%
%= Relational Ops       =%IF DEFINED u1 (IF DEFINED u2 (SET/A q*=-1)ELSE SET q=-1)ELSE IF DEFINED u2 SET q=1%= 'q=abs(n1)>abs(n2), correct using unaries u1+u2 =%%\n%
%=                      =%IF !p!==## IF !q!==0 SET f=1%=                       'relational operators =%%\n%
%=                      =%IF %%B==">" IF !q! GTR 0 SET f=1%=                   'f=flag=only set to 1(true) by logic and relational operators =%%\n%
%=                      =%IF %%B=="<" IF !q! LSS 0 SET f=1%\n%
%=                      =%IF %%B==">#" IF !q! GEQ 0 SET f=1%\n%
%=                      =%IF %%B=="<#" IF !q! LEQ 0 SET f=1%\n%
%=                      =%IF %%B=="<>" IF !q! NEQ 0 SET f=1%\n%
%=                      =%IF %%B=="<#>" SET/A n=q%\n%
%= Logical Ops          =%IF !p!==' IF !o1! EQU 0 SET f=1%=                    'logical operators - not =%%\n%
%=                      =%IF %%B=="||" IF !o1!!o2! NEQ 0 SET f=1%=             'or =%%\n%
%=                      =%IF %%B=="&&" IF !o1! NEQ 0 IF !o2! NEQ 0 SET f=1%=   'and =%%\n%
%=                      =%IF %%B=="|&" IF !o1! NEQ 0 (IF !o2! EQU 0 SET f=1)ELSE IF !o2! NEQ 0 SET f=1%= 'xor =%%\n%
%=                      =%IF !f!==1 SET n=1^&SET g= 00%=                       'if flag1=1 set n=answer=true=1 and ErrLvl=1 =%%\n%
%= Bitwise Ops          =%SET o1=!u1!!o1!^&SET o2=!u2!!o2!%=                   'bitwise operators =%%\n%
%=                      =%IF !p!==} SET/A n=~o1%=                              'passed directly to SET/A using variables as operands, so it never errors? =%%\n%
%=                      =%IF !p!=={ SET/A"n=o1^o2"%=                           'supports 32-bit signed integers only =%%\n%
%=                      =%IF %%B=="|" SET/A"n=o1|o2"%=                         'values above  2147483647 are treated as  2147483647 =%%\n%
%=                      =%IF %%B=="&" SET/A"n=o1&o2"%=                         'values below -2147483648 are treated as -2147483648 =%%\n%
%=                      =%IF %%B=="<<" SET/A"n=o1<<o2"%\n%
%=                      =%IF %%B==">>" SET/A"n=o1>>o2"%\n%
%=                      =%SET/A z-=2%\n%
%= Finalize Value       =%IF !d! NEQ 0 (FOR %%I IN (!d!)DO FOR %%J IN (!z!)DO SET n=!n:~0,-%%I!.!n:~-%%I,%%J!%\n%
%=                         =%FOR %%I IN (!$Y!)DO IF "!n:~-%%I!"=="!$Z:~-%%I!" SET n=!n:~0,-%%I!%= 'remove trailing zeros =%%\n%
%=                         =%IF "!n:~-1!"=="." SET n=!n:~0,-1!)%=                          'if d GTR 0 answer is decimal, place decimal in n cropping to $maxDecimal, if last character is decimal remove it =%%\n%
%=                      =%FOR /F "tokens=* delims=0" %%I IN ("!n!")DO SET n=%%I%=          'remove leading zeros =%%\n%
%=                      =%IF "!n!"=="" SET n=0%=                                           'if n=NULL set to 0 =%%\n%
%=                      =%IF !n! NEQ 0 SET n=!u!!n!%=                                      'if n/answer=non-zero attach unary =%%\n%
%=                      =%IF "!g!" NEQ "X" IF /I "!y:~0,4!"=="ECHO" (^<NUL SET/P=!n!%=     'if no error check for ECHO command =%%\n%
%=                         =%FOR /L %%J IN (1,1,!y:~4!)DO ECHO.%\n%
%=                         =%SET y=)%=                                         'return values from 2nd-tier SETLOCAL =%%\n%
%= Return Value         =%FOR /F "tokens=1-3 delims=;" %%I IN (^""!y!";"!n!";"!g!"^")DO (ENDLOCAL%\n%
%=                         =%IF %%I NEQ "" SET %%~I=%%~J^&SET $R=!$R!" "%%~I=%%~J%=        'if return variable present SET value and add to return-varible-queue =%%\n%
%=                         =%SET $_!$C!=%%~J%=                                             'SET value of current queued variable =%%\n%
%=                         =%SET $X=%%~K)%=                                                'SET exitcode =%%\n%
%= Resume Parser        =%IF "!$X!"=="X" SET $R=%=                             'if exitcode=X then ERROR, clear $R as halt-flag for FOR loops =%%\n%
%=                      =%SET $Q=$_!$C! !$B!%=                                 'push newly computed value on top of queue =%%\n%
%=                   =%)ELSE ECHO Missing operand.^>^&2)%=                     'otherwise operand not found =%%\n%
%=                =%FOR /F "tokens=2*" %%C IN ("!$V!")DO SET $K=%%C^&SET $V=%%C %%D%= 'pop and peek at the value stack =%%\n%
%=             =%)ELSE SET "$T=!$T! %%~B")%=                                   'rebuild remainder of symbol stack =%%\n%
%=          =%SET $S=!$T!)%=                                                   'reset stack to remainder of stack =%%\n%
%=       =%IF !$O!==2 (FOR /F "tokens=1*" %%C IN ("!$V!")DO SET $V=%%D%=       'if current op is close parenthesis/ternary =%%\n%
%=          =%FOR /F "tokens=1*" %%C IN ("!$S!")DO (SET "$S=%%D"%=             'pop both stacks, check for ternary(push new operator onto stacks) or type mismatch(error if found) =%%\n%
%=             =%IF "%%C"=="," (IF %%A==":" (SET $S=T !$S!^&SET $V=3 !$V!)ELSE SET $R=^&ECHO Missing ternary close.^>^&2)ELSE IF %%A==":" SET $R=^&ECHO Missing ternary open.^>^&2)%\n%
%=       =%)ELSE IF !$O! GTR 0 SET "$S=%%~A !$S!"^&SET $V=!$O! !$V!)%=         'else if current op is not an operand, push to top of stacks =%%\n%
%=    =%IF DEFINED $R (SET $S= !$S!%=                                          'if no errors check for empty stack and single item in operand queue =%%\n%
%=       =%IF "!$S: =!" NEQ "" (SET $R=^&ECHO Missing close parenthesis.^>^&2%='if symbol stack is not empty =%%\n%
%=       =%)ELSE FOR /F "tokens=1*" %%A IN ("!$Q!")DO (%\n%
%=          =%IF "%%~B" NEQ "" SET $R=^&ECHO Missing operator.^>^&2%=          'if more than one item in queue =%%\n%
%=          =%SET MM_=!%%~A!)))%=                                              'set MM_=final value for expression =%%\n%
%= =%IF "!$R!"=="" SET $R=MM_=^&SET MM_=0^&SET $X= 00%=                        'if error set ErrLvl=1 and MM_=0 =%%\n%
%= =%FOR /F "tokens=1-3 delims=;" %%A IN (^""!$R!";"!MM_!";"COLOR!$X!"^")DO (ENDLOCAL%= 'exit macro and return values =%%\n%
%=    =%FOR %%: IN (%%A)DO SET %%:%=                                           'process return-variable-queue =%%\n%
%=    =%SET MM_=%%~B%=                                                         'set MM_=final value of last expression =%%\n%
%=    =%%%~C)%=                                                                'set ERRORLEVEL=0/1 =%%\n%
)ELSE SETLOCAL EnableDelayedExpansion^&SET $P= ;%= [returnVar[+,-,*,/,@,$,|,^,&,<<,>>]= [ ...]] [boolean ?] ['~-]operand1 [+,-,*,/,@,$,<,>,<#,>#,##,<>,<#>,|,^,&,<<,>>,||,|&,&& operand2] [;exp2 [,exp3 [ ...up to ~300 characters]]] =%
