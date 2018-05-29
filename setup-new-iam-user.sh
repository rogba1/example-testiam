#!/bin/bash
# Description: A script to call the AWS CLI to create a new iam user.
# This script requires the latest version of the AWS CLI and should be run on a unix environment.
# You'll also need to make the script executable using the following command
# `chmod +x ./setup-new-iam-user.sh`
#
# Usage:
# Run from command line with the following parameters (maintaining this sequence).
#  ./setup-new-iam-user.sh --user_name <user_name> --profile <profile_name>
#  e.g
#  ./setup-new-iam-user.sh  --user_name joeblogg --profile default
#

# Variables
user_name=
profile_name=

# Read Input Flags
echo Read Input Flags
while [[ $# -gt 1 ]]
do
key="$1"

case $key in
    -h|--help)
        echo "Description"
        echo ""
        echo "Usage:"
        echo "  setup-new-iam-user.sh"
        echo "--profile :         The aws named profile that indicates the account set up under"
        echo "--user_name :       The aws new user account name"
        exit 0
        ;;
    --user_name) user_name="$2"; shift ;;
    --profile) profile_name="$2"; shift ;;
    *) ;; # Undeclared flags
esac
shift # past argument or value
done



# AWS CLI command - create account using name passed in
aws iam create-user --user-name $user_name
aws iam put-user-policy --user-name $user_name --policy-name MyUserPolicy --policy-document file://user-policy.json
