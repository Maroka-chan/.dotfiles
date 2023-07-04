#!/bin/sh

# Set value initially
wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d' ' -f2

# Monitor pipewire for changes to the default sink and print the new volume when a change occures
DEFAULT_SINK=$(wpctl status | rg '\*' -m1 | cut -d'*' -f2 | xargs | cut -d'.' -f1)

pw-mon | rg --line-buffered 'changed:' -A1 | rg --line-buffered "id: ${DEFAULT_SINK}" | 
	while read; do 
		wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d' ' -f2
	done
