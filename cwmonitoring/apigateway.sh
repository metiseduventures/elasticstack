while IFS= read api; do  
	echo "Setting apigateway alert  :"${api}; 
	aws cloudwatch put-metric-alarm --alarm-name ${api}-API-Gateway-5xx-Error --alarm-description "${api} 5xx Errors on API Gateway" --metric-name 5XXError --namespace AWS/ApiGateway --statistic Sum --period 300 --threshold 5 --comparison-operator GreaterThanOrEqualToThreshold  --treat-missing-data notBreaching --dimensions "Name=ApiName,Value=${api}" --evaluation-periods 1 --alarm-actions arn:aws:sns:us-east-1:490891715875:ADDA247-ORANGE-ALERT
	aws cloudwatch put-metric-alarm --alarm-name ${api}-API-Gateway-5xx-Error --alarm-description "${api} 5xx Errors on API Gateway" --metric-name 5XXError --namespace AWS/ApiGateway --statistic Sum --period 300 --threshold 10 --comparison-operator GreaterThanOrEqualToThreshold  --treat-missing-data notBreaching --dimensions "Name=ApiName,Value=${api}" --evaluation-periods 1 --alarm-actions arn:aws:sns:us-east-1:490891715875:ADDA247-RED-ALERT
	aws cloudwatch put-metric-alarm --alarm-name ${api}-API-Gateway-Latency --alarm-description "${api} Latency on API Gateway" --metric-name Latency  --treat-missing-data notBreaching --namespace AWS/ApiGateway --statistic Average --period 300 --threshold 100 --comparison-operator GreaterThanOrEqualToThreshold  --dimensions "Name=ApiName,Value=${api}" --evaluation-periods 2 --alarm-actions arn:aws:sns:us-east-1:490891715875:ADDA247-ORANGE-ALERT
done < "./apig.txt"
