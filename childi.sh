#!/bin/bash

. ./childish.conf

# Exit script immediately if whoiam output is not in target_user
if ! [[ "${target_user[*]}" =~ `whoami` ]]; then
    if [$production]; then
       exit
    else
        echo "Exit Childish, no current user in \$target_user." 
    fi
fi






