#!/usr/bin/env bash

tmp_loc="/tmp/eww_scripts/radio"
test -d ${tmp_loc} || mkdir -p ${tmp_loc}

lock_file="${tmp_loc}/radio_lock"
(
flock -n 200 || exit 1

proc_file="${tmp_loc}/radio_proc"
test -f ${proc_file} || echo 0 > ${proc_file}
proc_cmd_file="${tmp_loc}/radio_proc_cmd"
test -f ${proc_cmd_file} || echo 0 > ${proc_cmd_file}

radio_proc=$(cat "${proc_file}")
radio_proc_cmd=$(cat "${proc_cmd_file}")

player=mpv
stream=$1

kill_instance () {
  if [ "$(ps -p ${radio_proc} -o args | grep -o 'mpv.*')" = "${radio_proc_cmd}" ]
  then
    kill -KILL $radio_proc
  fi

  echo 0 > ${proc_file}
  echo "" > ${proc_cmd_file}
  eww update isMusicPlaying=false

  radio_proc=$(cat "${proc_file}")
  radio_proc_cmd=$(cat "${proc_cmd_file}")
}

if [ ! -z "${radio_proc_cmd}" ] && [ "$player $stream" != "${radio_proc_cmd}" ]
then
  kill_instance
fi

if [ $radio_proc -eq 0 ]
then
  $player $stream &
  pid=$!
  echo $pid > ${proc_file}
  echo "$player $stream" > ${proc_cmd_file}
  eww update isMusicPlaying=true
  flock --unlock 200
  exit
fi

kill_instance

) 200>$lock_file
