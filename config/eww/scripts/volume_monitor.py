import os

output = os.popen('pw-cli | grep --line-buffered "remote 0 node 58 changed"')
while(output.readline()):
    os.system("wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d' ' -f2")
