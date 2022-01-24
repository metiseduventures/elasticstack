#!/bin/bash
arg1="$1";

case "$arg1" in
	scaleup)
		action="start-instances";
		dbaction="start-db-instance";;
	scaledown)
		action="stop-instances";
		dbaction="stop-db-instance";;
	*)
		echo  "usage: staging.sh (scaleup/scaledown)"
		exit 1;
esac

uat="i-0bb6ca4f8a27d1e71";
testenv="i-02e3e53b323d094e9";
uatdb="adda247uatdb";
testdb="adda247testdb";


for i in $testenv
do
	groupmsg="Triggering "$action" on mars Test servers";
	aws ec2 $action --instance-ids $i --region="ap-south-1" --profile=mars-dev ;
done

for i in $testdb
do
	groupmsg="Triggering "$action" on mars Test servers";
	aws rds $dbaction --db-instance-identifier $i --region="ap-south-1" --profile=mars-dev ;
done

python /home/ec2-user/devops/devops-bot.py "${groupmsg}";
        curl -X POST -H 'Content-type: application/json' --data '{"text":"'"${groupmsg}"'"}' https://hooks.slack.com/services/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

