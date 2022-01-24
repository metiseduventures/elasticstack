while IFS= read env; do  
	app=`aws elasticbeanstalk describe-environments --environment-names $env --output=text  | grep ENVIRONMENTS | awk '{ print $3}'`
	envvars=`aws elasticbeanstalk describe-configuration-settings --environment-name $env --application-name $app --output=text | grep EnvironmentVariables`
	echo $env" "$envvars
done < "./all.txt"
