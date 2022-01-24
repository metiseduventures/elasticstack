while IFS= read rdsdb; do
        echo "Setting Database Checks for  :"${rdsdb};
        aws cloudwatch put-metric-alarm --profile=mars --alarm-name ${rdsdb}-RDS-CPUUtilization-Critical --alarm-description "${rdsdb} CPU Utilization Critical" --metric-name CPUUtilization --namespace AWS/RDS --statistic Average --period 60 --threshold 80 --comparison-operator GreaterThanOrEqualToThreshold  --dimensions "Name= DBInstanceIdentifier,Value=${rdsdb}" --evaluation-periods 6 --alarm-actions arn:aws:sns:ap-south-1:680403204954:ADDA247-RED-ALERT;
        aws cloudwatch put-metric-alarm --profile=mars --alarm-name ${rdsdb}-RDS-CPUUtilization-Warning --alarm-description "${rdsdb} CPU Utilization Warning" --metric-name CPUUtilization --namespace AWS/RDS --statistic Average --period 60 --threshold 60 --comparison-operator GreaterThanOrEqualToThreshold  --dimensions "Name= DBInstanceIdentifier,Value=${rdsdb}" --evaluation-periods 6 --alarm-actions arn:aws:sns:ap-south-1:680403204954:ADDA247-ORANGE-ALERT;
        aws cloudwatch put-metric-alarm --profile=mars --alarm-name ${rdsdb}-RDS-DatabaseConnections-Critical --alarm-description "${rdsdb} Database Connections Critical" --metric-name DatabaseConnections --namespace AWS/RDS --statistic Average --period 60 --threshold 800 --comparison-operator GreaterThanOrEqualToThreshold  --dimensions "Name= DBInstanceIdentifier,Value=${rdsdb}" --evaluation-periods 6 --alarm-actions arn:aws:sns:ap-south-1:680403204954:ADDA247-RED-ALERT;
        aws cloudwatch put-metric-alarm --profile=mars --alarm-name ${rdsdb}-RDS-DatabaseConnections-Warning --alarm-description "${rdsdb} Database Connections Warning" --metric-name DatabaseConnections --namespace AWS/RDS --statistic Average --period 60 --threshold 600 --comparison-operator GreaterThanOrEqualToThreshold  --dimensions "Name= DBInstanceIdentifier,Value=${rdsdb}" --evaluation-periods 6 --alarm-actions arn:aws:sns:ap-south-1:680403204954:ADDA247-ORANGE-ALERT;
        aws cloudwatch put-metric-alarm --profile=mars --alarm-name ${rdsdb}-RDS-Free-Storage-Warning --alarm-description "${rdsdb} Free Storage Warning" --metric-name FreeStorageSpace --namespace AWS/RDS --statistic Average --period 300 --threshold 10737418240 --comparison-operator LessThanThreshold  --dimensions "Name= DBInstanceIdentifier,Value=${rdsdb}" --evaluation-periods 6 --alarm-actions arn:aws:sns:ap-south-1:680403204954:ADDA247-ORANGE-ALERT;
done < "./marsrdsdb.txt"
