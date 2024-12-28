
usage:

call lib\FILE.bat

Now, all macros provided in that portion of the library are loaded into memory and ready to use.

For more details on specific macro usage
	1. right click the library you want to view
	2. search for macro you want to use
	3. for example: %@ellipse% x y ch cw color <rtn> $ellipse

macros        are *always* prefixed with @
macro returns are *always* prefixed with $


call lib\gfx.bat

%@ellipse% 10 10 6 6 196

echo %$ellipse%