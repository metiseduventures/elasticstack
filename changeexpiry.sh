	while read orderid ; do 
	       		echo "value :"${orderid};
			echo "update order_info_new set expiry=adddate(createdAt,interval 7 day) where orderId = '"${orderid}"';" >> file3.sql;
	done < orderids.txt
