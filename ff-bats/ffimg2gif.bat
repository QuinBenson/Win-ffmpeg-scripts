@echo off
setlocal enableDelayedExpansion
SET flag01=-ifps
SET flag02=-ofps
SET Flag03=-i
SET Param01="24"
SET Param02="24"
SET Param03="XXX"

REM get output file (last entry on commandline)
for %%a in (%*) do set Last=%%a

REM nasty GOTO label
:LoopStart

REM get first of pair
SET ARG=%1

REM if not blank
IF NOT "!ARG!" == "" (

REM if arg is flag defined above
 If "!ARG!" == "%flag01%" ( 

  REM tilde n: n is a parameter position. Remove any quotes that might surround the parameter
  REM set first parameter holder to the second entry in pair
   SET Param01=%~2

 )

 If "!ARG!" == "%flag02%" ( 
echo set p2
   SET Param02=%~2

 )
 If "!ARG!" == "%flag03%" ( 
echo set p3
   SET Param03=%~2

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
REM ffmpeg -i "!param03!"  -framerate !Param01! -filter_complex  "fps=!Param02!,split=2[palette_in][gif];[palette_in]palettegen[palette_out];[gif]fifo[gif_fifo]; [gif_fifo][palette_out]paletteuse" -y %Last%

ffmpeg -y -framerate !param01! -i "!param03!"  -filter_complex  "split=2[palette_in][gif];[palette_in]palettegen[palette_out];[gif]fifo[gif_fifo]; [gif_fifo][palette_out]paletteuse" -r !Param02! %Last%

REM ffmpeg -y -framerate !param01! -i !param03! -pix_fmt=yuv420p -r !param02! -c:v libx264

) else (

REM if output filename IS blank display a script usage 

echo.
ECHO Usage: ffimg2gif -i InputFilePattern [-ifps InputFramesPerSecond] [-ofps OutputFramesPerSecond] outputfile.gif
)
