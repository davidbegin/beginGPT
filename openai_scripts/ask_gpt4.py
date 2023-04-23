import os
import sys
import datetime
import json
from pathlib import Path
import csv

import click
import openai

# MODEL = "gpt-4"
MODEL = "gpt-3.5-turbo"

script_path = Path(__file__).resolve()
base_path = script_path.parent.parent

prompts_file = '/home/begin/code/awesome-chatgpt-prompts/prompts.csv'

default_sys_prompt_path = "/home/begin/prompt.txt"

def find_system_prompt(sys_prompt_path):
    with open(sys_prompt_path, "r") as f:
        system_prompt = f.read()
        return system_prompt


@click.command()
@click.option('--sys_prompt_path', default=default_sys_prompt_path, help='Where to save the GPT response.')
@click.option('--prompt_file', default="transcription.txt", help='Where to save the GPT response.')
@click.option('--outfile', default="chatgpt_response.txt", help='Where to save the GPT response.')
def main(sys_prompt_path, prompt_file, outfile):
    sys_prompt = find_system_prompt(sys_prompt_path)
    ask_gpt(sys_prompt, prompt_file, outfile)


def ask_gpt(sys_prompt, prompt_file, outfile):
    openai.api_key = os.getenv("OPENAI_API_KEY")
    response_path = base_path / f"tmp/current/{outfile}"
    transcription_path = base_path / "tmp/current/transcription.txt"

    with open(transcription_path, "r") as f:
        question = f.read()

        print(f"Asking ChatGPT: {question}\n")

        result = openai.ChatCompletion.create(
                model = MODEL,
                messages = [{
                    "role": "system",
                    "content": sys_prompt
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

        filename = base_path / f"tmp/gpt_responses/{timestamp}-{MODEL}.json"

        with open(filename, "w") as f:
            f.write(f"{result}")


content = "This is a test of some stuff"

if __name__ == "__main__":
    print("About to ask GPT-4")
    main()
