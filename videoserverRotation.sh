#!/bin/bash
echo -e "You are rotating Video Streaming environment";
env1="videoserverproduction";

echo "Fetching autoscaling groups of environments: $env1";
asg1="$(aws elasticbeanstalk describe-environment-resources --environment-name $env1 --output=text)";
ASG1=`echo "${asg1}" | awk -F"\t" '$1=="AUTOSCALINGGROUPS" {print $2}'`;
echo "Triggering scaleup on auto scaling group $ASG1";
aws autoscaling update-auto-scaling-group --auto-scaling-group-name $ASG1 --min-size 4 --max-size 6;
sleep 10m;
echo "Triggering scaledown on auto scaling group $ASG1";
aws autoscaling update-auto-scaling-group --auto-scaling-group-name $ASG1 --min-size 2 --max-size 2;
sleep 2m;
aws autoscaling update-auto-scaling-group --auto-scaling-group-name $ASG1 --min-size 2 --max-size 6;
