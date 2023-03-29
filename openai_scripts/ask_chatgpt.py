import os
import openai
import json

# TODO: Move this into config

# Can I talk to GPT4 here?
model = "text-davinci-003"

base_prompt = "I am a highly intelligent question answering bot. If you ask me a question that is rooted in truth, I will give you the answer. If you ask me a question that is nonsense, trickery, or has no clear answer, I will respond with \"Unknown\"."

openai.api_key = os.getenv("OPENAI_API_KEY")

# Should I extract out the paths into a variable?

base_path = os.path.dirname(os.path.realpath(__file__))

transcription_path = base_path + "/tmp/transcription.txt"
response_path = base_path +"/tmp/chatgpt_response.txt"

# transcription_path = os.path.dirname(os.path.realpath(__file__))+"/tmp/transcription.txt"
# response_path = os.path.dirname(os.path.realpath(__file__))+"/tmp/chatgpt_response.txt"

def main():
    with open(transcription_path, "r") as f:
        question = f.readlines()[0]
        full_prompt = f"{base_prompt} Q: {question} A:\n"
        print(full_prompt)

        response = openai.Completion.create(
          model=model,
          prompt=full_prompt,
          temperature=0,
          max_tokens=100,
          top_p=1,
          frequency_penalty=0,
          presence_penalty=0,
          stop=["\n"]
        )

        print(response)

        with open(response_path, "w") as f:
            f.write(response.choices[0].text)

if __name__ == "__main__":
    main()
