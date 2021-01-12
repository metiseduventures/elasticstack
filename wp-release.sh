#!/usr/bin/env bash

aws autoscaling start-instance-refresh --profile=prod --auto-scaling-group-name wpsites-asg
groupmsg="Starting Deployment on Producgion Wordpress Blogs";
curl -X POST -H 'Content-type: application/json' --data '{"text":"'"${groupmsg}"'"}' https://hooks.slack.com/services/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

while true
do
	response="$(aws autoscaling  describe-instance-refreshes --profile=prod --auto-scaling-group-name wpsites-asg --output=text --query 'InstanceRefreshes[0].Status' --output=text)";
	if [ "$response" = "InProgress" ]; then
		aws autoscaling  describe-instance-refreshes --profile=prod --auto-scaling-group-name wpsites-asg --query 'InstanceRefreshes[0].[Status,PercentageComplete,StatusReason]' --output=text;
		sleep 10;
	elif [ "$response" = "Pending" ]; then
		sleep 10;
	elif [ "$response" = "Successful" ]; then
		groupmsg="Deployment Completed Successfully";
		exit 0;
	elif [ "$response" = "Failed" ]; then
		groupmsg="Deployment Failed";
		exit 1;
	fi
done
curl -X POST -H 'Content-type: application/json' --data '{"text":"'"${groupmsg}"'"}' https://hooks.slack.com/services/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

