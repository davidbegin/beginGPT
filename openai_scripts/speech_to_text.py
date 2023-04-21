import os
import time
import openai
from pathlib import Path
from subprocess import Popen, PIPE
import subprocess

openai.api_key = os.getenv("OPENAI_API_KEY")

script_path = Path(__file__).resolve()
parent_dir = script_path.parent.parent

audio_path = parent_dir / "tmp/current/outfile.wav"
transcription_path = parent_dir / "tmp/current/transcription.txt"
recordings_archive_dir = parent_dir / "begin_voice_recordings"

def main():
    audio_file= open(audio_path, "rb")

    transcript = openai.Audio.transcribe("whisper-1", audio_file)

    print(transcript)

    with open(transcription_path, "w") as f:
        f.write(transcript.text)
    
    # TODO: ponder what is the ideal extension for storing these archive files
    archive_file = f"{recordings_archive_dir}/{time.time()}.ogg"


    process = subprocess.run(
        [
            "ffmpeg",
            "-i",
            audio_path,
            "-metadata",
            f"title=\"{transcript.text}\"",
            archive_file
        ], check=True)

if __name__ == "__main__":
    main()
