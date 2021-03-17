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

stg1="stagingstoreuser1 StoreFrontAdminStaging1 stagingadminui staginggoldweb";
stg4="StoreElasticSearchStaging contentadminstaging CouponAdminStaging CouponServiceStaging timelinestaging pushservicestaging analyticsstaging rankingstaging ";
stg5="userauthstaging videoserverstaging testseriesstaging bigservicestaging extraservicestaging paymentservicestaging";
stg7="socialclientstaging newcouponadminstaging newcouponservicestaging ytsearchstaging doubtsstaging staging2adda247 staging3adda247 stagingadda247 stagingvadda247";


for i in $stg1 $stg4 $stg5 $stg7 
do
	echo "Fetching autoscaling groups of environments: $i";
	asg="$(aws elasticbeanstalk describe-environment-resources --environment-name $i --output=text)";
	ASG=`echo "${asg}" | awk -F"\t" '$1=="AUTOSCALINGGROUPS" {print $2}'`;
	echo "Triggering $action on auto scaling group $ASG";
	groupmsg="Triggering "$action" on staging servers";
	aws autoscaling update-auto-scaling-group --auto-scaling-group-name $ASG --min-size $size --max-size $size;
done

python /home/ec2-user/devops/devops-bot.py "${groupmsg}";
curl -X POST -H 'Content-type: application/json' --data '{"text":"'"${groupmsg}"'"}' https://hooks.slack.com/services/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

#stgmum1="stagingdoubts";


#for i in $stgmum1
#do
#        echo "Fetching autoscaling groups of environments: $i";
#        asg="$(aws elasticbeanstalk describe-environment-resources --environment-name $i --output=text --profile mumbai)";
#        ASG=`echo "${asg}" | awk -F"\t" '$1=="AUTOSCALINGGROUPS" {print $2}'`;
#        echo "Triggering $action on auto scaling group $ASG";
#        groupmsg="Triggering "$action" on "$i;
#        python /home/ec2-user/devops/devops-bot.py "${groupmsg}";
#        aws autoscaling update-auto-scaling-group --auto-scaling-group-name $ASG --min-size $size --max-size $size --profile mumbai;
#done
