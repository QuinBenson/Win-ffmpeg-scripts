REM ffmpeg -i "Ukulele playalong 0.01 H.mp4" -c:v libx264 -crf 32 -preset veryslow UP0.01H_crf32vs.mp4
setlocal enableDelayedExpansion

set argC=0
for %%x in (%*) do Set /A argC+=1

if %argC% == 1 (

SET outfile=%~n1_crf32vs%~x1
REM echo ffmpeg -i "%~1" -c:v libx264 -crf 32 -preset veryslow !outfile!
ffmpeg -i "%~1" -c:v libx264 -crf 32 -preset veryslow -y "%~n1_crf32vs%~x1"

)
