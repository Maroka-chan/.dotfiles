#!/usr/bin/env bash

tmp_loc="/tmp/eww_scripts"
test -d ${tmp_loc} || mkdir -p ${tmp_loc}
proc_file="${tmp_loc}/radio_proc"
test -f ${proc_file} || echo 0 > ${proc_file}
radio_proc=$(cat "${proc_file}")

player=mpv
stream="http://jpopsuki.fm:8000/autodj.m3u"

if [ $radio_proc -eq 0 ]
then
  $player $stream &
  echo $! > ${proc_file}
elif [ "$(ps -p ${radio_proc} -o args | grep -o 'mpv.*')" = "${player} ${stream}" ]
then
  kill -KILL $radio_proc
  echo 0 > ${proc_file}
else
  echo 0 > ${proc_file}
fi
