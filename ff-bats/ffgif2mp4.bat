@echo off
setlocal enableDelayedExpansion

REM count up number of args on command line 
set argC=0
for %%x in (%*) do Set /A argC+=1

REM proceed if two command line args only
IF /I "!argC!" EQU "2" (
    REM sed out the frame rate from the ffprobe output 
	FOR /f "tokens=1 delims=" %%i IN ('ffprobe -i %1 ^2^>^&1 ^| sed -n -E "s/^    Stream.* ([0-9][0-9]*.*) fps,.*$/\1/p"') DO SET FRED=%%i
	
REM depreciated. set variables the same to pass through automatically	
REM	REM substitute possible decimal point with 'xy' to change appearance of string
REM	SET _test=!FRED:.=xy!
SET _test=!FRED!

REM if no substitution proceed with conversion
	if !FRED! == !_test! (
	  ffmpeg -r !FRED! -i %1 -c:v libx264 -vf "fps=24,format=yuv420p" -y %2

	  ) ELSE (
	  REM depreciated. should never get called
	  echo frame rate !FRED!: execute manually
	  )
) ELSE (

	echo usage %0 gif_filename mp4_filename
)


