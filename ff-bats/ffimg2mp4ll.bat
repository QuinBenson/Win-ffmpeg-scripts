@echo off
setlocal enableDelayedExpansion
SET flag01=-ifps
SET flag02=-ofps
SET Flag03=-i
SET Flag04=-sn
SET Param01=24
SET Param02=24
SET Param03="XXX"
SET Param04=1
REM get output file (last entry on commandline)
for %%a in (%*) do set Last=%%a

REM nasty GOTO label
:LoopStart

REM get first of pair
SET ARG=%1
echo !ARG!
REM if not blank
IF NOT "!ARG!" == "" (

REM if arg is flag defined above
 If "!ARG!" == "%flag01%" ( 

  REM tilde n: n is a parameter position. Remove any quotes that might surround the parameter
  REM set first parameter holder to the second entry in pair
   SET Param01="%~2"

 )

 If "!ARG!" == "%flag02%" ( 
echo set p2
   SET Param02="%~2"

 )
 If "!ARG!" == "%flag03%" ( 
echo set p3
   SET Param03="%~2"
   )

 If "!ARG!" == "%flag04%" ( 
echo set p4
   SET Param04="%~2"
   SET extra_flags=-start_number !Param04!
 )

REM if variable is empty, exit loop
) ELSE ( GOTO :LoopEnd)

REM move two places down the argval line
Shift
Shift

REM return to top of loop
GOTO :LoopStart
:LoopEnd

REM if output filename is not blank
IF NOT "!Last!" == "" (

rem -vf format=yuv420p
ffmpeg -y -framerate !param01! !extra_flags! -i !param03! -vf format=yuv420p -r !param02! -c:v libx264 -crf 0 -preset veryslow %Last%


) else (

REM if output filename Is blank display a script usage 

echo.
ECHO Usage: ffimg2mp4 -i InputFilePattern [-ifps InputFramesPerSecond] [-ofps OutputFramesPerSecond] outputfile.mp4
)
