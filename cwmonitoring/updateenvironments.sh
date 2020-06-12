while IFS= read env; do 
	echo "updating environment : "${env};
        aws elasticbeanstalk update-environment --environment-name $env --option-settings file://minmax.json	
done < "./stag.txt"
