while read pkg ; do
	filename1=${pkg}_1.txt
	filename2=${pkg}_2.txt
	while IFS=, read order expiry email ; do  
		#echo "Values   :"${order}" "${expiry}" "${email}; 
		while read childid ; do
			#echo "Child id : "${childid};
			echo "INSERT IGNORE INTO storefront.order_info_new (createdAt,expiry,updatedAt,orderId,child_id,parent_id, email) values(now(),'"${expiry}"',now(),'"${order}"',"${childid}","${pkg}",'"${email}"');" >> ${pkg}.sql;
		done < "${filename2}"	
	done < "${filename1}"
done < "pkglist.txt"
