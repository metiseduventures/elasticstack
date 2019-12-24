#!/bin/bash
arg1="$1";

case "$arg1" in
	scaleup)
		dbclusteraction="start-db-cluster";
		dbaction="start-db-instance";;
	scaledown)
		dbclusteraction="stop-db-cluster";
		dbaction="stop-db-instance";;
	*)
		echo  "usage: stagingdb.sh (scaleup/scaledown)"
		exit 1;
esac



stagingdb="storefront-staging-db bigservicedb-stag1 extradb-staging storeresultdb-stage userdb-stag video-streaming-db-staging adda-wordpress-prod-db storefront-staging-slave1";
staging1db="erpdb-stag franchise-stag pushservicedb-stag rankanalytics-staging timelinedb-stag coupon-staging-db";
stagingclusterdb="";

for i in $stagingdb
do
	echo "Initiating $dbaction on database  $i";
 		
	aws rds $dbaction --db-instance-identifier $i;
done

#for i in $stagingclusterdb
#do
#	echo "Initiating $dbclusteraction on cluster  $i";
# 		
#	aws rds $dbclusteraction --db-cluster-identifier $i;
#done

