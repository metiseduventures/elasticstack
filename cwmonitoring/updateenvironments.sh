while IFS= read env; do 
	echo "updating environment : "${env};
	asg="$(aws elasticbeanstalk describe-environment-resources --environment-name ${env} --output=text)";
	ALB=`echo "${asg}" | grep LOADBALANCERS | awk -F'loadbalancer' '{ print $2}'`;
	if [ ${#ALB} = 0 ];then
        	aws elasticbeanstalk update-environment --environment-name $env --option-settings file://ConnectionDrainingTimeout.json
	else
        	aws elasticbeanstalk update-environment --environment-name $env --option-settings file://DeregistrationDelay.json	
	fi	
done < "./all.txt"
