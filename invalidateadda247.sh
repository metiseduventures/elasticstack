#!/usr/bin/env bash

# storecdn E209ZWD5J6N0HL
#storefrontapi E1HWOBD5WTIE8Y
#search E1TU27Q9CXEVT

arg1="$1";

if [ -z "$arg1" ]; then
	path="/*";
else
	path="$arg1";
fi


aws cloudfront create-invalidation --distribution-id E1O4O1LX4U1MV8 --paths "$path" 

