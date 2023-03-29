import os
import datetime
import openai
import json
from pathlib import Path
import csv

MODEL = "gpt-4"

script_path = Path(__file__).resolve()
base_path = script_path.parent.parent

def main():
    # TODO: Update this to be more agnostic
    PRIMER_KEY = "/home/begin/prompt.txt"

    file = open(PRIMER_KEY, "r")
    lines = file.readlines()
    if len(lines) > 0:
        key = lines[0]
    else:
        key = ""
    
    print( f"PRIMER {PRIMER_KEY} | {key}" )
    # Also we should add the ability to add another file here:
    #     and let users choose
    # TODO: update this path to be more agnostic
    with open('/home/begin/code/awesome-chatgpt-prompts/prompts.csv', newline='') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            # print(row['prompt'])

            # TODO: Add a warning if the prompt is not found
            # don't silently fail
            if row['act']  == key.strip():
                print(row['prompt'])

                primer = row['prompt']
                print("About to realllly ask")
                ask_gpt(primer)


def ask_gpt(primer):
    openai.api_key = os.getenv("OPENAI_API_KEY")
    response_path = base_path / "tmp/chatgpt_response.txt"
    transcription_path = base_path / "tmp/transcription.txt"

    # So we need to read in the Primer Base
    # then read in the info
    with open(transcription_path, "r") as f:
        question = f.read()

        print(f"Asking ChatGPT: {question}\n")
        result = openai.ChatCompletion.create(
                model = MODEL,
                messages = [{
                    "role": "system",
                    "content": primer
                    }, {
                    "role": "user",
                    "content": question 
                }])

        print(result['choices'][0]['message']['content'])

        with open(response_path, "w") as f:
            f.write(result['choices'][0]['message']['content'])


        # Save the Raw response
        now = datetime.datetime.now()
        timestamp = now.strftime("%Y_%m_%d-%H_%M_%S")
        filename = base_path / f"gpt_responses/{timestamp}-{MODEL}.json"

        with open(filename, "w") as f:
            f.write(f"{result}")

if __name__ == "__main__":
    print("About to ask GPT-4")
    main()
