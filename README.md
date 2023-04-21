# BeginGPT

A collection of scripts and code for interacting with AI in various ways.

It's being used heavily on beginbot's Twitch stream right now, and is very likely to change a lot.

## Types of Scripts

- Audio Scripts
    - Starting and Stopping Recording
    - Killing running Audio
- Scripts to generate lip-sync animations based on Audio data
- Python Scripts for interacting with OpenAI's API
- There is a submodule [GoBeginGPT](https://github.com/davidbegin/GoBeginGPT)

## Audio Workflow

Step 1: Record locally
    - Use Sox

mod+p - start_recording
mod+i - skybox
mod+u - Gpt

----

```i3-config
bindsym $mod+p			exec --no-startup-id /home/begin/code/BeginGPT/start_recording.sh
bindsym $mod+o			exec --no-startup-id /home/begin/code/BeginGPT/stop_recording.sh
bindsym $mod+y			exec --no-startup-id /home/begin/code/BeginGPT/transcribe_recording.sh
bindsym $mod+i			exec --no-startup-id /home/begin/code/BeginGPT/voice_to_skybox.sh
bindsym $mod+u			exec --no-startup-id /home/begin/code/BeginGPT/voice_to_gpt.sh


bindsym $mod+g			exec --no-startup-id gpt
bindsym $mod+b			exec --no-startup-id /home/begin/code/BeginGPT/audio_scripts/kill_voice.sh
bindsym $mod+v			exec --no-startup-id /home/begin/code/BeginGPT/audio_scripts/choose_voice.sh
```


