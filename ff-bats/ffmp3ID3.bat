
REM ffmpeg driver taking filename, assuming last two characters are part numbers and setting metadata based on these values and a global writer and publisher
SETLOCAL enabledelayedexpansion
REM TCOM
SET m_composer=John Buchan
REM TPE2
SET m_album_artist=%m_composer%
REM TPE1
SET m_artist=%m_composer%
REM TPUB
SET m_publisher=BBC               
FOR %%F IN ( *.ra* ) DO (

    SET l_Filename=%%F
	REM TIT2??? HOW?
    SET l_basename=%%~nF
	REM TALB
    SET l_album=!l_basename:~0,-3!
	REM TRCK
    SET l_track=!l_basename:~-2!
	
	
echo ffmpeg -i "!l_Filename!" -metadata album="!l_album!" -metadata composer="%m_composer%" -metadata album_artist="%m_album_artist%" -metadata artist="%m_artist%" -metadata title="!l_album! Part !l_track!" -metadata track="!l_track!" -metadata publisher="%m_publisher%" -c copy -y  "!l_basename!.mp3"

REM -metadata album="!l_album!" -metadata composer="%m_composer%" -metadata album_artist="%m_album_artist%" -metadata artist="%m_artist%" -metadata title="!l_album! Part !l_track!" -metadata track="!l_track!" -metadata publisher="%m_publisher%" -y "!l_basename!.mp3"

)
