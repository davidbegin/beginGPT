#!/bin/sh

ps -ef | grep .wav | grep -v grep | awk '{print $2}' | xargs kill -9
