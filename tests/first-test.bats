#!/usr/bin/env/ bash

. ~/childish/childi.sh

@test "first item of target user array" {
    [[ "${target_user[0]}" == "user-1" ]]
}

@test "find whoami in target_user" {
    [[   "${target_user[*]}" =~ `whoami`   ]]
}

@test "whoami is not in target_user" {
    ! [[ "${target_user[*]}" =~ "non-existing-username"  ]]
}

@test "get user index" {
    [[ "$user_index" -eq 2  ]]
}

@test "get allowed time by user index" {
    [[ "$allowed_time" -eq 3600 ]]
} 

@test "sizes of arrays target_user and default_time must be equal" {
    [[ "${#target_user[@]}" -eq "${#default_time[@]}" ]]
}
