while IFS= read env; do 
	arn=`aws elasticbeanstalk describe-environments --environment-name $env --output=text | grep ENVIRONMENTS | awk -F'\t' '{ print $9}'`
	echo "arm of environment "$env" is "$arn;
	aws elasticbeanstalk update-tags-for-resource --resource-arn $arn --tags-to-add Key=monitor,Value=exporter
done < "./all.txt"
