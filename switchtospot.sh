while IFS= read env; do  
	echo "Working on env  :"${env};
        aws elasticbeanstalk update-environment --environment-name ${env} --option-settings Namespace=aws:ec2:instances,OptionName=SpotFleetOnDemandBase,Value=0,OptionName=SpotFleetOnDemandAboveBasePercentage,Value=0,OptionName=EnableSpot,Value=true
done < "../cwmonitoring/stag.txt"
