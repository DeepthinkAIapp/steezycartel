# Create a temporary directory
$tempDir = "C:\temp\ffmpeg"
New-Item -ItemType Directory -Force -Path $tempDir

# Download FFmpeg
$url = "https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-win64-gpl.zip"
$output = "$tempDir\ffmpeg.zip"
Write-Host "Downloading FFmpeg..."
Invoke-WebRequest -Uri $url -OutFile $output

# Extract the zip file
Write-Host "Extracting FFmpeg..."
Expand-Archive -Path $output -DestinationPath $tempDir -Force

# Create FFmpeg directory in Program Files
$installDir = "C:\Program Files\FFmpeg"
New-Item -ItemType Directory -Force -Path $installDir

# Copy FFmpeg files
Write-Host "Installing FFmpeg..."
Copy-Item "$tempDir\ffmpeg-master-latest-win64-gpl\bin\*" -Destination $installDir -Force

# Add FFmpeg to system PATH
$currentPath = [Environment]::GetEnvironmentVariable("Path", "Machine")
if ($currentPath -notlike "*$installDir*") {
    [Environment]::SetEnvironmentVariable("Path", "$currentPath;$installDir", "Machine")
}

# Clean up
Write-Host "Cleaning up..."
Remove-Item -Path $tempDir -Recurse -Force

Write-Host "FFmpeg has been installed successfully!"
Write-Host "Please restart your terminal to use FFmpeg." 