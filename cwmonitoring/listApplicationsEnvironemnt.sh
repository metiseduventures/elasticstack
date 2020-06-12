aws elasticbeanstalk describe-applications --query 'Applications[*].ApplicationName' --output=text | sed 's/\t\t*/\n/g'
aws elasticbeanstalk describe-environments --query 'Environments[*].EnvironmentName' --output=text | sed 's/\t\t*/\n/g'
