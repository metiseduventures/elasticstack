while IFS= read env; do  
       	asg="$(aws elasticbeanstalk describe-environment-resources --environment-name ${env} --output=text)";
	ASG=`echo "${asg}" | awk -F"\t" '$1=="AUTOSCALINGGROUPS" {print $2}'`;
       	ALB=`echo "${asg}" | grep LOADBALANCERS | awk -F'loadbalancer' '{ print $2}'`;
       	ELB=`echo "${asg}" | grep LOADBALANCERS | awk  '{ print $2}'`;
	if [ ${#ALB} = 0 ];then 
		echo $env":classic load balancer: "$ELB;
	else
		ALB=${ALB:1}
		echo $env":application load balancer: "$ALB;
	fi
done < "./prod.txt"
