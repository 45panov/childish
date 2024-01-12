#!/usr/bin/env/ bash

. ~/childish/childi.sh

@test "childi.sh imported to first-test.bat" {
    [ "$childish_loaded" -eq 1 ]
}

@test "config imported into childi.sh" {
    [ "$config_loaded" -eq 1 ]
}
