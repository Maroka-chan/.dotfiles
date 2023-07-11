#!/usr/bin/env bash

# Monitor pipewire for changes to the default sink and print the new volume when a change occures
DEFAULT_SINK=$(wpctl status | rg '\*' -m1 | cut -d'*' -f2 | xargs | cut -d'.' -f1)

if [ "$1" = "get-volume" ]; then
	# Set value initially
	wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d' ' -f2

	pw-mon | rg --line-buffered 'changed:' -A1 | rg --line-buffered "id: ${DEFAULT_SINK}" | 
		while read; do 
			wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d' ' -f2
		done
fi

if [ "$1" = "get-muted" ]; then
	# Set value initially
	muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d' ' -f3)
	if [ "$muted" = "[MUTED]" ]; then
		echo true
	else
		echo false
	fi

	pw-mon | rg --line-buffered 'changed:' -A1 | rg --line-buffered "id: ${DEFAULT_SINK}" | 
		while read; do 
			muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d' ' -f3)
			if [ "$muted" = "[MUTED]" ]; then
				echo true
				continue
			fi
			echo false
		done
fi
