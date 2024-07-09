#!/usr/bin/bash

# Here we test regular expression which extracts durarion of sesssions
# from 'last.txt' file.

#  Dummy variables which are to be replaced with dynamic ones in main script.
username="aspanov"
procname="tty7"
dayweek=$(echo $(LANG=en-us88591; date +"%a"))
month=$(echo $(LANG=en-us88591; date +"%b"))
day=14

# Extract sessions' duration from dummy 'last' output (last.txt file). 
str_of_timestamps=$(cat last.txt \
    | grep -E "${username}.*${procname}.*${dayweek}.*${month} ${day}" \
    | grep -oP "\([0-9][0-9]:[0-9][0-9]\)" \
    | tr -d '()'
)

# Convert string of timestamps into array of separate ones.
array_of_timestamps=(${str_of_timestamps})

 
# Convert arrow of strings into arraow of integers.
array_of_seconds=()
for ((i = 0; i < ${#array_of_timestamps[@]}; i++)); do
    array_of_seconds[${i}]+=$(echo ${array_of_timestamps[${i}]} | awk -F: '{ print ($1 * 60) + $2  }')
    echo ${array_of_seconds[${i}]}
done


