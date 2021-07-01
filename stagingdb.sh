#!/bin/bash
arg1="$1";

case "$arg1" in
	scaleup)
		dbclusteraction="start-db-cluster";
		#dbclusteraction="stop-db-cluster"; #temp dont start cluster not in use
		dbaction="start-db-instance";;
	scaledown)
		dbclusteraction="stop-db-cluster";
		dbaction="stop-db-instance";;
	*)
		echo  "usage: stagingdb.sh (scaleup/scaledown)";
		exit 1;
esac



#stagingdb="storefront-staging-db bigservicedb-stag1 extradb-staging storeresultdb-stage userdb-stag video-streaming-db-staging";
stagingdb="storefront-staging-db bigservicedb-stag1 storeresultdb-stage userdb-stag video-streaming-db-staging";
##adda-wordpress-prod-db";
stagingclusterdb="wordpress-staging-db-cluster";

for i in $stagingdb
do
	echo "Initiating $dbaction on database  $i";
	groupmsg="Initiating "$dbaction" on staging database ";
	aws rds $dbaction --db-instance-identifier $i;
done
	python /home/ec2-user/devops/devops-bot.py "${groupmsg}"; 		
        curl -X POST -H 'Content-type: application/json' --data '{"text":"'"${groupmsg}"'"}' https://hooks.slack.com/services/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

for i in $stagingclusterdb
do
	echo "Initiating $dbclusteraction on cluster  $i";
 	
	aws rds $dbclusteraction --db-cluster-identifier $i --profile=mumbai;
done

