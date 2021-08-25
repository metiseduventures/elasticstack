while IFS= read es; do
        echo "Setting High CPU Check for  :"${es};
        aws cloudwatch put-metric-alarm --alarm-name ${es}-ES-Free-Storage --alarm-description "${es} Free Storage" --metric-name FreeStorageSpace --namespace AWS/ES --statistic Average --period 60 --threshold 10240 --comparison-operator LessThanThreshold  --evaluation-periods 3 --alarm-actions arn:aws:sns:us-east-1:490891715875:ADDA247-ORANGE-ALERT  --dimensions Name=DomainName,Value=${es} Name=ClientId,Value=490891715875
        aws cloudwatch put-metric-alarm --alarm-name ${es}-ES-SearchLatency --alarm-description "${es} Search Latency" --metric-name SearchLatency --namespace AWS/ES --statistic Average --period 60 --threshold 5 --comparison-operator GreaterThanOrEqualToThreshold  --evaluation-periods 3 --alarm-actions arn:aws:sns:us-east-1:490891715875:ADDA247-ORANGE-ALERT  --dimensions Name=DomainName,Value=${es} Name=ClientId,Value=490891715875
        aws cloudwatch put-metric-alarm --alarm-name ${es}-ES-5xx --alarm-description "${es} 5xx" --metric-name 5xx --namespace AWS/ES --statistic Sum --period 60 --threshold 5 --comparison-operator GreaterThanOrEqualToThreshold  --evaluation-periods 3 --alarm-actions arn:aws:sns:us-east-1:490891715875:ADDA247-ORANGE-ALERT  --dimensions Name=DomainName,Value=${es} Name=ClientId,Value=490891715875
        aws cloudwatch put-metric-alarm --alarm-name ${es}-ES-SysMemoryUtilization --alarm-description "${es} System Memory Utilization" --metric-name SysMemoryUtilization --namespace AWS/ES --statistic Average --period 60 --threshold 95 --comparison-operator GreaterThanOrEqualToThreshold  --evaluation-periods 5 --alarm-actions arn:aws:sns:us-east-1:490891715875:ADDA247-RED-ALERT  --dimensions Name=DomainName,Value=${es} Name=ClientId,Value=490891715875
        aws cloudwatch put-metric-alarm --alarm-name ${es}-ES-CPU-Utilization --alarm-description "${es} CPU Utilization" --metric-name CPUUtilization --namespace AWS/ES --statistic Average --period 60 --threshold 90 --comparison-operator GreaterThanOrEqualToThreshold  --evaluation-periods 5 --alarm-actions arn:aws:sns:us-east-1:490891715875:ADDA247-RED-ALERT  --dimensions Name=DomainName,Value=${es} Name=ClientId,Value=490891715875
        aws cloudwatch put-metric-alarm --alarm-name ${es}-ES-WriteLatency --alarm-description "${es} Write Latency" --metric-name WriteLatency --namespace AWS/ES --statistic Average --period 60 --threshold 1 --comparison-operator GreaterThanOrEqualToThreshold --evaluation-periods 3 --alarm-actions arn:aws:sns:us-east-1:490891715875:ADDA247-ORANGE-ALERT --dimensions Name=DomainName,Value=${es} Name=ClientId,Value=490891715875
done < "./es.txt"
