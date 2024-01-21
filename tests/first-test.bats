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



