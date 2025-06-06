@echo off
echo Installing FFmpeg...

:: Create temporary directory
mkdir "C:\temp\ffmpeg" 2>nul

:: Download FFmpeg
powershell -Command "& {Invoke-WebRequest -Uri 'https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-win64-gpl.zip' -OutFile 'C:\temp\ffmpeg\ffmpeg.zip'}"

:: Extract the zip file
powershell -Command "& {Expand-Archive -Path 'C:\temp\ffmpeg\ffmpeg.zip' -DestinationPath 'C:\temp\ffmpeg' -Force}"

:: Create FFmpeg directory in Program Files
mkdir "C:\Program Files\FFmpeg" 2>nul

:: Copy FFmpeg files
xcopy /E /I /Y "C:\temp\ffmpeg\ffmpeg-master-latest-win64-gpl\bin\*" "C:\Program Files\FFmpeg"

:: Add to PATH
setx PATH "%PATH%;C:\Program Files\FFmpeg" /M

:: Clean up
rmdir /S /Q "C:\temp\ffmpeg"

echo FFmpeg has been installed successfully!
echo Please restart your terminal to use FFmpeg.
pause 