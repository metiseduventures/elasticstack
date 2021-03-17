#!/usr/bin/env bash

asg="$1";

/usr/local/bin/aws autoscaling start-instance-refresh --profile=prod --auto-scaling-group-name ${asg} --preferences '{"InstanceWarmup": 400,"MinHealthyPercentage": 75}'
groupmsg="Starting Deployment on Production Wordpress Blogs";
curl -X POST -H 'Content-type: application/json' --data '{"text":"'"${groupmsg}"'"}' https://hooks.slack.com/services/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
groupmsg="Deployment status is unknown";

while true
do
	response="$(/usr/local/bin/aws autoscaling describe-instance-refreshes --profile=prod --auto-scaling-group-name ${asg} --output=text --query 'InstanceRefreshes[0].Status' --output=text)";
	if [ "$response" = "InProgress" ]; then
		/usr/local/bin/aws autoscaling describe-instance-refreshes --profile=prod --auto-scaling-group-name ${asg} --query 'InstanceRefreshes[0].[Status,PercentageComplete,StatusReason]' --output=text;
		sleep 30;
	elif [ "$response" = "Pending" ]; then
		echo "Request is in Pending State";
		sleep 30;
	elif [ "$response" = "Cancelling" ]; then
		echo "Request is Cancelling";
		sleep 30;
	elif [ "$response" = "Successful" ]; then
		groupmsg="Deployment on Production Wordpress Blogs Completed Successfully";
		curl -X POST -H 'Content-type: application/json' --data '{"text":"'"${groupmsg}"'"}' https://hooks.slack.com/services/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;
		exit 0;
	elif [ "$response" = "Cancelled" ]; then
		groupmsg="Nothing to do here , Last Deployment Cancelled";
		exit 1;
	elif [ "$response" = "Failed" ]; then
		groupmsg="Deployment Failed";
		exit 1;
	fi
done
curl -X POST -H 'Content-type: application/json' --data '{"text":"'"${groupmsg}"'"}' https://hooks.slack.com/services/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

