#!/bin/bash

. ./childish.conf

# Exit script immediately if whoiam output is not in target_user.

if ! [[ "${target_user[*]}" =~ `whoami` ]]; then
    if [$production]; then
       exit
    else
        echo "Exit Childish, no current user in \$target_user." 
    fi
fi

# Get index of current user in target_user array.
user_index=""
for i in "${!target_user[@]}"; do
    if [[ "${target_user[$i]}" == `whoami` ]]; then
        user_index="${i}";
    fi
done

# Get allowed time from default_time array by user_index.
allowed_time=${default_time[$user_index]}

