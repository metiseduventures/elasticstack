	while IFS=, read id coin ; do  
			#echo "Child id : "${childid};
			echo "INSERT IGNORE INTO userdb.coin_transactions (userId,activityId,coins,detail,state,updatedBy,activityCount,createdAt,expiryDate,isExpired,remainingCoins)
values(${id}, 21, -${coin}, \"EXPIRE_COINS\", 100, 8298538, 1, \"2020-10-29 19:15:00\", \"2021-01-27 19:15:00\", 1, 0.00);" >> file2.sql;
			echo "INSERT IGNORE INTO userdb.coin_transactions (userId,activityId,coins,detail,state,updatedBy,activityCount,createdAt,expiryDate,isExpired,remainingCoins)values(${id}, 23,${coin}, \"DATABASE_MIGRATION\", 100, 8298538, 1, \"2020-10-29 19:15:00\", \"2021-01-27 19:15:00\", 0, ${coin});" >> file2.sql;
	done < test2.txt
