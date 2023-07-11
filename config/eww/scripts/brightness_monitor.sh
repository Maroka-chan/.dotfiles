#!/usr/bin/env bash

# Set initial value
cat /sys/class/backlight/intel_backlight/brightness;

inotifywait --event close_write --monitor /sys/class/backlight/intel_backlight/brightness |
	while read; do
		cat /sys/class/backlight/intel_backlight/brightness;
	done
