#!/usr/bin/bash

# Here we test regular expression which extracts durarion of sesssions
# from 'last.txt' file.

#  Dummy variables which are to be replaced with dynamic ones in main script.
username="aspanov"
procname="tty7"

# Real date.
#dayweek=$(echo $(LANG=en-us88591; date +"%a"))
#month=$(echo $(LANG=en-us88591; date +"%b"))
#day=$(echo $(LANG=en-us88591; date +"%e"))

# Dummy date.
dayweek="Wed"
month="Jun"
day=19


# Extract finished sessions' duration from dummy 'last' output (last.txt file). 
str_of_timestamps=$(last \
    | grep -E "${username}[[:space:]]*${procname}.*${dayweek}[[:space:]]*${month}[[:space:]]*${day}" \
    | grep -oP "\([0-9][0-9]:[0-9][0-9]\)" \
    | tr -d '()'
)

# Convert string of timestamps into array of separate ones.
array_of_timestamps=(${str_of_timestamps})

 
# Convert arrow of strings into arraow of integers.
array_of_minutes=()
for ((i = 0; i < ${#array_of_timestamps[@]}; i++)); do
    array_of_minutes[${i}]+=$(echo ${array_of_timestamps[${i}]} | awk -F: '{ print ($1 * 60) + $2  }')
#    echo ${array_of_minutes[${i}]}
done

# Count duration of all finished sessions.
all_sess_duration=$(expr 0)
for elem in "${array_of_minutes[@]}"; do
    all_sess_duration=$(expr $all_sess_duration + $elem)
done

echo All sessions of ${month}, ${day} had lasted for  ${all_sess_duration} minutes.
