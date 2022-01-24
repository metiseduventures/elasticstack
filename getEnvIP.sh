#!/bin/bash

env=$1;

if [ -z "$env" ];then
	echo "usage : getEnvIP.sh <environment name>";
	echo "List of available environments: ";
	aws elasticbeanstalk describe-environments --query 'Environments[*].EnvironmentName' --output=text
else
	aws elasticbeanstalk describe-environment-resources --environment-name $env --output=text | grep INSTANCES | cut -f2 | xargs -n 1 aws ec2 describe-instances --instance-ids --query 'Reservations[*].Instances[*].PublicIpAddress' --output=text

fi
