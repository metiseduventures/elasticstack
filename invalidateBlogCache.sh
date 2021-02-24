#!/usr/bin/env bash

# storecdn E209ZWD5J6N0HL
#storefrontapi E1HWOBD5WTIE8Y
#search E1TU27Q9CXEVT

arg1="$1";
path="/*";
profile="prod";

case "$arg1" in
	ba)
		cf="E2CUVMB29ZJDEL" ;;
	ca)
		cf="ENVGCR1DX9HON" ;;
	ea)
		cf="E1OODBM1HUJ7RZ" ;;
	ssc)
		cf="E1AK2BIHIWKARS" ;;
	ta)
		cf="E69EV7K02HNX2" ;;
	jobs)
		cf="E1O4O1LX4U1MV8" ;
		profile="default";
		path="/jobs/*";;
	*)
		echo  "usage: invalidateBlogCache.sh (ba/ca/ea/ta/ssc/jobs)"
		exit 1;
esac



aws cloudfront create-invalidation --distribution-id ${cf} --paths "${path}" --profile=${profile}
