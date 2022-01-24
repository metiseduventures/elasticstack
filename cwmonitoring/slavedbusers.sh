newuser="heStedIO"
newpass="aUDgeNOckErSoRPh"
olduser="slaveuser"

while IFS=: read host user pass ; do  
	echo "Setting User for  :"${host}" "${user}" "${pass}; 
	#mysql -h${host} -u${user} -p${pass} -e "CREATE USER '$newuser'@'%' IDENTIFIED BY '$newpass'";
	#mysql -h${host} -u${user} -p${pass} -e "GRANT SELECT ON *.* TO '$newuser'";
	mysql -h${host} -u${user} -p${pass} -e "REVOKE ALL PRIVILEGES, GRANT OPTION FROM '$olduser'@'%'";
	mysql -h${host} -u${user} -p${pass} -e "DROP USER '$olduser'@'%'";
done < "./slavedbusers.txt"





