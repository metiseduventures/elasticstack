	filename=deluser.txt
	while read userid  ; do
		echo "Deleting user : "${userid}" at "$(date '+%Y-%m-%d %H:%M:%S')"." >> deletedusers.log;
		mysql -uuserdb -pmetis129 -huserdb-prod.cgit7qfnncrf.us-east-1.rds.amazonaws.com userdb -e "delete FROM userdb.user where email in ('$userid')";
		if [[ $? -ne 0 ]]; then
		          echo "Deleted user with emailid : "${userid};
		fi
	done < "${filename}"
