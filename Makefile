ptest:
	./GoBeginGPT/bin/GoBeginGPT -prompt_file tmp/current/transcription.txt

current:
	play tmp/current/outfile.wav

debug:
	animate_scripts/animate.sh snoop-dogg_0 /home/begin/code/BeginGPT/tmp/voices/duet/snoop-dogg_0.txt duet

# .PHONY
duet:
	python openai_scripts/ask_gpt4.py                                              \
		--sys_prompt_path "/home/begin/code/BeginGPT/prompts/duet.txt" \
		--prompt_file "duet.txt"                                                     \
		--outfile "duet.txt"
