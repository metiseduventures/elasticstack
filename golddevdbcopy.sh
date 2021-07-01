env=qa;
while read dbname ; do
	newdbname=${env}${dbname};
	echo "Operation: "${dbname}"-->${newdbname}";
	echo "Taking dump od database"; 
	mysqldump -h golddevdb.ck9dm80gifld.ap-south-1.rds.amazonaws.com -uadmin -padda247db ${dbname} > /tmp/dbdump.sql;
	if [[ $? -ne 0 ]]; then
    		echo "Dump failed. Check again. Exiting";
    		exit $?
	fi
	#mysql -h golddevdb.ck9dm80gifld.ap-south-1.rds.amazonaws.com -uadmin -padda247db -e "create database ${newdbname}"; 
done < "golddevdbs.txt"
