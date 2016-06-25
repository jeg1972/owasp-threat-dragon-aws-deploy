#!/bin/sh

###################################################################
Add the full path the Cloudformation JSON template you wish to run.
###################################################################
templatepath="td_define_infrastructure.json"

###################################################################
Add the name of what you wish to call the Cloudformation Stack.
###################################################################
stackname="Threat-Dragon-Stack"

clear

echo ""
cat << "EOF"
                            P     A     L     I     N     D     R     O     M     E
  ____ _                 _  __                            _   _               ____
 / ___| | ___  _   _  __| |/ _| ___  _ __ _ __ ___   __ _| |_(_) ___  _ __   |  _ \ _   _ _ __  _ __   ___ _ __
| |   | |/ _ \| | | |/ _` | |_ / _ \| '__| '_ ` _ \ / _` | __| |/ _ \| '_ \  | |_) | | | | '_ \| '_ \ / _ \ '__|
| |___| | (_) | |_| | (_| |  _| (_) | |  | | | | | | (_| | |_| | (_) | | | | |  _ <| |_| | | | | | | |  __/ |
 \____|_|\___/ \__,_|\__,_|_|  \___/|_|  |_| |_| |_|\__,_|\__|_|\___/|_| |_| |_| \_\\__,_|_| |_|_| |_|\___|_|
EOF
echo ""

scriptin()
{
    ip=$(curl --silent 'https://api.ipify.org?format=text')
    read -p "Please enter your external IP address. (We think this may be; $ip): " extip
    echo ""
    read -p "Enter the name of the Availability Zone. (It should be of the form; eu-west-1a): " extaz
    echo ""
    read -p "Input the name of your IAM key pair. (This is the name of the key pair in the AWS console without a file extension): " extkey
    echo ""
}

if [ $# -eq 0 ]
then
    echo "This script needs to be run with a parameter."
    exit
fi

if [ $1 = "test" ] || [ $1 = "check" ] || [ $1 = "validate" ]
then
    aws cloudformation validate-template --template-body file://$templatepath --output table
elif [ $1 = "build" ] || [ $1 = "create" ]
then

    scriptin
    aws cloudformation create-stack --stack-name $stackname --template-body file://$templatepath --parameters ParameterKey=AccessIP,ParameterValue=$extip/32  ParameterKey=AvailabilityZone,ParameterValue=$extaz  ParameterKey=SSHKey,ParameterValue=$extkey --output table
elif [ $1 = "update" ]
then
    aws cloudformation update-stack --stack-name $stackname --template-body file://$templatepath --output table
elif [ $1 = "view" ] || [ $1 = "status" ]
then
    echo -n "ENTER STACK ARN ID (Blank means view information from ALL Stacks): "
    read stackid
    echo ""
    if [ -z $stackid ]
    then
        aws cloudformation describe-stacks --output table
    else
        aws cloudformation describe-stacks --stack-name $stackid --output table
    fi
elif [ $1 = "diff" ]  || [ $1 = "change" ]
then
    echo -n "ENTER STACK ARN ID: "
    read stackid
    echo ""
    if [ -z $stackid ]
    then
        echo ""
        echo "You must enter Stack ARN ID."
        echo ""
        exit
    else
        aws cloudformation create-change-set --stack-name $stackid --change-set-name P$(date +%Y%m%d%H%M%S) --template-body file://$templatepath --output table
    fi
elif [ $1 = "diffview" ]  || [ $1 = "changeview" ]
then
    echo -n "ENTER STACK ARN ID: "
    read stackid
    echo ""
    if [ -z $stackid ]
    then
        echo ""
        echo "You must enter Stack ARN ID."
        echo ""
        exit
    else
        aws cloudformation list-change-sets --stack-name $stackid --output json
    fi
fi
