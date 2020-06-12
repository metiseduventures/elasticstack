while IFS= read ecache; do
        echo "Setting Elastic Cache Checks for  :"${ecache};
        aws cloudwatch put-metric-alarm --alarm-name ${ecache}-ECache-CPUUtilization --alarm-description "${ecache} CPU Utilization" --metric-name CPUUtilization --namespace AWS/ElastiCache --statistic Average --period 60 --threshold 75 --comparison-operator GreaterThanOrEqualToThreshold  --dimensions "Name=CacheClusterId,Value=${ecache}" --evaluation-periods 3 --alarm-actions arn:aws:sns:us-east-1:490891715875:ADDA247-ORANGE-ALERT;
        aws cloudwatch put-metric-alarm --alarm-name ${ecache}-ECache-CPUUtilization --alarm-description "${ecache} CPU Utilization" --metric-name CPUUtilization --namespace AWS/ElastiCache --statistic Average --period 60 --threshold 90 --comparison-operator GreaterThanOrEqualToThreshold  --dimensions "Name=CacheClusterId,Value=${ecache}" --evaluation-periods 2 --alarm-actions arn:aws:sns:us-east-1:490891715875:ADDA247-RED-ALERT;
done < "./elasticcache.txt"
