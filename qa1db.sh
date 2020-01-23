#!/bin/bash
arg1="$1";

case "$arg1" in
	scaleup)
		dbaction="start-db-instance";;
	scaledown)
		dbaction="stop-db-instance";;
	*)
		echo  "usage: qa1db.sh (scaleup/scaledown)"
		exit 1;
esac


qa1db="bigservicedb-qa1db video-streaming-qa1db user-qa1db extradb-qa1db storefront-qa1db";

#storefront-analytics-qa1db

for i in $qa1db
do
        echo "Stopping database  $i";
	aws rds $dbaction --db-instance-identifier $i;
done
