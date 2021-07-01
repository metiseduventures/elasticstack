#!/bin/bash
arg1="$1";
arg2="$2";

case "$arg1" in
	scaleup)
		action="scaleup";
		dbaction="start-db-instance";
		size=1;;
	scaledown)
		action="scaledown";
		dbaction="stop-db-instance";
		size=0;;
	*)
		echo  "wrong usage"
		exit 1;
esac

stg1="stagingstoreuser1 StoreFrontAdminStaging1 stagingadminui StoreElasticSearchStaging contentadminstaging CouponAdminStaging CouponServiceStaging timelinestaging pushservicestaging staginganalytics rankingstaging userauthstaging videoserverstaging testseriesstaging bigservicestaging extraservicestaging paymentservicestaging socialclientstaging newcouponadminstaging newcouponservicestaging ytsearchstaging doubtsstaging staging2adda247 staging3adda247 stagingadda247 stagingvadda247";
stgdb1="storefront-staging-db bigservicedb-stag1 storeresultdb-stage userdb-stag video-streaming-db-staging";
stg2="stagingstoreuser2 StoreFrontAdminStaging2 stagingadminui2";
stg3="stagingstoreuser3 storefrontadminstaging3 stagingadminui3";
stg4="stagingstoreuserv StoreFrontAdminStagingv stagingadminuiv";
hostlist="#";
hosttype="host";

case "$arg2" in
	basestaging)
		hostlist=${stg1};;
	stagingdb)
		hostlist=${stgdb1};
		hosttype="db";;
	staging2)
		hostlist=${stg2};;
	staging3)
		hostlist=${stg3};;
	stagingv)
		hostlist=${stg4};;
	*)
                echo  "wrong usage"
                exit 1;
esac

if [ "$hosttype" = "host" ]; then
	for i in $hostlist 
	  do
		echo "Fetching autoscaling groups of environments: $i";
		asg="$(aws elasticbeanstalk describe-environment-resources --environment-name $i --output=text)";
		ASG=`echo "${asg}" | awk -F"\t" '$1=="AUTOSCALINGGROUPS" {print $2}'`;
		echo "Triggering $action on auto scaling group $ASG";
		aws autoscaling update-auto-scaling-group --auto-scaling-group-name $ASG --min-size $size --max-size $size;
	  done
	groupmsg="Triggering "$action" on ${arg2} servers";
elif [ "$hosttype" = "db" ]; then
	for i in $hostlist
	  do
		echo "Initiating $dbaction on database  $i";
		aws rds $dbaction --db-instance-identifier $i;
	  done	
	groupmsg="Initiating "$dbaction" on ${arg2} database ";
fi

python /home/ec2-user/devops/devops-bot.py "${groupmsg}";
curl -X POST -H 'Content-type: application/json' --data '{"text":"'"${groupmsg}"'"}' https://hooks.slack.com/services/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


