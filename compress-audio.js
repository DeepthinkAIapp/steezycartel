const fs = require('fs');
const path = require('path');
const { exec } = require('child_process');

const BEATS_DIR = path.join(__dirname, 'public', 'music', 'beatsindex');

// Ensure ffmpeg is installed
function checkFFmpeg() {
  return new Promise((resolve, reject) => {
    exec('ffmpeg -version', (error) => {
      if (error) {
        console.error('Error: ffmpeg is not installed. Please install ffmpeg first.');
        console.error('Windows: Download from https://ffmpeg.org/download.html');
        console.error('Mac: brew install ffmpeg');
        console.error('Linux: sudo apt-get install ffmpeg');
        reject(error);
      } else {
        resolve();
      }
    });
  });
}

// Convert WAV to MP3
function convertToMP3(inputFile) {
  const outputFile = inputFile.replace('.wav', '.mp3');
  return new Promise((resolve, reject) => {
    const command = `ffmpeg -i "${inputFile}" -codec:a libmp3lame -qscale:a 2 "${outputFile}"`;
    exec(command, (error) => {
      if (error) {
        console.error(`Error converting ${inputFile}:`, error);
        reject(error);
      } else {
        console.log(`Successfully converted ${inputFile} to ${outputFile}`);
        resolve();
      }
    });
  });
}

// Main function
async function main() {
  try {
    await checkFFmpeg();
    
    const files = fs.readdirSync(BEATS_DIR);
    const wavFiles = files.filter(file => file.endsWith('.wav'));
    
    console.log(`Found ${wavFiles.length} WAV files to convert`);
    
    for (const file of wavFiles) {
      const inputPath = path.join(BEATS_DIR, file);
      await convertToMP3(inputPath);
    }
    
    console.log('All files converted successfully!');
  } catch (error) {
    console.error('Script failed:', error);
    process.exit(1);
  }
}

main(); 