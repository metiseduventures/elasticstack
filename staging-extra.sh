#!/bin/bash
arg1="$1";

case "$arg1" in
	scaleup)
		action="scaleup";
		size=1;;
	scaledown)
		action="scaledown";
		size=0;;
	*)
		echo  "usage: staging.sh (scaleup/scaledown)"
		exit 1;
esac

stg1="stagingstoreuser1 StoreFrontAdminStaging1 stagingadminui";
stg2="stagingstoreuser2 StoreFrontAdminStaging2 stagingadminui2";
stg9="stagingstoreuser3 storefrontadminstaging3 stagingadminui3";
stg3="stagingstoreuserv StoreFrontAdminStagingv stagingadminuiv";
stg4="StoreElasticSearchStaging contentadminstaging CouponAdminStaging CouponServiceStaging timelinestaging pushservicestaging analyticsstaging rankingstaging";
stg5="userauthstaging videoserverstaging testseries-stag-env bigservicestaging extraservicestaging";
stg6="erpstaging franchisestaging stagingmailingservice";
stg7="Adda247Unity-env-staging socialapi-staging stagingadda247 search2prod";
stg8="StoreElasticSearchStaging2 StoreElasticSearchStaging";



for i in $stg2
do
	echo "Fetching autoscaling groups of environments: $i";
	asg="$(aws elasticbeanstalk describe-environment-resources --environment-name $i --output=text)";
	ASG=`echo "${asg}" | awk -F"\t" '$1=="AUTOSCALINGGROUPS" {print $2}'`;
	echo "Triggering $action on auto scaling group $ASG";
        groupmsg="Triggering "$action" on additional staging machines";
	aws autoscaling update-auto-scaling-group --auto-scaling-group-name $ASG --min-size $size --max-size $size;
done

        python /home/ec2-user/devops/devops-bot.py "${groupmsg}";
        curl -X POST -H 'Content-type: application/json' --data '{"text":"'"${groupmsg}"'"}' https://hooks.slack.com/services/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

