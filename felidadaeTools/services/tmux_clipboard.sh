#!/bin/bash -e
current="$(tmux show-buffer)"
if [ "$current" != "$(xclip -o -selection clipboard)" ]; then
	tmux set-buffer "$(xclip -o -selection clipboard)"
fi
