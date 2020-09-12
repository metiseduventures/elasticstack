while IFS= read env; do  
	echo "Setting Environment Health Check for  :"${env};
       	asg="$(aws elasticbeanstalk describe-environment-resources --environment-name ${env} --output=text)";
	ASG=`echo "${asg}" | awk -F"\t" '$1=="AUTOSCALINGGROUPS" {print $2}'`;
       	ALB=`echo "${asg}" | grep LOADBALANCERS | awk -F'loadbalancer' '{ print $2}'`;
       	ELB=`echo "${asg}" | grep LOADBALANCERS | awk  '{ print $2}'`;
	aws cloudwatch put-metric-alarm --alarm-name ${env}-HighCPU --alarm-description "${env} CPU utilization exceeding 75 percent" --metric-name CPUUtilization --namespace AWS/EC2 --statistic Average --period 60 --threshold 75 --comparison-operator GreaterThanOrEqualToThreshold  --dimensions "Name=AutoScalingGroupName,Value=${ASG}" --evaluation-periods 5 --alarm-actions arn:aws:sns:us-east-1:490891715875:ADDA247-ORANGE-ALERT
	aws cloudwatch put-metric-alarm --alarm-name ${env}-HighCPU --alarm-description "${env} CPU utilization exceeding 90 percent" --metric-name CPUUtilization --namespace AWS/EC2 --statistic Average --period 60 --threshold 90 --comparison-operator GreaterThanOrEqualToThreshold  --dimensions "Name=AutoScalingGroupName,Value=${ASG}" --evaluation-periods 4 --alarm-actions arn:aws:sns:us-east-1:490891715875:ADDA247-RED-ALERT
	aws cloudwatch put-metric-alarm --alarm-name ${env}-EnvironmentHealthSevere --alarm-description "${env} Environment Severe" --metric-name EnvironmentHealth --namespace AWS/ElasticBeanstalk --statistic Maximum --period 60 --threshold 25 --comparison-operator GreaterThanOrEqualToThreshold  --dimensions "Name=EnvironmentName,Value=${env}" --evaluation-periods 3 --alarm-actions arn:aws:sns:us-east-1:490891715875:ADDA247-RED-ALERT 
	aws cloudwatch put-metric-alarm --alarm-name ${env}-EnvironmentHealthDegraded --alarm-description "${env} Environment Degraded" --metric-name EnvironmentHealth --namespace AWS/ElasticBeanstalk --statistic Maximum --period 60 --threshold 20 --comparison-operator GreaterThanOrEqualToThreshold  --dimensions "Name=EnvironmentName,Value=${env}" --evaluation-periods 12 --alarm-actions arn:aws:sns:us-east-1:490891715875:ADDA247-RED-ALERT 
	aws cloudwatch put-metric-alarm --alarm-name ${env}-EnvironmentHealthWarning --alarm-description "${env} Environment Warning" --metric-name EnvironmentHealth --namespace AWS/ElasticBeanstalk --statistic Maximum --period 300 --threshold 15 --comparison-operator GreaterThanOrEqualToThreshold --dimensions "Name=EnvironmentName,Value=${env}" --evaluation-periods 10 --alarm-actions arn:aws:sns:us-east-1:490891715875:ADDA247-ORANGE-ALERT
	if [ ${#ALB} = 0 ];then 
		echo "classic load balancer: "$ELB;
		aws cloudwatch put-metric-alarm --alarm-name ${env}-5xx-Count --alarm-description "${env} 5xx count per minute rising" --metric-name HTTPCode_Backend_5XX  --treat-missing-data notBreaching --namespace AWS/ELB --statistic Sum --period 300 --threshold 10 --comparison-operator GreaterThanOrEqualToThreshold  --dimensions "Name=LoadBalancerName,Value=${ELB}" --evaluation-periods 1 --alarm-actions arn:aws:sns:us-east-1:490891715875:ADDA247-ORANGE-ALERT;
		aws cloudwatch put-metric-alarm --alarm-name ${env}-Latency --alarm-description "${env} High Latency" --metric-name Latency --namespace AWS/ELB --statistic Average --period 300 --threshold 1 --comparison-operator GreaterThanOrEqualToThreshold  --dimensions "Name=LoadBalancerName,Value=${ELB}" --evaluation-periods 3 --alarm-actions arn:aws:sns:us-east-1:490891715875:ADDA247-ORANGE-ALERT;
	else
		echo "application load balancer:"$ALB;
		ALB=${ALB:1}
		aws cloudwatch put-metric-alarm --alarm-name ${env}-5xx-Count --alarm-description "${env} 5xx count per minute rising" --metric-name HTTPCode_ELB_5XX_Count  --treat-missing-data notBreaching --namespace AWS/ApplicationELB --statistic Sum --period 300 --threshold 10 --comparison-operator GreaterThanOrEqualToThreshold  --dimensions "Name=LoadBalancer,Value=${ALB}" --evaluation-periods 3 --alarm-actions arn:aws:sns:us-east-1:490891715875:ADDA247-ORANGE-ALERT
	fi
done < "./prod.txt"
