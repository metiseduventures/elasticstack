	filename1=orderid.txt
	while read orderid  ; do
			echo "update orders set deleted = true where orderId ='"${orderid}"';" >> deact.sql;
			#echo "INSERT IGNORE INTO storefront.order_info_new (createdAt,expiry,updatedAt,orderId,child_id,parent_id, email) values(now(),'"${expiry}"',now(),'"${order}"',"${childid}","${pkg}",'"${email}"');" >> ${pkg}.sql;
	done < "${filename1}"
