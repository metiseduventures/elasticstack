while IFS= read env; do  
	app=`aws elasticbeanstalk describe-environments --environment-names $env --output=text  | grep ENVIRONMENTS | awk '{ print $3}'`
	proxy=`aws elasticbeanstalk describe-configuration-settings --environment-name $env --application-name $app --output=text | grep CONFIGURATIONSETTINGS | awk -F'\t' '{ print $8 }'`
	echo $env" "$proxy
done < "./all.txt"
