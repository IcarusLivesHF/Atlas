# Batch-SubLibraries (Windows 10 or later)

A comprehensive Windows Batch Library, split into sublibraries to simplify and streamline the creation of command-line interfaces (CLIs) and text-based user interfaces (TUIs).

## Features
- **Mathematical operations**: From basic arithmetic to advanced trigonometry.
- **Graphics generation**: 2D visuals, shapes, and animations.
- **Data visualization**: Graphs, charts, and more.
- **Time-saving utilities**: Pre-written scripts for faster development.
- **Consistency and reusability**: Standardized and reusable functions.

---

## Table of Contents
1. [Getting Started](#getting-started)
2. [Usage Example](#usage-example)
3. [Library Overview](#library-overview)
4. [Purpose of `LibTrim.bat`](#purpose-of-libtrimbat)

---

## Getting Started
NOTE:

![](https://i.imgur.com/K8A01bd.png)
Clicking the 'Function List' icon in Notepad++

Will open up the list of functions provided in a given library

![](https://i.imgur.com/esZMcSb.png)

## Usage Example
 ```batch
@echo off & setlocal enableDelayedExpansion

call lib\stdlib 80 60
call lib\math

rem after this line, you have all of the variables and macros from the libraries called above.

pause
exit
```



## Library Overview
# Table of Contents #
	This is **NOT** a complete list of functions/abilities provided by these libraries.
	Please feel free to look inside the source code of any of the library files to see
	what else may be available to you.

 	This is the primary piece of the library. You *will* need to call lib\stdlib to use any other library.

	call lib\stdlib wid hei /multithread
		empties environment
		\n
		\e
		@32bitlimit
		wid/width , hei/height
		rem if /multithread
			%@multithread% main controller "path" "%~f0" <- last argument *must* be %~f0

	call lib\3Dbox
		%@box% x y sizeX sizeY sizeZ angleX angleY angleZ <rtn> !$box!

	call lib\3x4font.bat "string"
 
	call lib\array_operations
		%@shuffle[Array]% <input:*[]> <len:int>
		%@reverse[Array]% <input:*[]> <len:int>
		%arrayContains% <input:*[]> <len:int> "value"
		%@arrayToList% <input:*[]> <len:int> listName
		%@listToArray% <input:*[]> <len:int> arrayName
		%@bubble[list]% %list%;newList
		%@selection[list]% %list%;newList
		
	call lib\buttons
		%@makeButton% x y ID 'string'
		%@killButton% 1 4 5 2 3 6 - to kill any or all buttons
		%@makeSlider% x y length min max sliderColor positionColor
		%makeInputBar% rtnVar x y length TextColor BackColor
		
	call lib\calendar x y
		echo %$calendar%
		%@calendar.click% /l1,/l2,/r1,/r2
		
	call lib\collision -> will probably rewrite these
		PointPoint x1 y1 x2 y2                      <rtn> !COLLISION! 0:false or 1:true
		PointCircle x1 y1 cx cy r                   <rtn> !COLLISION! 0:false or 1:true
		CircleCircle c1x c1y c1r c2x c2y c2r        <rtn> !COLLISION! 0:false or 1:true
		PointRect px py rx ry rw rh                 <rtn> !COLLISION! 0:false or 1:true
		RectRect r1x r1y r1w r1h r2x r2y r2w r2h    <rtn> !COLLISION! 0:false or 1:true
		CircleRect cx cy r rx ry rw rh              <rtn> !COLLISION! 0:false or 1:true
		LinePoint x1 y1 x2 y2 px py                 <rtn> !COLLISION! 0:false or 1:true
		LineCircle x1 y1 x2 y2 cx cy r              <rtn> !COLLISION! 0:false or 1:true
		LineLine x1 y1 x2 y2 x3 y3 x4 y4            <rtn> !COLLISION! 0:false or 1:true
		LineRect x1 y1 rx ry rw rh                  <rtn> !COLLISION! 0:false or 1:true
		LineRect_EDGE x1 y1 rx ry rw rh             <rtn> !COLLISION! !top! !bottom! !left! !right! 0:false or 1:true
		
	call lib\encoding
		%@toHex% INT <rtn> !$hex!
		%hexToBase2% 1B out <rtnVar>
		%hexToBase4% 1B out <rtnVar>
		%encode% "string" <rtn> base64
		%decode:?=!base64!% <rtn> plainText.txt
		
	call lib\gfx
		%while% ( condition %end.while% )
		%@point% y;x 2/5;0-255;0-255;0-255
		%@ellipse% x y ch cw color <rtn> $ellipse
		%@circle% cx cy cr COLOR <rtn> !$circle!
		%@rect% x y w h <rtn> !$rect!
		%@fillRect% x y w h color <rtn> !$fillRect!
		%@roundrect% x y w h r color <rtn> !$roundrect!
		%@bezier% x1 y1 x2 y2 x3 y3 x4 y4 color <rtn> !$bezier!

	call lib\gfxline dda/bresenham -> default = DDA
		%@line% x0 y0 x1 y1 color <rtn> $line
		
	call lib\gfxtra
		%@bar% currentValue maxValue MaxlengthOfBar
		%@sevenSegmentDisplay% x y value color <rtn> $sevenSegmentDisplay
		%@msgBox% ;title;text;x;y;textColor;boxColor;boxLength
		%@arc% x y size DEGREES(0-360) arcRotationDegrees(0-360) lineThinness color
		rem MUST CALL lib\gfxline to obtain %@line% first
			%@triangle% x0 y0 x1 y1 x2 y2 <rtn> !$triangle!
			%@quad% x0 y0 x1 y1 x2 y2 <rtn> !$quad!
		%@AAline% x0 x1 y0 y1 <rtn> !$AAline!
		
	call lib\gfxUtil
		%@getDim% - get current dimensions of window <rtn> !wid! !width! !hei! !height!
		%@delay:x=10%
		%@background% color1 color2 lineColor2Starts
		%@fullscreen%
		%HSL.RGB% 0-3600 0-10000 0-10000 <rtn> r g b
		%@fps% <rtn> deltaTime, FPS, $TT, $min, $sec, frameCount
		
	call lib\logicGates
		lss(x,y) <rtn> 0:false or 1:true
		leq(x,y) <rtn> 0:false or 1:true
		gtr(x,y) <rtn> 0:false or 1:true
		geq(x,y) <rtn> 0:false or 1:true
		equ(x,y) <rtn> 0:false or 1:true
		neq(x,y) <rtn> 0:false or 1:true
		and(b1,b2) <rtn> 0:false or 1:true
		or(b1,b2) <rtn> 0:false or 1:true
		xor(b1,b2) <rtn> 0:false or 1:true
		tern(bool,v1,v2)  <rtn> ?:
		
	call lib\math
		sin deg/rad
		cos deg/rad
		rotate
		sqrt
		abs
		dist
		map
		lerp
		interpolate
		clamp
		randomMagnitude
		pow

	call lib\misc
		gravity
		smoothstep
		bitcolor
		rndrbg
		det
		dot
		randomRangeBoundary
		randomRange
		kappa
		every
		@avg
		sign
		getState
		index
		max
		min
		swap
		cmp
		BBA
		checkBounds
		hypot
		matrixMul_2x2
		matrixMul_3x3
		@log2
		@log10
		
	security.bat -> needs to be turned into macros, not complete, can still be used as functions
		:scriptGuard
		:executionLimit
		:machineLock
		:dateExpiry
			
	call lib\util
		%@getAdmin%
		%@download% url file - to remain backward compatible, PowerShell.
		%@unique%
		%getlen% var <rtn> $len
		%string_properties% "string" <rtn> $, $_rev $_upp $_low

	call lib\turtleGFX
		%turtle.forward% X
		%turtle.backward% X
		%turtle.left% 90
		%turtle.right% 90
		%turtle.setx% 90
		%turtle.sety% 90
		%turtle.setHeading% 45
		%turtle.goto% x y - will draw line to location
		%turtle.teleport% x y - will NOT draw line to location
		%turtle.define% x y heading - redefine turtle properties
		%turtle.circle% width height - draws ellipse at location
		%turtle.color% R G B - set turtle color
		%turtle.HSLtoRGB% HUE SAT LUM - set turtle color
		%turtle.stamp% - stamp screen with stamp.id
		%turtle.dot% - stamp screen with dot
		%turtle.plot% - stamp screen with dot
		%turtle.screenSize% wid hei - set screen size
		%turtle.push% save location and heading to array
		%turtle.pop% return to saved location
		%turtle.home% - send turtle to 0,0
		%turtle.center% - send turtle to middle screen
		%turtle.penDown% - begin draw
		%turtle.penUp% - stop draw
		%turtle.clearScreen% - clear screen

## Purpose of `LibTrim.bat`
    + Click and Drag your sketch onto `LibTrim.bat` to zip your sketch project
    + the libraries used inside `SKETCH.bat` will be zipped for you *automatically*

![](https://imgur.com/J14yz7J.gif)
