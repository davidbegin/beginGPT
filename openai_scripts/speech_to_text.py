import os
import openai
from pathlib import Path

openai.api_key = os.getenv("OPENAI_API_KEY")

script_path = Path(__file__).resolve()
parent_dir = script_path.parent.parent

audio_path = parent_dir / "tmp/current/outfile.wav"
transcription_path = parent_dir / "tmp/current/transcription.txt"

def main():
    audio_file= open(audio_path, "rb")

    transcript = openai.Audio.transcribe("whisper-1", audio_file)

    print(transcript)

    with open(transcription_path, "w") as f:
        f.write(transcript.text)

if __name__ == "__main__":
    main()
