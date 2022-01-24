while IFS= read redis; do
        echo "Setting Redis Checks for  :"${redis};
        aws cloudwatch put-metric-alarm --alarm-name ${redis}-Redis-CPUUtilization-Critical --alarm-description "${redis} CPU Utilization Critical" --metric-name CPUUtilization --namespace AWS/EC2 --statistic Average --period 60 --threshold 80 --comparison-operator GreaterThanOrEqualToThreshold  --dimensions "Name= InstanceId,Value=${redis}" --evaluation-periods 6 --alarm-actions arn:aws:sns:us-east-1:490891715875:ADDA247-RED-ALERT;
        aws cloudwatch put-metric-alarm  --alarm-name ${redis}-Redis-CPUUtilization-Warning --alarm-description "${redis} CPU Utilization Warning" --metric-name CPUUtilization --namespace AWS/EC2 --statistic Average --period 60 --threshold 60 --comparison-operator GreaterThanOrEqualToThreshold  --dimensions "Name= InstanceId,Value=${redis}" --evaluation-periods 6 --alarm-actions arn:aws:sns:us-east-1:490891715875:ADDA247-ORANGE-ALERT;
done < "./redisnodes.txt"
