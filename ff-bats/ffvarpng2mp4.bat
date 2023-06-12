@echo off
REM Ah. The fps option blows things up. Use the -framerate 25 for the output
REM script to create video output from variably sized stills input
 
set ArgCount=0
for %%x in (%*) do Set /A ArgCount+=1

REM expects 2 arguments. If 2 args not present, output usage statement
IF %ArgCount% EQU 2 (

REM SET scale_X=1024
REM SET scale_Y=768

REM output size
SET scale_X=1920
SET scale_Y=1080
REM SET debug="-report"

ffmpeg %debug% -framerate 1 -i "%1"  -r 25 -filter_complex "format=yuv420p,scale=%scale_X%:%scale_Y%:force_original_aspect_ratio=decrease,pad=%scale_X%:%scale_Y%:x=(%scale_X%-iw)/2:y=(%scale_Y%-ih)/2:color=0x034f20" "%2"

) ELSE echo.&echo USAGE: %0 input_filename_pattern output_video_name




REM ffmpeg  -framerate 1 -i "2018_vector_elements_%2d.png"  -r 25 -filter_complex "format=yuv420p,scale=1024:768:force_original_aspect_ratio=decrease,pad=1024:768:x=(1024-iw)/2:y=(768-ih)/2:color=green" "fred.mp4"