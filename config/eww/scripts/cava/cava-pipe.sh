#!/usr/bin/env bash

printf "
[general]
framerate=60
bars = 16
[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
" | cava -p /dev/stdin | sed -u 's/;//g;s/0/▁/g;s/1/▂/g;s/2/▃/g;s/3/▄/g;s/4/▅/g;s/5/▆/g;s/6/▇/g;s/7/█/g; '
