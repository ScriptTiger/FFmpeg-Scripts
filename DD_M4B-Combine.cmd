@echo off
setlocal ENABLEDELAYEDEXPANSION

echo Initializing...
set FFMPEG=call ffmpeg -hide_banner -v -8
set FFPROBE=call ffprobe -hide_banner -v -8
set COUNT=-1
set FFCONCAT=%~1\ffconcat.txt
set CHAPTERS=%~1\chapters.txt
set OUT=%~1.m4b

echo Counting input files...
for /f %%0 in ('dir /b %1 ^| findstr /b [0-9][0-9]*_') do set /a COUNT=!COUNT!+1

echo Looking for cover art...
for /f %%0 in ('dir /b %1 ^| findstr /b cover[.]') do set COVER=%%0

echo Writing ffconcat file...
echo ffconcat version 1.0>"%FFCONCAT%"
(
	for /l %%0 in (0,1,!%COUNT%) do (
		for /f "tokens=*" %%a in ('dir /b %1 ^| findstr /b %%0_') do (
			call :SafePath "%~1\%%a"
			echo file '!FFPATH!'
		)
	)
) >> "%FFCONCAT%"

echo Writing chapters metadata file...
set TS=0
echo ;FFMETADATA1>"%CHAPTERS%"
(
	for /l %%0 in (0,1,!%COUNT%) do (
		for /f "tokens=*" %%a in ('dir /b %1 ^| findstr /b %%0_') do (
			for /f %%b in ('%FFPROBE% -select_streams 0 -show_entries stream^=duration -of csv^=p^=0 "%~1\%%a"') do (
				set TITLE=%%~na
				set TITLE=!TITLE:%%0_=!
				set DURATION=%%b
				set DURATION=!DURATION:.=!
				echo [CHAPTER]
				echo TIMEBASE=1/1000
				echo START=!TS!
				set /a TS=!TS!+!DURATION:~,-3!
				echo END=!TS!
				echo title=!TITLE!
			)
		)
	)
) >> "%CHAPTERS%"

echo Writing audiobook...
if "%COVER%"=="" (
	%FFMPEG% -f concat -safe 0 -i "%FFCONCAT%" -i "%CHAPTERS%" -map 0:a -map_chapters 1 -c copy -f mp4 -brand mp42 -movflags +faststart "%OUT%"
) else (
	%FFMPEG% -f concat -safe 0 -i "%FFCONCAT%" -i "%CHAPTERS%" -i "%~1\%COVER%" -map 0:a -map_chapters 1 -map 2:v -c copy -disposition:v:0 attached_pic -f mp4 -brand mp42 -movflags +faststart "%OUT%"
)

echo Process complete
pause
exit /b

:SafePath
set FFPATH=%~1
exit /b
