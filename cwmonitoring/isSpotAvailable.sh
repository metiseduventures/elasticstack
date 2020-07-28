#!/bin/bash

env="";
 
while IFS= read env; do
 status=`aws elasticbeanstalk describe-environment-health --environment-name $env --attribute-names All --query [HealthStatus,Causes[*]] --output=text`
 if [[ $status == "Degraded"* ]]; then
	echo "$env is degraded";
	if  [[ $status == *"Could not launch Spot Instances. InsufficientInstanceCapacity"* ]]; then
		echo "Spot Not Available , Swithcing to Ondemand";
		`/home/ec2-user/devops/cwmonitoring/switchenvinstances.sh ondemand $env`;
	fi
 fi
done < "/home/ec2-user/devops/cwmonitoring/prodSpotEnv.txt"
