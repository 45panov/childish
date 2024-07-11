        #!/bin/bash

# Import configuration.
. ~/childish/childish.conf

# Exit script immediately if whoiam output is not in target_user array
# in 'childish.conf'.
if ! [[ "${target_user[*]}" =~ `whoami` ]]; then
    echo Exit, because no `whoami` in target_user
    exit
fi


username=`whoami`


# Get index of current user in target_user array from 'childish.conf'.
user_index=""
for i in "${!target_user[@]}"; do
    if [[ "${target_user[$i]}" == `whoami` ]]; then
        user_index="${i}";
    fi
done


# Get allowed time from default_time array by user_index.
allowed_time=${default_time[${user_index}]}


# FOLLOWING CODE PARSES 'LAST' OUTPUT AND COUNT DURATION OF FINISHED SESSIONS.  

# Get date elemtnts for parsing 'last' output.
dayweek=$(echo $(LANG=en-us88591; date +"%a"))
month=$(echo $(LANG=en-us88591; date +"%b"))
day=$(echo $(LANG=en-us88591; date +"%e"))

# Dummy date.
#dayweek="Wed"
#month="Jun"
#day=19

# Extract finished sessions' duration from dummy 'last' output. 
str_of_timestamps=$(last \
    | grep -E "${username}[[:space:]]*tty7.*${dayweek}[[:space:]]*${month}[[:space:]]*${day}" \
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
echo Finished sessions duration is ${all_sess_duration} minutes.



# FOLLOWING CODE PARSES 'LAST' OUTPUT AND COUNT DURATION OF CURRENT SESSION.

# Extract current  duration from 'last' output. 
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
echo Allowed time is ${allowed_time}
