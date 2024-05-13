:_sortFWD
rem %sort[fwd]:#=stingArray%
SET "@sort[fwd]=(FOR %%S in (%%#%%) DO @ECHO %%S) ^| SORT"

:_sortREV
rem %sort[rev]:#=stingArray%
SET "@sort[rev]=(FOR %%S in (%%#%%) DO @ECHO %%S) ^| SORT /R"

:_filterFWD
rem %filter[fwd]:#=stingArray%
SET "@filter[fwd]=(FOR %%F in (%%#%%) DO @ECHO %%F) ^| SORT /UNIQ"

:_filterREV
rem %filter[rev]:#=stingArray%
SET "@filter[rev]=(FOR %%F in (%%#%%) DO @ECHO %%F) ^| SORT /UNIQ /R"