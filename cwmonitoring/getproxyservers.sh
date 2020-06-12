while IFS= read env; do  
	app=`aws elasticbeanstalk describe-environments --environment-names ${env} --output=text  | grep ENVIRONMENTS | awk '{ print $3}'`
	#proxy=`aws elasticbeanstalk describe-configuration-settings --environment-name ${env} --application-name ${app} --output=text | grep ProxyServer | awk '{ print $4}i'`
	#healthchk=`aws elasticbeanstalk describe-configuration-settings --environment-name ${env} --application-name ${app} --output=text | awk '/aws:elb:healthcheck/ && /Target/'`
	healthchk=`aws elasticbeanstalk describe-configuration-settings --environment-name ${env} --application-name ${app} --output=text | awk '/AWSEBV2LoadBalancerTargetGroup/ && /HealthCheckPath/'`
	echo $env" "$healthchk;
done < "./all.txt"
