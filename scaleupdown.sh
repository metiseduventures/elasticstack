#!/bin/bash
echo -e "\e[5m\e[101m\e[1m\e[97m IMPORTANT: Make sure before you are scaling down correct environment ! (Use ctrl+c to abort)\e[0m";
read -p "Enter name of environment you want to scale up/down :" env;
echo -e "You are scaling $env environment";
echo "Fetching autoscaling group of environment $env";
asg="$(aws elasticbeanstalk describe-environment-resources --environment-name $env --output=text)";
ASG=`echo "${asg}" | awk -F"\t" '$1=="AUTOSCALINGGROUPS" {print $2}'`;

while true; do
    read -p "1. Scale Down 2. Scale Up Select your option :" opt
    case $opt in
        [1]* ) 
		echo "Triggering scaledown on auto scaling group $ASG";
		aws autoscaling update-auto-scaling-group --auto-scaling-group-name $ASG --min-size 0 --max-size 0;
		if [ $? -eq 0 ]
		then
			echo "Scale Down Initiated";
        		groupmsg="Triggering Scale Down on "$env;
		else 
			echo "Something went wrong";
        		groupmsg="Something went wrong ";
		fi;
		break;;
        [2]* ) 
		echo "Triggering scaleup on auto scaling group $ASG";
		aws autoscaling update-auto-scaling-group --auto-scaling-group-name $ASG --min-size 1 --max-size 1;
		if [ $? -eq 0 ]
		then
			echo "Scale Up Initiated";
        		groupmsg="Triggering Scale Up  on "$env;
		else 
			echo "Something went wrong";
        		groupmsg="Something went wrong";
		fi;
		break;;
        * ) echo "Please answer 1 or 2";;
     esac
        python /home/ec2-user/devops/devops-bot.py "${groupmsg}";
done
