while IFS= read cfdist; do  
	echo "Setting Cloudfront alert on Distribution :"${cfdist};
	cfname=`aws cloudfront get-distribution --id ${cfdist} --output=text --profile=prod | grep "ALIASICPRECORDALS" | awk '{ print $2}'`;
	if [ ${#cfname} = 0 ];then	
		cfname=`aws cloudfront get-distribution --id ${cfdist} --output=text --profile=prod | grep "arn:aws:cloudfront" | awk '{ print $3}'`
	fi
	aws cloudwatch put-metric-alarm --alarm-name ${cfdist}-Cloudfront-5xx-ErrorRate --alarm-description "${cfname} 5xx Error Rate on Cloudfront Distribution" --metric-name 5xxErrorRate --namespace AWS/CloudFront --statistic Average --period 300 --threshold 5 --comparison-operator GreaterThanOrEqualToThreshold  --dimensions --evaluation-periods 3 --alarm-actions arn:aws:sns:ap-south-1:772389675430:ADDA247-RED-ALERT --profile=prod  --treat-missing-data notBreaching --dimensions Name=Region,Value=Global Name=DistributionId,Value=${cfdist}
	aws cloudwatch put-metric-alarm --alarm-name ${cfdist}-Cloudfront-5xx-ErrorRate-Warn --alarm-description "${cfname} 5xx Error Rate on Cloudfront Distribution" --metric-name 5xxErrorRate --namespace AWS/CloudFront --statistic Average --period 300 --threshold 3 --comparison-operator GreaterThanOrEqualToThreshold  --dimensions --evaluation-periods 3 --alarm-actions arn:aws:sns:ap-south-1:772389675430:ADDA247-ORANGE-ALERT --profile=prod --treat-missing-data notBreaching --dimensions Name=Region,Value=Global Name=DistributionId,Value=${cfdist}
done < "./cfdist-prod.txt"
