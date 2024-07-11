#!/usr/bin/bash


# Here we test regular expression which extracts durarion of
# current sesssions from 'last' command output.

#  Dummy variables which are to be replaced with dynamic ones in main script.
username="aspanov"
procname="tty7"

# Real date.
dayweek=$(echo $(LANG=en-us88591; date +"%a"))
month=$(echo $(LANG=en-us88591; date +"%b"))
day=$(echo $(LANG=en-us88591; date +"%e"))

# Dummy date.
#dayweek="Wed"
#month="Jun"
#day=19


# Extract current session's duration from 'last' output). 
start_of_current_session=$(last \
    | grep -E "${username}[[:space:]]*${procname}.*${dayweek}[[:space:]]*${month}[[:space:]]*${day}" \
    | grep -E gone \
    | grep -oP "[0-9][0-9]:[0-9][0-9]" | awk -F: '{ print ($1 * 60) + $2  }' 
)

echo Current session started: ${start_of_current_session}
current_time=$(date +%T)
current_time=$(echo ${current_time:0:5} | awk -F: '{ print ($1 * 60) + $2  }')
echo Current time: echo ${current_time}
echo Corrent session is lasting for $(expr ${current_time} - ${start_of_current_session})
