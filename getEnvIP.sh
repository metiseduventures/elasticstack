

env=storefrontuserprod
aws elasticbeanstalk describe-environment-resources --environment-name $env --output=text | grep INSTANCES | cut -f2 | xargs -n 1 aws ec2 describe-instances --instance-ids --query 'Reservations[*].Instances[*].PublicIpAddress' --output=text
