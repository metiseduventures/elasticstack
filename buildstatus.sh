#!/usr/bin/env bash

dbhost="localhost";
dbuser="heartprairy";
dbpass="cbbmc33JYQE5";
dbname="devops";
dbtable="deployments";
flag=true;
START=$(date +%s);

data=$(mysql -u$dbuser -p$dbpass -h$dbhost $dbname -se "select deploymentid,environment,versionlabel from $dbtable where status='started'  and isprod='false'");
if [ -z "$data" ]; then
	#echo "All Deployments Completed"; 
	exit 0;
fi
deploymentid=$(echo $data | awk '{print $1}');
environment=$(echo $data | awk '{print $2}');
versionlabel=$(echo $data | awk '{print $3}');

while [ "$flag" != false ]; do

	envstatus=$(aws elasticbeanstalk describe-environments --environment-name $environment --output=json | grep \"Status\" | awk '{ print $2}' | tail -c +2 | head -c -3);
	envverlabel=$(aws elasticbeanstalk describe-environments --environment-name $environment --output=json | grep \"VersionLabel\" | awk '{ print $2}' | tail -c +2 | head -c -3);

	if [ "$envstatus" = "Ready" ]; then
		if [ "$envverlabel" = "$versionlabel" ]; then
			groupmsg="Deployment on "$environment" completed. Deployed Version : "$versionlabel".";
		else
			groupmsg="Deployment on "$environment" failed. Rolled back to Deployed Version : "$envverlabel".";
		fi;
		mysql -u$dbuser -p$dbpass -h$dbhost $dbname -se "update $dbtable set status='complete' where deploymentid=$deploymentid";
		flag=false;
	else
		sleep 5;
	fi
	if [[ $(($(date +%s) - $START)) -gt 300 ]]; then
		mysql -u$dbuser -p$dbpass -h$dbhost $dbname -se "update $dbtable set status='stale' where deploymentid=$deploymentid";
		groupmsg="Deployment on "$environment" Unknown. Please check manually on Beanstalk Page";
		flag=false;
	fi
done

        python /home/ec2-user/devops/devops-bot.py "${groupmsg}";
        curl -X POST -H 'Content-type: application/json' --data '{"text":"'"${groupmsg}"'"}' https://hooks.slack.com/services/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

