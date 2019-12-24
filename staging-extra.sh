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
stg3="stagingstoreuserv StoreFrontAdminStagingv stagingadminuiv";
stg4="StoreElasticSearchStaging contentadmin-stag1-env CouponAdminStaging CouponServiceStaging Timeline-stag-env pushservice-stag-env analyticsstaging ranking-stag-env";
stg5="userauth-staging VideoStreamingServer-stag-env testseries-stag-env bigservice-stag-env extraservice-staging-env";
stg6="Adda247Unity-env-staging erpstaging franchise-stag-env";
stg7="socialapi-staging stagingadda247";
stg8="StoreElasticSearchStaging2 StoreElasticSearchStaging";
stg9="wrd-sscadda-prod-env-1";



for i in $stg2 $stg3 $stg6 
do
	echo "Fetching autoscaling groups of environments: $i";
	asg="$(aws elasticbeanstalk describe-environment-resources --environment-name $i --output=text)";
	ASG=`echo "${asg}" | awk -F"\t" '$1=="AUTOSCALINGGROUPS" {print $2}'`;
	echo "Triggering $action on auto scaling group $ASG";
	aws autoscaling update-auto-scaling-group --auto-scaling-group-name $ASG --min-size $size --max-size $size;
done
