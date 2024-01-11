@echo off
setlocal ENABLEDELAYEDEXPANSION
set FFMPEG=call ffmpeg -hide_banner
set META=%~dpn1 - meta.txt
if not exist "%META%" (
	echo Writing "%META%"...
	%FFMPEG% -i %1 -i "" 2> "%META%"
)
for /f "tokens=1,3,4,5*" %%0 in ('findstr "Chapter.# title" "%META%"') do (
	if %%0 == Chapter (
		set START=%%2
		set START=!START:,=!
		set END=%%4
	) else if %%0 == title (
		set TITLE=%%1 %%2 %%3 %%4
		if "%%4" == "" set TITLE=%%1 %%2 %%3
		if "%%3" == "" set TITLE=%%1 %%2
		if "%%2" == "" set TITLE=%%1
		echo Writing "%~dpn1 - !TITLE!.m4a"...
		(%FFMPEG% -ss !START! -to !END! -i %1 -c:a copy -c:v copy -map_metadata -1 -map_chapters -1 "%~dpn1 - !TITLE!.m4a") 2> nul
	)
)
echo Process complete
pause
