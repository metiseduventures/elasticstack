# aws autoscaling describe-auto-scaling-groups --profile prod --output text  | grep AUTOSCALINGGROUPS | awk '{ print $3}' > wp-asg.txt
while IFS=: read asg ALB; do  
	echo "Setting Environment Health Check for  :"${asg};
	aws cloudwatch put-metric-alarm --alarm-name ${asg}-HighCPU --alarm-description "${asg} CPU utilization exceeding 75 percent" --metric-name CPUUtilization --namespace AWS/EC2 --statistic Average --period 60 --threshold 75 --comparison-operator GreaterThanOrEqualToThreshold  --dimensions "Name=AutoScalingGroupName,Value=${asg}" --evaluation-periods 3 --alarm-actions arn:aws:sns:ap-south-1:772389675430:ADDA247-ORANGE-ALERT --profile=prod
	aws cloudwatch put-metric-alarm --alarm-name ${asg}-HighCPU --alarm-description "${asg} CPU utilization exceeding 90 percent" --metric-name CPUUtilization --namespace AWS/EC2 --statistic Average --period 60 --threshold 90 --comparison-operator GreaterThanOrEqualToThreshold  --dimensions "Name=AutoScalingGroupName,Value=${asg}" --evaluation-periods 3 --alarm-actions arn:aws:sns:ap-south-1:772389675430:ADDA247-RED-ALERT --profile=prod
	echo "application load balancer:"$ALB;
	aws cloudwatch put-metric-alarm --alarm-name ${asg}-5xx-Count --alarm-description "${asg} 5xx count per minute rising" --metric-name HTTPCode_ELB_5XX_Count  --treat-missing-data notBreaching --namespace AWS/ApplicationELB --statistic Sum --period 300 --threshold 10 --comparison-operator GreaterThanOrEqualToThreshold  --dimensions "Name=LoadBalancer,Value=${ALB}" --evaluation-periods 3 --alarm-actions arn:aws:sns:ap-south-1:772389675430:ADDA247-ORANGE-ALERT --profile=prod
done < "./wp-asg.txt"