dbhost="localhost";
dbuser="heartprairy";
dbpass="cbbmc33JYQE5";
dbname="devops";
dbtable="instancemap";
filename="/home/ec2-user/devops/instances.txt";

aws ec2 describe-instances  --query 'Reservations[*].Instances[*].[InstanceId,PublicIpAddress,PrivateIpAddress,Tags[?Key==`Name`].Value[] | [0]]' --output=text > ${filename};

while read instanceid pubip pvtip host ; do  
	#echo "saving instance details   :"${instanceid}" "${pubip}" "${pvtip}" "${host}; 
	mysql -u$dbuser -p$dbpass -h$dbhost $dbname -e "INSERT IGNORE INTO $dbtable (\`instanceid\`, \`publicip\`, \`privateip\`, \`envName\`, \`updatedat\` ) VALUES ('$instanceid', '$pubip', '$pvtip','$host',now())";
done < "${filename}"
