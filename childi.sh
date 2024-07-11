        #!/bin/bash

. ~/childish/childish.conf

# Exit script immediately if whoiam output is not in target_user.

if ! [[ "${target_user[*]}" =~ `whoami` ]]; then
    echo Exit, because no `whoami` in target_user
    exit
fi
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


# Get index of current user in target_user array.
user_index=""
for i in "${!target_user[@]}"; do
    if [[ "${target_user[$i]}" == `whoami` ]]; then
        user_index="${i}";
    fi
done


# Get allowed time from default_time array by user_index.
allowed_time=${default_time[${user_index}]}

