#!/bin/bash

# This script runs a manual policy trigger to
# allow the policie(s) associated with that
# trigger to be executed.


CheckBinary (){

# Identify location of jamf binary.

jamf_binary=`/usr/bin/which jamf`

 if [[ "$jamf_binary" == "" ]] && [[ -e "/usr/sbin/jamf" ]] && [[ ! -e "/usr/local/bin/jamf" ]]; then
    jamf_binary="/usr/sbin/jamf"
 elif [[ "$jamf_binary" == "" ]] && [[ ! -e "/usr/sbin/jamf" ]] && [[ -e "/usr/local/bin/jamf" ]]; then
    jamf_binary="/usr/local/bin/jamf"
 elif [[ "$jamf_binary" == "" ]] && [[ -e "/usr/sbin/jamf" ]] && [[ -e "/usr/local/bin/jamf" ]]; then
    jamf_binary="/usr/local/bin/jamf"
 fi
}

# Run the CheckBinary function to identify the location
# of the jamf binary for the jamf_binary variable.

CheckBinary

for trigger in "${@:4:8}"
do
    if [ -n ${trigger} ]
    then
	    $jamf_binary policy -trigger ${trigger}
	fi
done


exit 0