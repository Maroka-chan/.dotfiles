import os
import sys

output = os.popen('pw-cli | grep --line-buffered "remote 0 node 57 changed"')
while(output.readline()):
    os.system("wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d' ' -f2")
    sys.stdout.flush()
