arg1="$1";
arg2="$2";

case "$arg1" in
	spot)
		type="shift2spot.json";;
	ondemand) 
		type="shift2ondemand.json";;
        * )
		echo "usage: switchenvinstances.sh [spot/ondemand] EnvironmentName";
            	exit 1;
esac

if [ -z "$arg2" ]; then
	echo "usage: switchenvinstances.sh [spot/ondemand] EnvironmentName";
	exit 1;
else
	env=$arg2;	
fi

echo "updating environment : "${env};
while [ `aws elasticbeanstalk describe-environment-health --environment-name $env --attribute-names All --query 'Status' --output=text` != "Ready" ]
        do
                sleep 5;
        done
aws elasticbeanstalk update-environment --environment-name $env --option-settings file://$type
if [[ $? -ne 0 ]]; then
	echo "Environment Switch Failed. Check again. Exiting";
	exit $?
else
	echo "Environment Switch Initiated"
fi
