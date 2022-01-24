#!/usr/bin/env bash

host=54.209.132.93;
key='/home/ec2-user/.ssh/admin-staging.pem';
workspace='/home/ec2-user/react-admin';
branch='amit-temp';


ssh -i ${key} -t ec2-user@${host} 'git -C '"'${workspace}'"' stash ; \ 
	echo '"'Git stash'"' ;\
	git -C '"'${workspace}'"' fetch ; \
	echo '"'Git fetch'"' ;\
	git -C '"'${workspace}'"' checkout '"'${branch}'"'; \
	echo '"'Git checkout'"' ;\
	git -C '"'${workspace}'"' pull origin '"'${branch}'"'; \
	echo '"'Git pull'"' ;\
	cd '"'${workspace}'"'; \
	echo '"'Start npm build'"' ;\
	npm run --prefix '"'${workspace}'"'  build:staging; \
	echo '"'Finished npm build'"' ;\
	';
