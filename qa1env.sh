#!/bin/bash
arg1="$1";

case "$arg1" in
	scaleup)
		size=1
		action="scale up" ;;
	scaledown)
		size=0
		action="scale down" ;;
	*)
		echo  "usage: qa1env.sh (scaleup/scaledown)"
		exit 1;
esac

qa1="storefrontuserqa1 adminuiqa1 analyticsqa1 bigserviceqa1 contentadminqa1 couponadminqa1 couponserviceqa1 extraserviceqa1 pushserviceqa1 rankingqa1 storeelasticsearchqa1 storefrontadminqa1 storefrontuserqa1 testseriesqa1 timelineqa1 userauthqa1 videostreamingqa1 erpqa1";


for i in $qa1
do
	echo "Fetching autoscaling groups of environments: $i";
	asg="$(aws elasticbeanstalk describe-environment-resources --environment-name $i --output=text)";
	ASG=`echo "${asg}" | awk -F"\t" '$1=="AUTOSCALINGGROUPS" {print $2}'`;
	echo "Triggering $action on auto scaling group $ASG";
	aws autoscaling update-auto-scaling-group --auto-scaling-group-name $ASG --min-size $size --max-size $size;
done

