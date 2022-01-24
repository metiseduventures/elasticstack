while read pkg ; do
	#echo "Child id : "${childid};
	#`echo "INSERT IGNORE INTO storefront.order_info_new (createdAt,expiry,updatedAt,orderId,child_id,parent_id, email) values(now(),'"${expiry}"',now(),'"${order}"',"${childid}","${pkg}",'"${email}"');" >> ${pkg}.sql;
	echo "update order_info_new set expiry = '2021-09-30 00:00:00' where parent_id in (select id from product_info where package_id = '"${pkg}"') and expiry between '2020-10-31 00:18:30' and '2021-09-30 00:00:00';" >> validityextend.sql;
done < "pkglist.txt"
