#!/usr/bin/env/ bash

. ~/childish/childi.sh

@test "Get short day of week name" {
    [[ "${weekday}"  == "Mon" ]]
}
